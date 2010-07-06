From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Date: Tue, 6 Jul 2010 14:42:56 +0300
Message-ID: <20100706114256.GC8925@nokia.com>
References: <1278104096-27809-1-git-send-email-notasas@gmail.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA06@dbde02.ent.ti.com>
 <20100706100533.GB8925@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044EAADB6B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19273 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab0GFLnJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 07:43:09 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EAADB6B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Tue, Jul 06, 2010 at 01:26:28PM +0200, ext Hiremath, Vaibhav wrote:
>=20
> > -----Original Message-----
> > From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> > Sent: Tuesday, July 06, 2010 3:36 PM
> > To: Hiremath, Vaibhav
> > Cc: Grazvydas Ignotas; linux-fbdev@vger.kernel.org; linux-
> > omap@vger.kernel.org; Valkeinen Tomi (Nokia-MS/Helsinki)
> > Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITF=
ORVSYNC
> >=20
> > On Tue, Jul 06, 2010 at 08:08:14AM +0200, ext Hiremath, Vaibhav wro=
te:
> > > > @@ -648,6 +649,17 @@ int omapfb_ioctl(struct fb_info *fbi, unsi=
gned int
> > cmd,
> > > > unsigned long arg)
> > > >  			r =3D -EFAULT;
> > > >  		break;
> > > >
> > > > +	case FBIO_WAITFORVSYNC:
> > > > +		if (get_user(p.crt, (__u32 __user *)arg)) {
> > > > +			r =3D -EFAULT;
> > > > +			break;
> > > > +		}
> > > > +		if (p.crt !=3D 0) {
> > > > +			r =3D -ENODEV;
> > > > +			break;
> > > > +		}
> > > > +		/* FALLTHROUGH */
> > > > +
> > > >  	case OMAPFB_WAITFORVSYNC:
> > > [Hiremath, Vaibhav] I don't see any reason why we should still ke=
ep old
> > custom IOCTL support here.
> >=20
> > It can already be used so it should not be removed.
> >=20
> [Hiremath, Vaibhav] I am not in favor of this, if we have standard in=
terface then we should encourage people to use it. Don't you think we w=
ill have different interface for OMAP and different for non-omap device=
=2E

What anyone thinks that apps should do doesn't matter. Removing the
ioctl will break the ABI and that is not an acceptable thing to do in
kernel development usually.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
