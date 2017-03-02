From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/8] Droid4 DTS update
Date: Thu,  2 Mar 2017 02:08:52 +0100
Message-ID: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Tony, since your omap4-droid4 dts patches were not
yet in a public repository and they would merge conflict
with my patches I put them all together into a single
patchset. I also added my Tested-By to your patches.

The mounting-matrix for the sensors and the touchscreen's 
rotation assume, that the phone's default rotation is vertical.
I think that's sensible, because

 * Android on the phone uses this as default rotation
   (like almost? all other phones)
 * volume buttons make sense (in horizontal position one
   would expect, that left button means lower volume. I
   know at least Maemo swaps them)

That should cover all mainline drivers.

-- Sebastian

Sebastian Reichel (6):
  ARM: dts: omap4-droid4: Add gpio-keys
  ARM: dts: motorola-cpcap-mapphone: add rtc
  ARM: dts: motorola-cpcap-mapphone: add pwrbutton
  ARM: dts: omap4-droid4: Add compass
  ARM: dts: omap4-droid4: Add accelerometer
  ARM: dts: omap4-droid4: Add touchscreen

Tony Lindgren (2):
  ARM: dts: omap4-droid4: Configure regulators
  ARM: dts: omap4-droid4: Add keypad support

 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 164 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts       | 165 +++++++++++++++++++++----
 2 files changed, 308 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi

-- 
2.11.0
