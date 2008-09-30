From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 09/25] i2c: move twl4030-madc to new registration style
Date: Tue, 30 Sep 2008 14:45:19 -0700
Message-ID: <200809301445.19900.david-b@pacbell.net>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <1222800189-29737-9-git-send-email-me@felipebalbi.com> <1222800189-29737-10-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:29359 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752060AbYI3VpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 17:45:22 -0400
In-Reply-To: <1222800189-29737-10-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Tuesday 30 September 2008, Felipe Balbi wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0ret =3D request_irq(TWL4030_MODIRQ_MADC, twl4=
030_madc_irq_handler,

Likewise:  pass the IRQ through a platform driver resource.
These TWL4030_MODIRQ_* symbols should vanish.

(To fix later.  No reason to hold up this batch of patches
any longer...)


> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =A0IRQF_DISABLED, "twl4030_madc", &twl4030_madc);
> -=A0=A0=A0=A0=A0=A0=A0if (ret)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR TWL4030=
_MADC_PFX "request_irq: %d\n", ret);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =A0IRQF_DISABLED, "twl4030_madc", madc);
> +=A0=A0=A0=A0=A0=A0=A0if (ret) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(&pdev->dev, "co=
uld not request irq\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_irq;
> +=A0=A0=A0=A0=A0=A0=A0}


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
