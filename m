From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] pinctrl: Convert to using %pOFn instead of device_node.name
Date: Wed, 29 Aug 2018 10:31:51 +0200
Message-ID: <4627271.TU6sX7boZt@diego>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-40-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Am Dienstag, 28. August 2018, 03:52:41 CEST schrieb Rob Herring:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

>  drivers/pinctrl/pinctrl-rockchip.c            |  8 ++---

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
