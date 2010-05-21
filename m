From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Fri, 21 May 2010 10:45:37 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E535E9B@dbde02.ent.ti.com>
References: <1274360966-9974-1-git-send-email-x0082077@ti.com>
 <602675.31449.qm@web180309.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab0EUFPu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 01:15:50 -0400
In-Reply-To: <602675.31449.qm@web180309.mail.gq1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

Hi,
> > +#ifdef CONFIG_USB_MUSB_OTG
> > +=A0=A0=A0 .mode
> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_OTG,
> > +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> > +=A0=A0=A0 .mode
> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_HOST,
> > +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> >  =A0=A0=A0 .mode
> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
> > +#endif
>=20
> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
> > +#endif
>=20
> By the way ... the #ifdeffery should indeed vanish from all board
> configs except the Davinci DM6446 EVM.

If we are claiming to support:
	A. Same kernel would work on multiple boards
	B. Single kernel for one single board

Then I think these #ifdefferys are required in all the board files.

Let's consider the OMAP3EVM which supports all the three modes and
If these #ifdefferys are not present and .mode is set to OTG.
Then if I choose to compile the Kernel only for peripheral mode
(Case-B above) then I would get below error from musb_core.c.

"incompatible Kconfig role setting"

-Ajay

>  That board is kind of quirky
> in terms of USB support, and needs jumpering to get host or periphera=
l
> mode (and can't do OTG).  I suspect some of the other boards did a ba=
d
> thing and tried emulating what that board did.
>=20
> But the description for such a patch would emphasize removing bogus
> ifdeffery, to match the board hardware (which is not conditional but
> is instead fixed).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
