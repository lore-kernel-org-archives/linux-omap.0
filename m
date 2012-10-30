From: =?UTF-8?B?UMOpdGVyIFVqZmFsdXNp?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] CLK: clk-twl6040: Initial clock driver for OMAP4+ McPDM
 fclk clock
Date: Tue, 30 Oct 2012 08:39:25 +0100
Message-ID: <508F842D.8000407@ti.com>
References: <1347633027-20731-1-git-send-email-peter.ujfalusi@ti.com> <20121029173008.18780.35000@nucleus>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121029173008.18780.35000@nucleus>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On 10/29/2012 06:30 PM, Mike Turquette wrote:
> Peter,
>=20
> The patch looks good to me.  To be clear, you wan this to go through
> clk-next or the mfd tree for avoiding conflicts?

clk-next is the best place for it I think. The MFD part to register the=
 device
can still wait till we have ccf support on OMAP4.

Thank you,
P=C3=A9ter
