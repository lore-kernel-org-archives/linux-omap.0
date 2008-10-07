From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] MUSB: BULK request on different available endpoints
Date: Tue, 7 Oct 2008 11:41:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DC1A705A@dbde02.ent.ti.com>
References: <1223358144-19712-1-git-send-email-ajay.gupta@ti.com>
 <200810062304.57833.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYJGGLm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 02:11:42 -0400
In-Reply-To: <200810062304.57833.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "me@felipebalbi.com" <me@felipebalbi.com>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, October 07, 2008 11:35 AM
> To: Gupta, Ajay Kumar
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; me@felipeb=
albi.com
> Subject: Re: [PATCH] MUSB: BULK request on different available endpoi=
nts
>=20
> On Monday 06 October 2008, Ajay Kumar Gupta wrote:
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (is_in)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0musb->periodic[2 * ep->epnum - 2] =3D NULL;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0else
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0musb->periodic[2 * ep->epnum - 1] =3D NULL;
>=20
> Can we use musb->in[], musb->out[] or somesuch?
> Magic index math is kind of error prone ...

Will submit separate patch for this fix.
>=20
>=20
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case USB_ENDPOINT_XFE=
R_CONTROL:
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0case USB_ENDPOINT_XFE=
R_BULK:
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0/* fifo policy for these lists, except that NAKing
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 * should rotate a qh to the end (for fairness).
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 */
>=20
> You just moved that bit earlier.  Please just leave it
> in the same place, so it's easier to tell what changed...

When (qh->mux =3D=3D 0) then qh freeing logic is same as for periodic t=
ransfers so I moved
it above periodic case.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
