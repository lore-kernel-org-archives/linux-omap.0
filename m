From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Date: Tue, 6 Jul 2010 16:56:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EAADB6B@dbde02.ent.ti.com>
References: <1278104096-27809-1-git-send-email-notasas@gmail.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA06@dbde02.ent.ti.com>
 <20100706100533.GB8925@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063Ab0GFL0f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 07:26:35 -0400
In-Reply-To: <20100706100533.GB8925@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>


> -----Original Message-----
> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> Sent: Tuesday, July 06, 2010 3:36 PM
> To: Hiremath, Vaibhav
> Cc: Grazvydas Ignotas; linux-fbdev@vger.kernel.org; linux-
> omap@vger.kernel.org; Valkeinen Tomi (Nokia-MS/Helsinki)
> Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFOR=
VSYNC
>=20
> On Tue, Jul 06, 2010 at 08:08:14AM +0200, ext Hiremath, Vaibhav wrote=
:
> > > @@ -648,6 +649,17 @@ int omapfb_ioctl(struct fb_info *fbi, unsign=
ed int
> cmd,
> > > unsigned long arg)
> > >  			r =3D -EFAULT;
> > >  		break;
> > >
> > > +	case FBIO_WAITFORVSYNC:
> > > +		if (get_user(p.crt, (__u32 __user *)arg)) {
> > > +			r =3D -EFAULT;
> > > +			break;
> > > +		}
> > > +		if (p.crt !=3D 0) {
> > > +			r =3D -ENODEV;
> > > +			break;
> > > +		}
> > > +		/* FALLTHROUGH */
> > > +
> > >  	case OMAPFB_WAITFORVSYNC:
> > [Hiremath, Vaibhav] I don't see any reason why we should still keep=
 old
> custom IOCTL support here.
>=20
> It can already be used so it should not be removed.
>=20
[Hiremath, Vaibhav] I am not in favor of this, if we have standard inte=
rface then we should encourage people to use it. Don't you think we wil=
l have different interface for OMAP and different for non-omap device.

Thanks,
Vaibhav
> --
> Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
