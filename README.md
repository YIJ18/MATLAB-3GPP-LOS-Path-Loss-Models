# MATLAB LOS and Path Loss Models (3GPP TR 38.901)

This repository contains **MATLAB scripts** for computing **Line-of-Sight (LOS) probabilities**, **path loss**, and **penetration loss** in various 3GPP scenarios.

## Modules

- **m1: UMi LOS Probability**
  - Function: `losProbability_UMI`
  - Computes LOS probability for outdoor and indoor users in Urban Micro (UMi) scenarios.

- **m2: UMA LOS Probability**
  - Function: `losProbability_UMA`
  - Computes LOS probability for Urban Macro (UMA) scenarios, considering different user heights (low, mid, high).

- **m4: Path Loss UMi LOS & NLOS**
  - Functions: `path_loss_UMi_LOS` and `path_loss_UMi_NLOS`
  - Calculates omnidirectional LOS and NLOS path loss in UMi Street Canyon scenarios.
  - Plots LOS/NLOS path loss vs. 2D distance.

- **e3: InH LOS Probability**
  - Functions: `LOS_Probability_InH_Mixed` and `LOS_Probability_InH_Open`
  - Computes LOS probability for **Indoor Hotspot (InH)** scenarios in mixed-office and open-office environments.

- **e5: Path Loss UMa LOS & NLOS**
  - Functions: `path_loss_UMa_LOS` and `path_loss_UMa_NLOS`
  - Calculates omnidirectional LOS and NLOS path loss in Urban Macro (UMa) scenarios.
  - Includes comparison with the CI (Close-In) path loss model.

- **e6: Path Loss InH LOS & NLOS**
  - Functions: `path_Loss_InH_LOS` and `path_Loss_InH_NLOS`
  - Computes LOS and NLOS path loss for Indoor Hotspot scenarios.
  - Includes visualization vs. 3D distance.

- **e7: Penetration Loss**
  - Computes **indoor penetration loss** for low-loss (glass/concrete) and high-loss (IRR glass/concrete) materials.
  - Plots penetration loss vs. indoor distance.

## Usage

1. Clone the repository.
2. Open the MATLAB scripts.
3. Run each script to visualize LOS probabilities, path loss, and penetration loss for UMi, UMA, and InH scenarios.
4. Adjust parameters such as:
   - `d2D`, `d3D`: distances (m)
   - `hUE`: User equipment height
   - `hBS`: Base station height
   - `fc`: Carrier frequency (GHz)
   - Material loss parameters for indoor penetration.

## Reference

- [3GPP TR 38.901: Study on channel model for frequencies from 0.5 to 100 GHz](https://www.3gpp.org/)
