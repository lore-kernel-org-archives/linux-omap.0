From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/7] Nokia N9/N950 misc. DT patches
Date: Sun, 13 Mar 2016 01:06:13 +0100
Message-ID: <1457827580-16919-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are a couple of N950/N9 DT patches. I only tested them
on the Nokia N950, but Filip tested his patches on N9 and
the regulator configuration in Nokia's kernel is the same
for N950 and N9.

The patches are based on 4.5-rc7.

-- Sebastian

=46ilip Matijevi=C4=87 (2):
  ARM: dts: N9/N950: Add support for 1GHz CPU clock
  ARM: dts: N9/N950: Add support for accelerometer

Sebastian Reichel (5):
  ARM: dts: n9/n950: regulator configuration
  ARM: dts: OMAP3-N950: Add Keypad Matrix
  ARM: dts: OMAP3-N950: Add Vibrator
  ARM: dts: Enable N950 keyboard sleep leds by default
  ARM: dts: OMAP3-N950: Add Keypad Slide Switch

 arch/arm/boot/dts/omap3-n9.dts       |  14 ++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 151 +++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/omap3-n950.dts     |  99 +++++++++++++++++++++++
 3 files changed, 264 insertions(+)

--=20
2.7.0
