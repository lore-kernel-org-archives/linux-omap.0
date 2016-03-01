From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dts: omap2+: GPMC NAND node fixes (part 2)
Date: Tue, 1 Mar 2016 15:44:46 +0200
Message-ID: <1456839888-6244-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, fcooper@ti.com, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

These patches are a preparatory step towards the NAND DT cleanup
done in [1].

They mostly deal with adding the missing compatible property and
interrupt resources and fixing up register resources for the
NAND nodes for the boards that add NAND support in v4.6.

Patches based on tony/omap-for-v4.6/dt

cheers,
-roger

Roger Quadros (2):
  ARM: dts: dm814x: dra62x: Fix NAND device nodes
  ARM: dts: dm814x: dra62x: Disable wait pin monitoring for NAND

 arch/arm/boot/dts/dm8148-evm.dts       | 10 ++++++----
 arch/arm/boot/dts/dm814x.dtsi          |  2 ++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 10 ++++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.5.0
