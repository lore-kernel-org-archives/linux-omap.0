From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Date: Mon, 20 Aug 2018 20:13:30 +0200
Message-ID: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org


Convert modem related GPIO setup from integer space to GPIO descriptors.
Also, restore original initialization order of the MODEM device and its
related GPIO pins.

Cleanup of MODEM relaated regulator setup is postponed while waiting for
upcoming conversion of fixed regulator API to GPIO descriptors.


Janusz Krzysztofik (3):
      ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
      ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
      ARM: OMAP1: ams-delta: register MODEM device earlier


diffstat:
 board-ams-delta.c |  120 +++++++++++++++++++++++++++++++++++++++---------------
 board-ams-delta.h |    7 ---
 2 files changed, 88 insertions(+), 39 deletions(-)
