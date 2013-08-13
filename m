From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Tue, 13 Aug 2013 15:20:08 -0700
Message-ID: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48104 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255Ab3HMWUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 18:20:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This is v4 of the OPP50 (VDD CORE 0.95V during suspend) patch set.

Adjusting voltages to this lower operating point during suspend saves
additional power. This operating point can only be reached when SDRAM is
in self refresh and certain DPLLs have been put into bypass mode. This
means that the code to change the regulator to run at the correct voltage
must be run from either SRAM or the Cortex-M3 (CM3) PM co-processor must
perform the action.

As different boards will power VDD CORE through different methods, the
necessary steps must be contained within the device tree. In order to
accommodate this, additional device tree properties have been created that
can be placed in I2C bus nodes. The properties give a sequence of I2C
commands that should be run at suspend and resume time.

The purpose and method of executing these sequences is left up to each
platform. In the case of the am33xx, the CM3 firmware writes out the
simple I2C sequences.

Each sequence is a series of I2C write commands. The first byte is the
length of the write, the second byte the I2C device to address, and the
following bytes are the message.

Example:

i2c0: i2c@44e0b000 {
	pinctrl-names = "default";
	pinctrl-0 = <&i2c0_pins>;

	status = "okay";
	clock-frequency = <400000>;
 
	/* Set OPP50 (0.95V) for VDD core */
	sleep_sequence = /bits/ 8 <
		0x02 0x2d 0x25 0x1f /* Set VDD2 to 0.95V */
	>;

	/* Set OPP100 (1.10V) for VDD core */
	wake_sequence = /bits/ 8 <
		0x02 0x2d 0x25 0x2b /* Set VDD2 to 1.1V */
	>;

	tps: tps@2d {
		reg = <0x2d>;
	};
};

In the above example, the sequence "0x25 0x1f" is written to the I2C
device at address 0x2d (the TPS65910 PMIC). The PMIC interprets that as
a write to a register at address 0x25.

I'd really like to get some feedback on the devicetree bindings.

The patch set depends on the latest am335x suspend resume patch set from Dave
Gerlach[1], which also depends on the latest Mailbox patch set from Suman
Anna[2], and the latest CM3 firmware[3].

Changes since v1:
* Rebased onto new am335x PM branch
* Changed to use 5th param register

Changes since v2:
* Pass bus speed in kHz to M3 firmware

Changes since v3:
* Rebase to Dave Gerlach's am335x suspend/resume patch set
* Add device tree documentation
* Add dts changes for evmsk and gp evm

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/102561
[2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/258196
[3] http://arago-project.org/git/projects/?p=am33x-cm3.git;a=shortlog;h=refs/heads/next2

Russ Dill (4):
  ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
  ARM: dts: add AM33XX vdd core opp50 suspend for Beaglebone.
  ARM: dts: add AM33XX vdd core opp50 suspend for AM335X GP EVM.
  ARM: dts: AM33XX vdd core opp50 suspend for EVM-SK

 .../devicetree/bindings/i2c/i2c-suspend-resume.txt | 44 +++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  | 25 +++++-
 arch/arm/boot/dts/am335x-evm.dts                   | 10 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 | 10 +++
 arch/arm/mach-omap2/control.c                      |  1 +
 arch/arm/mach-omap2/pm33xx.c                       | 89 ++++++++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h                       |  2 +
 arch/arm/mach-omap2/wkup_m3.c                      | 57 ++++++++++++--
 8 files changed, 230 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-suspend-resume.txt

-- 
1.8.3.2

