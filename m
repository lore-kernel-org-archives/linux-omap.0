From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2 v2] gpio-omap: ensure a stable gpio numbering
Date: Tue, 14 Jun 2016 20:57:10 +0200
Message-ID: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hello,

this series' first patch is v2 of the patch I sent earlier. This now al=
so
compiles without CONFIG_OF_GPIO.

The second patch is new and adds the respective aliases to all device t=
rees
that make use of the gpio-omap driver.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (2):
  gpio: omap: make gpio numbering deterministical by using of aliases
  ARM: dts: add aliases for ti,omap[234]-gpio devices

 arch/arm/boot/dts/am33xx.dtsi   |  4 ++++
 arch/arm/boot/dts/am4372.dtsi   |  6 ++++++
 arch/arm/boot/dts/dm814x.dtsi   |  2 ++
 arch/arm/boot/dts/dm816x.dtsi   |  2 ++
 arch/arm/boot/dts/dra7.dtsi     |  8 ++++++++
 arch/arm/boot/dts/omap2420.dtsi |  7 +++++++
 arch/arm/boot/dts/omap2430.dtsi |  8 ++++++++
 arch/arm/boot/dts/omap3.dtsi    |  6 ++++++
 arch/arm/boot/dts/omap4.dtsi    |  6 ++++++
 arch/arm/boot/dts/omap5.dtsi    |  8 ++++++++
 drivers/gpio/gpio-omap.c        | 19 ++++++++++++++++++-
 11 files changed, 75 insertions(+), 1 deletion(-)

--=20
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
