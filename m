From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/2] OMAP3 ROM Random Number Generator support
Date: Wed, 18 Sep 2013 22:05:55 +0200
Message-ID: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
References: <201303281854.02847@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201303281854.02847@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This two patches adding support for OMAP3 ROM Random Number Generator o=
n Nokia N900.

Pali Roh=C3=A1r (2):
  hwrng: OMAP3 ROM Random Number Generator support
  RX-51: Add support for OMAP3 ROM Random Number Generator

 arch/arm/mach-omap2/board-rx51.c       |   10 +++
 arch/arm/mach-omap2/omap-secure.c      |   11 +++
 arch/arm/mach-omap2/omap-secure.h      |    1 +
 drivers/char/hw_random/Kconfig         |   13 +++
 drivers/char/hw_random/Makefile        |    1 +
 drivers/char/hw_random/omap3-rom-rng.c |  145 ++++++++++++++++++++++++=
++++++++
 6 files changed, 181 insertions(+)
 create mode 100644 drivers/char/hw_random/omap3-rom-rng.c

--=20
1.7.10.4
