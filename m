From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 00/10] ARM: dts: TI: Add CAN support
Date: Thu, 13 Nov 2014 14:22:41 +0200
Message-ID: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

These patches add CAN support for am33xx, am43xx and dra7 platforms.
They can go in independent of [1] but depend on [1] for functionality.

Tested on am335x-evm, am437x-gp-evm and dra7-evm.

NOTE:
- for DCAN to work on DRA7 we need this patch to keep the CAN PHY powered.
https://lkml.org/lkml/2014/10/21/484

- on DRA7 there is another issue which causes undesired behaviour if WKUPAON and
L4CFG clock domains are allowed to HW_AUTO. Undesired behaviour is in the form
of DCAN1 module being stuck-in-transition when disabled and RAMINIT-done bit
not getting set as part of RAMINIT mechanism. To address these issues there is a patch
to prevent these clockdomains from HW_AUTO.
https://github.com/rogerq/linux/commit/31d6da939dbbaf8ea2ab96ca5680b81cd5607e51
Even without this second patch DCAN seems to work.

cheers,
-roger

Changelog:

v4:
- added CAN instance number to "syscon-raminit" and use new compatible ids

v3:
- Move raminit register data into driver data
- rename syscon property to "syscon-raminit"

v2:
- Added vendor prefix "ti," to raminit properties
- Updated am335x dcan nodes

[1] - CAN driver RAMINIT Syscon support
http://article.gmane.org/gmane.linux.can/6892

cheers,
-roger

---
Mugunthan V N (1):
  arm: dts: am437x-gp: Add dcan support

Roger Quadros (9):
  ARM: dts: dra7: Add syscon regmap for CORE CONTROL area
  ARM: dts: DRA7: Add DCAN nodes
  ARM: dts: dra7-evm: Add CAN support
  ARM: dts: dra72-evm: Add CAN support
  ARM: dts: am4372: Add control module syscon node
  ARM: dts: am4372: Add DCAN nodes
  ARM: dts: am33xx: Add control module syscon node
  ARM: dts: am33xx: Update DCAN nodes
  ARM: dts: am335x-evm: Add DCAN1 details

 arch/arm/boot/dts/am335x-evm.dts    | 13 +++++++++++++
 arch/arm/boot/dts/am33xx.dtsi       | 25 +++++++++++++++++--------
 arch/arm/boot/dts/am4372.dtsi       | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts      | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi         | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts     | 23 +++++++++++++++++++++++
 7 files changed, 156 insertions(+), 8 deletions(-)

-- 
1.8.3.2

