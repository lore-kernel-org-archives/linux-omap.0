From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Fri, 26 Nov 2010 17:38:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
 <20101124163100.GB5681@nokia.com>
 <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
 <yw1xeia81nts.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57517 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab0KZMIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 07:08:19 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Friday, November 26, 2010 5:34 PM
> To: 'M=E5ns Rullg=E5rd'; linux-omap@vger.kernel.org
> Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>=20
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of M=E5ns Rullg=E5rd
> > Sent: Friday, November 26, 2010 2:09 PM
> > To: linux-omap@vger.kernel.org
> > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> >
> > "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> >
> > >> -----Original Message-----
> > >> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> > >> Sent: Wednesday, November 24, 2010 10:01 PM
> > >> To: Hiremath, Vaibhav
> > >> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
> > >> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > >>
> > >> On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaibhav
> wrote:
> > >> >
> > >> > > -----Original Message-----
> > >> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > >> > > Sent: Wednesday, November 24, 2010 2:28 PM
> > >> > > To: Hiremath, Vaibhav
> > >> > > Cc: linux-omap@vger.kernel.org
> > >> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > >> > >
> > >> > > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wro=
te:
> > >> > > > Hi,
> > > <snip>
> > >> >
<snip..>
>=20
> > > As far as WAITFORGO is concerned, I think GO bit concept is
> > > something OMAP notion/term and doesn't make sense to standardize
> > > it. Atleast I am not aware of any other architecture having GO bi=
t.
> >
> > Naming is minor detail.  Feel free to suggest a better one.
> >
> [Hiremath, Vaibhav] If I fail to convince on this, then I think the o=
nly
> left option is to make WAITFORGO ioctl generic. And put a disclaimer =
on
> WAITFORVSYNC, it must not be used in panning use-case.
>=20
>=20
[Hiremath, Vaibhav] Also let me bring another point here,

If I understand correctly most of the application libraries (DirectFB, =
X, etc..) does use FBIO_WAITFORVSYNC to synchronize with HW, and manage=
 ping pong mechanism.

With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO (br=
eaking standard applications).

Thanks,
Vaibhav

> > --
> > M=E5ns Rullg=E5rd
> > mans@mansr.com
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
