From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] [RESEND] Amstrad Delta: add support for LCD
 contrast
Date: Mon, 7 Dec 2009 13:32:50 -0800
Message-ID: <20091207213250.GI24013@atomide.com>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl>
 <200912051454.52966.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62837 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935561AbZLGVdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 16:33:08 -0500
Content-Disposition: inline
In-Reply-To: <200912051454.52966.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091205 05:54]:
> Monday 23 November 2009 18:57:51 Janusz Krzysztofik napisa=C5=82(a):
> > Initialy submitted on 2009-11-16
> > (http://www.spinics.net/lists/linux-omap/msg20629.html).
> > Resendig due to fbdev mailing list address changed.
> >
> > The series consists of 2 patches:
> >
> >  [PATCH 1/2] omapfb: lcd_ams_delta: add support for contrast contro=
l
> >  [PATCH 2/2] OMAP: ams_delta_defconfig: enable LCD class device sup=
port
> >
> > It is intended for 2.6.33, if it's not too late.
>=20
> Hi,
>=20
> Now that Tony has changed the series status from New to Awaiting Upst=
ream in=20
> his patchwork queue[1][2], chances of getting it in throungh linux-om=
ap tree,=20
> like a few other omapfb related patches managed to do lately, seem fa=
lling=20
> down drastically to me if still not answered by anyone involved in om=
apfb=20
> development.
>=20
> Imre,
> Could you please take the patches, or give your ack for Tony to take =
them, or=20
> just point me on the right way to the get them integrated or NAKed, i=
f none=20
> of the former is?
>=20
> Tomi,
> I am not sure if you are the right person for bothering here, but may=
be you=20
> could give your comments that would help pushing it forward?

I'd prefer Tomi to merge all the drivers/video/omap code rather
than merge it via linux-omap tree. Ideally with an ack from
Imre where possible.

Tony

=20
> Thanks,
> Janusz
>=20
> [1] http://patchwork.kernel.org/patch/62248/
> [2] http://patchwork.kernel.org/patch/62249/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
