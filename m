From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Missing pieces for AM335x PWM / backlight support
Date: Thu,  6 Jun 2013 15:52:35 +0200
Message-ID: <1370526759-31163-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.breakpoint.cc/bigeasy/linux.git tags/am335x-pwm

for you to fetch changes up to 6b319b16a27463c93ec36e59458448aae3ab94cd:

  ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk (2013-06-06 14:59:18 +0200)

----------------------------------------------------------------
Collected patches from Philip Avinash to get PWM working on AM335x-evm.
The series includes the TBCLK and device tree entries.

----------------------------------------------------------------
Philip Avinash (4):
      ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
      ARM: dts: AM33XX: Add PWMSS device tree nodes
      ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
      ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk

 arch/arm/boot/dts/am335x-evm.dts      |   23 +++++++++
 arch/arm/boot/dts/am335x-evmsk.dts    |   23 +++++++++
 arch/arm/boot/dts/am33xx.dtsi         |   84 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cclock33xx_data.c |   30 ++++++++++++
 arch/arm/mach-omap2/control.h         |    8 ++++
 5 files changed, 168 insertions(+)

Sebastian
