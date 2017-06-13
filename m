From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/5] OMAP4: crypto support
Date: Tue, 13 Jun 2017 11:28:42 +0200
Message-ID: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds crypto support for OMAP4, which was missing for some reason.
This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
DES are working according to selftest.

Changes since PATCHv1:
 * remove patch adding des_fck to DT
 * add patch removing aes[12]_fck from DT
 * add patch renaming hwmod aes to aes1 in DT
 * update hwmod patches according to feedback from Tero
 * add patch for aes2 hwmod

-- Sebastian

Sebastian Reichel (5):
  ARM: dts: omap4: Fix aes entry
  ARM: dts: omap4.dtsi: remove aes[12]_fck
  ARM: OMAP4: hwmod data: add aes1
  ARM: OMAP4: hwmod data: add aes2
  ARM: OMAP4: hwmod data: add des

 arch/arm/boot/dts/omap4.dtsi               |   4 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi     |  16 -----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 100 +++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 18 deletions(-)

-- 
2.11.0
