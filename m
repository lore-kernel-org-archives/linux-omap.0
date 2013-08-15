From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Thu, 15 Aug 2013 22:01:20 +0200
Message-ID: <CACRpkda+m82PYJsExLM6JLsLa8-bVhdvy_r_+-uKfVT2NG7Cbg@mail.gmail.com>
References: <51E83A4F.5080904@ti.com>
	<CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com>
	<51ED2385.60108@ti.com>
	<51ED5C66.1010407@ti.com>
	<51EFFBE1.4090505@ti.com>
	<51F0031B.1050307@ti.com>
	<51F00530.9090703@ti.com>
	<51F02069.3050207@ti.com>
	<51F0223E.4050008@ti.com>
	<51F0240F.3050507@ti.com>
	<20130813081003.GU7656@atomide.com>
	<520A02BA.4090805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <520A02BA.4090805@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 13, 2013 at 11:56 AM, Sricharan R <r.sricharan@ti.com> wrote:

>  Initially irqchip was discussed, but we also have a DMA crossbar
>  to map the dma-requests. Since both irq/dma crossbars should be handled,
>  pinctrl was suggested as the appropriate place to handle this.

I think it is better to use irqchip.

For DMA there is already an arbiter mechanism for arbitration of
virtual channels over physical channels, this is not much different,
the DMA might need some different tweaking but should be solved
in that subsystem I think.

I don't see any way to really abstract this pretty simple crossbar
for reuse across subsystems.

Yours,
Linus Walleij
