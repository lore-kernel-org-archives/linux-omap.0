From: David Brownell <david-b@pacbell.net>
Subject: Re: leds-gpio broken with current git?
Date: Mon, 23 Feb 2009 13:04:22 -0800
Message-ID: <200902231304.22137.david-b@pacbell.net>
References: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl> <200901150758.49601.david-b@pacbell.net> <8F7AF80515AF0D4D93307E594F3CB40E210F49EC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:37512 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751961AbZBWVEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 16:04:25 -0500
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E210F49EC@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Monday 23 February 2009, Kridner, Jason wrote:
>=20
> > Works for me, no "-EINVAL", on 2.6.28-omap1 and no patches
> > that should affect GPIOs or LEDs. =A0Last patch applied to
> > GIT is 15f75b6226c2d3b82062bb721e7cb9a1d6f35efd (musbhsdma).
> >=20
> > OK, I'm just pulling a new batch of objects, I'm guessing
> > Tony snuck in RC1 already ... yes, I see he just sent a
> > post about that a few minutes ago. =A0;)
>=20
> Perhaps something broke with Tony's RC1 merge?
> The LEDs are broken for me as well.=20

Still works for me.  Did you maybe not enable the twl4030
GPIO support in Kconfig?

- dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
