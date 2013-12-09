From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
Date: Mon, 9 Dec 2013 14:09:19 +0100
Message-ID: <CACRpkdb1XEJjykRD3MGmjHvTX40JtTZU7uDRAvpGLBdoREChmw@mail.gmail.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-6-git-send-email-tony@atomide.com>
	<529DDCE3.5020902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <529DDCE3.5020902@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 3, 2013 at 2:30 PM, Roger Quadros <rogerq@ti.com> wrote:

(...)
> This patch causes a regression with LED outputs (GPO) on twl4030 on 3.13-rc2.
> As one of the LED GPO is used for USB host on beagleboard, it will cause failure
> of USB host probe.
(...)
> Below is a proposed fix for this.

Roger, Tony: what happened with this? Have you hashed this out?
I ACK Roger's fixup too if that needs to be merged into the OMAP
tree.

Yours,
Linus Walleij
