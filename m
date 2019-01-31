From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/2] arm: dts: gta04: add gps support
Date: Thu, 31 Jan 2019 19:06:38 +0100
Message-ID: <20190131180640.14480-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, letux-kernel@openphoenux.org, tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

This patch series adds support for gps for gta04. Formerly
it was a single patch, now a non-controllable regulator was
added for completeness sake and to satisty binding
requirements.

Andreas Kemnade (2):
  arm: dts: gta04: add ldo 3v3 regulator
  arm: dts: gta04: add gps support

 arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.11.0
