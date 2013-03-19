From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 00/11] ARM: dts: OMAP5: ocp address space and few updates for 3.10
Date: Tue, 19 Mar 2013 19:00:46 +0530
Message-ID: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50248 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab3CSN3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 09:29:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Benoit,

Here is the branch rebased and updated against your 'for_3.10/dt' branch.
Few minor updates about ocp/l3 node after our discussion at connect from
last version. The series also contains couple of hwmod patches to deal
with ocp address space from dt blob and avoiding iormap for some of
the hwmods.

It has been tested on OMAP4 and OMAP5 devices. Though for OMAP5 testing, data
files and other patches are needed which are also targeted for 3.10 merge
window.

The following changes since commit 44fab7a60d4c3929a04b7dc882ac1143b3f21b0f:

  ARM: dts: omap3-devkit8000: Add NAND DT node (2013-03-18 15:01:23 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_dt_update

for you to fetch changes up to c0c153b52b9ed4965b7496e462b2effa3e4fa9ce:

  ARM: OMAP2+: omap_hwmod: Don't call _init_mpu_rt_base if no sysc (2013-03-19 17:11:39 +0530)

----------------------------------------------------------------

Lokesh Vutla (1):
  ARM: dts: OMAP5: Add watchdog timer node

Rajendra Nayak (1):
  ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer

Santosh Shilimkar (9):
  ARM: dts: omap5-evm: Update available memory to 2032 MB
  ARM: dts: OMAP5: Align the local timer dt node as per the current
    binding code
  ARM: dts: OMAP5: Move the gic node out of ocp space
  ARM: dts: OMAP5: Update the timer and gic nodes for HYP kernel
    support
  ARM: dts: OMAP5: Update keypad reg property
  Documentation: dt: OMAP: l3-noc: Add *reg* in required properties
  ARM: dts: OMAP4/5: Update l3-noc dt nodes
  ARM: OMAP2+: hwmod: extract module address space from DT blob
  ARM: OMAP2+: omap_hwmod: Don't call _init_mpu_rt_base if no sysc

 .../devicetree/bindings/arm/omap/l3-noc.txt        |    1 +
 arch/arm/boot/dts/omap4.dtsi                       |    5 ++
 arch/arm/boot/dts/omap5-evm.dts                    |    2 +-
 arch/arm/boot/dts/omap5.dtsi                       |   56 +++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod.c                   |   48 +++++++++++++++--
 5 files changed, 87 insertions(+), 25 deletions(-)

-- 
1.7.9.5

