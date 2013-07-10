From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 0/2] arm: omap: RX-51: ARM errata 430973 workaround
Date: Wed, 10 Jul 2013 14:59:03 +0200
Message-ID: <1373461145-9812-1-git-send-email-pali.rohar@gmail.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch adds RX-51 specific SMC support and sets IBE bit in ACTLR du=
ring
board init code for ARM errata 430973 workaround.

This is second version of patch which simplifing API and moving all boa=
rd
functions to one file board-rx51.c. Wrapper around smc #1 instruction i=
s in
omap-smc.S file because some other board may use it too.

Pali Roh=C3=A1r (2):
  ARM: OMAP: Add secure function omap_smc3() which calling instruction
    smc #1
  RX-51: ARM errata 430973 workaround

 arch/arm/mach-omap2/board-rx51.c  |   78 +++++++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/omap-secure.h |    1 +
 arch/arm/mach-omap2/omap-smc.S    |   22 ++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)

--=20
1.7.10.4
