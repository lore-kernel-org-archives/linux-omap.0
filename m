From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Date: Tue, 6 Jul 2010 13:05:33 +0300
Message-ID: <20100706100533.GB8925@nokia.com>
References: <1278104096-27809-1-git-send-email-notasas@gmail.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61526 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab0GFKFl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 06:05:41 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EAADA06@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Tue, Jul 06, 2010 at 08:08:14AM +0200, ext Hiremath, Vaibhav wrote:
> > @@ -648,6 +649,17 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned=
 int cmd,
> > unsigned long arg)
> >  			r =3D -EFAULT;
> >  		break;
> >=20
> > +	case FBIO_WAITFORVSYNC:
> > +		if (get_user(p.crt, (__u32 __user *)arg)) {
> > +			r =3D -EFAULT;
> > +			break;
> > +		}
> > +		if (p.crt !=3D 0) {
> > +			r =3D -ENODEV;
> > +			break;
> > +		}
> > +		/* FALLTHROUGH */
> > +
> >  	case OMAPFB_WAITFORVSYNC:
> [Hiremath, Vaibhav] I don't see any reason why we should still keep o=
ld custom IOCTL support here.=20

It can already be used so it should not be removed.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
