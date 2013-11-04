From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH RFC] clk: add gpio controlled clock
Date: Mon, 4 Nov 2013 09:21:04 +0100
Message-ID: <20131104092104.4b60d715@ipc1.ka-ro>
References: <cover.1383312867.git.jsarha@ti.com>
	<c52a7910c6ce33ceed0f38b89953527eee06b0b5.1383312867.git.jsarha@ti.com>
	<20131104084227.3323f98e@ipc1.ka-ro>
	<0EB243F40EB34A418EAED8001C4B3AD019EA5EF2@DNCE05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:52388 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3KDIVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Nov 2013 03:21:31 -0500
In-Reply-To: <0EB243F40EB34A418EAED8001C4B3AD019EA5EF2@DNCE05.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sarha, Jyri" <jsarha@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>

Hi,

Sarha, Jyri wrote:
> >
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tun=
nus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20
> -----Original Message-----
> >From: Lothar Wa=C3=9Fmann [mailto:LW@KARO-electronics.de]
> >Sent: Monday, November 04, 2013 9:42 AM
> >
> >Hi,
> >
> >Jyri Sarha wrote:
> >> The added clk-gpio is a basic clock that can be enabled and disabl=
ed
> ...
> >> +    err =3D gpio_request_one(gpio, gpio_flags, name);
> >> +    if (err) {
> >> +            pr_err("%s: Error requesting clock control gpio %u\n"=
,
> >> +                   __func__, gpio);
> >> +            return ERR_PTR(-EINVAL);
> >>
> >You already have an error code from the gpio_request_one() call.
> >Why return a different one?
>=20
> I was just thinking the gpio number is more useful for debugging that=
 the error code. Could print the both of cource.
>=20
I wasn't talking about the error message, but the return value of the
function!


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
