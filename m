From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Non-urgent fixes and improvments for omap3-rom-rng
Date: Fri, 13 Sep 2019 15:09:16 -0700
Message-ID: <20190913220922.29501-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are fixes and improvments for omap3-rom-rng that's been broken for
a while.

The first four patches get it working, and then the last two patches add
support for runtime PM.

Regards,

Tony


Tony Lindgren (6):
  ARM: OMAP2+: Check omap3-rom-rng for GP device instead of HS device
  hwrng: omap3-rom - Fix missing clock by probing with device tree
  hwrng: omap3-rom - Call clk_prepare() on init and exit only
  hwrng: omap3-rom - Initialize default quality to get data
  hwrng: omap3-rom - Update to use standard driver data
  hwrng: omap3-rom - Use runtime PM instead of custom functions

 .../devicetree/bindings/rng/omap3_rom_rng.txt |  27 +++
 arch/arm/boot/dts/omap3-n900.dts              |   6 +
 arch/arm/mach-omap2/pdata-quirks.c            |  14 +-
 drivers/char/hw_random/omap3-rom-rng.c        | 186 ++++++++++++------
 4 files changed, 162 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.txt

-- 
2.23.0
