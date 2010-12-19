From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] MTD: NAND: ams-delta: drop omap_read/write, use ioremap
Date: Sun, 19 Dec 2010 19:03:33 +0200
Message-ID: <1292778213.13362.9.camel@koala>
References: <201012151543.46341.jkrzyszt@tis.icnet.pl>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:59539 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab0LSRDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 12:03:41 -0500
Received: by fxm18 with SMTP id 18so2294928fxm.2
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 09:03:40 -0800 (PST)
In-Reply-To: <201012151543.46341.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, 2010-12-15 at 15:43 +0100, Janusz Krzysztofik wrote:
> There is a common requirement for not using OMAP specific omap_readw(=
) /=20
> omap_writew() function calls in drivers/, but replace them with=20
> readw() / writew() on ioremap()ped addresses passed from arch/ instea=
d.
>=20
> The patch implements this idea for the Amstrad Delta NAND driver. To =
be=20
> able to use the modified driver, the board file is updated with the=20
> platform device I/O resource declaration, which is passed from there.
>=20
> Created and tested against linux-2.6.37-rc5, on top of recent patch=20
> 'MTD: NAND: ams-delta: convert to platform driver'.
>=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Pushed to l2-mtd-2.6.git, thanks!

--=20
Best Regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
