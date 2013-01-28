From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage gadget->dev
Date: Mon, 28 Jan 2013 21:18:29 +0100
Message-ID: <87txq1m57u.fsf@free.fr>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
	<1359042370-4358-30-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1359042370-4358-30-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Thu, 24 Jan 2013 17:46:07 +0200")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, eric.y.miao@gmail.com, kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com, nicolas.ferre@atmel.com, linux-geode@lists.infradead.org, haojian.zhuang@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk, leoli@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Felipe Balbi <balbi@ti.com> writes:

> By simply setting a flag, we can drop some
> boilerplate code.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/pxa27x_udc.c | 9 +--------
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

And I tested also your patch and it works in my environment. For next patches
I'd like to be CCed for pxa27x_udc stuff as I'm maintaining that one since its
beginning (and yes, I know, I didn't put that in MAINTAINERS ...).

Cheers.

--
Robert
