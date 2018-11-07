From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 0/3] ARN: OMAP1: ams-delta: Post-GPIO-refresh cleanups
Date: Wed,  7 Nov 2018 21:17:43 +0100
Message-ID: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org


Janusz Krzysztofik (3):
      ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
      ARM: OMAP1: ams-delta: Drop unused symbols from the board header
      ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file

 board-ams-delta.c |    9 ++++-----
 board-ams-delta.h |   22 ----------------------
 2 files changed, 4 insertions(+), 27 deletions(-)
