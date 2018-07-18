From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap accessors for data I/O
Date: Thu, 19 Jul 2018 01:57:02 +0200
Message-ID: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure").

 arch/arm/mach-omap1/board-ams-delta.c |   22 -
 drivers/gpio/gpio-omap.c              |   88 ++++++
 drivers/mtd/nand/raw/ams-delta.c      |  436 +++++++++++++++++++++-------------
 3 files changed, 376 insertions(+), 170 deletions(-)
