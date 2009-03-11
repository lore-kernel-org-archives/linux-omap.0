From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when resuming
Date: Tue, 10 Mar 2009 19:33:50 -0800
Message-ID: <200903102033.51026.david-b@pacbell.net>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com> <4d34a0a70902222141y345a7bc3g314e6de5df156f2d@mail.gmail.com> <49A258A2.2020408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n22a.bullet.mail.mud.yahoo.com ([68.142.207.188]:28174 "HELO
	n22a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752557AbZCKDdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2009 23:33:54 -0400
In-Reply-To: <49A258A2.2020408@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: Kim Kyuwon <chammoru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <q1.kim@samsung.com>, =?utf-8?q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>

On Monday 23 February 2009, Adrian Hunter wrote:
> Although I have not tested it, I very much doubt
> dual-voltage cards work. =A0That is because VMMC1_185V
> is zero, which has the side-effect of turning the
> regulator off (see arch/arm/mach-omap2/mmc-twl4030.c)

And a second reason to know they don't quite work ... in
the file drivers/mmc/host/omap_hsmmc.c, omap_mmc_set_ios()
sets the voltage for MMC_POWER_OFF (0) or MMC_POWER_UP (1_,
which gives the initial setting -- e.g. 3.15 Volts, so it
can enumerate at the high range.

But after enumerating the card at that voltage, checking
the OCR values, and concluding that the slot and card can
both run at 1.85V ... the MMC_POWER_ON (2) code is used.
But the driver completely ignores it ... the low voltage
(more power-efficient!) voltage range never kicks in.

It'd be nice to have a nice unambiguous set_voltage()
request from the MMC core.  The set_ios() thing has
always been confusing.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
