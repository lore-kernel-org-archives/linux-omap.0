From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 0/3] OMAP3 ROM Random Number Generator support
Date: Fri, 20 Sep 2013 15:25:04 +0200
Message-ID: <1379683507-30793-1-git-send-email-pali.rohar@gmail.com>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch series adding support for OMAP3 ROM Random Number Generator =
on Nokia N900.
In previous version I forgot to send patch which changing clk dev id to=
 new driver name.

Pali Roh=C3=A1r (3):
  omap2: Change clk dev id for rng to omap3-rom-rng
  hwrng: OMAP3 ROM Random Number Generator support
  RX-51: Add support for OMAP3 ROM Random Number Generator

 arch/arm/mach-omap2/board-rx51-peripherals.c |   19 ++++
 arch/arm/mach-omap2/cclock3xxx_data.c        |    2 +-
 arch/arm/mach-omap2/omap-secure.c            |   11 ++
 arch/arm/mach-omap2/omap-secure.h            |    1 +
 drivers/char/hw_random/Kconfig               |   13 +++
 drivers/char/hw_random/Makefile              |    1 +
 drivers/char/hw_random/omap3-rom-rng.c       |  141 ++++++++++++++++++=
++++++++
 7 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/hw_random/omap3-rom-rng.c

--=20
1.7.10.4
