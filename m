From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when  resuming
Date: Fri, 20 Feb 2009 13:11:43 -0800
Message-ID: <200902201311.44056.david-b@pacbell.net>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:31906 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752270AbZBTVLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2009 16:11:46 -0500
In-Reply-To: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx, =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <q1.kim@samsung.com>, =?utf-8?q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>

On Friday 20 February 2009, Kim Kyuwon wrote:
> +static void omap_hsmmc_init(struct mmc_omap_host *host)
> +{
> +=A0=A0=A0=A0=A0=A0=A0u32 hctl, capa, value;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Only MMC1 supports 3.0V */
> +=A0=A0=A0=A0=A0=A0=A0if (host->id =3D=3D OMAP_MMC1_DEVID) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hctl =3D SDVS30;

Shouldn't it be remembering what voltage it was using,
and then restore that, instead of always making MMC1
restart at a 3.0V level?  That's pretty awkward to test
unless you have a 1.8V-capable card in MMC1...

Somewhat related:  I think the PBIAS register updates
should be moved out of mach-omap2/mmc-twl4030.c into
this driver.  They're needed no matter what flavor
regulator is used to with MMC1 voltage over 1.8V,
and it's a bit odd to split the state machine for
1.8V -vs- 3.0V I/O voltages the way it's now done.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
