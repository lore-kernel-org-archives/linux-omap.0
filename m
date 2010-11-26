From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Fri, 26 Nov 2010 18:30:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCCA403F@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
 <20101124163100.GB5681@nokia.com>
 <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
 <yw1xeia81nts.fsf@unicorn.mansr.com>
 <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
 <20101126125539.GG8094@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50279 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0KZNAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 08:00:18 -0500
In-Reply-To: <20101126125539.GG8094@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

> -----Original Message-----
> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> Sent: Friday, November 26, 2010 6:26 PM
> To: Hiremath, Vaibhav
> Cc: M=E5ns Rullg=E5rd; linux-omap@vger.kernel.org; linux-fbdev@vger.k=
ernel.org
> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>=20
> On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav wrote=
:
> >
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > > Sent: Friday, November 26, 2010 5:34 PM
> > > To: 'M=E5ns Rullg=E5rd'; linux-omap@vger.kernel.org
> > > Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > >
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of M=E5ns Rullg=E5rd
> > > > Sent: Friday, November 26, 2010 2:09 PM
> > > > To: linux-omap@vger.kernel.org
> > > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > > >
> > > > "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> > > >
> > > > >> -----Original Message-----
> > > > >> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> > > > >> Sent: Wednesday, November 24, 2010 10:01 PM
> > > > >> To: Hiremath, Vaibhav
> > > > >> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
> > > > >> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > > > >>
> > > > >> On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaib=
hav
> > > wrote:
> > > > >> >
> > > > >> > > -----Original Message-----
> > > > >> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > > >> > > Sent: Wednesday, November 24, 2010 2:28 PM
> > > > >> > > To: Hiremath, Vaibhav
> > > > >> > > Cc: linux-omap@vger.kernel.org
> > > > >> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioc=
tl
> > > > >> > >
> > > > >> > > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav
> wrote:
> > > > >> > > > Hi,
> > > > > <snip>
> > > > >> >
> > <snip..>
> > >
> > > > > As far as WAITFORGO is concerned, I think GO bit concept is
> > > > > something OMAP notion/term and doesn't make sense to standard=
ize
> > > > > it. Atleast I am not aware of any other architecture having G=
O bit.
> > > >
> > > > Naming is minor detail.  Feel free to suggest a better one.
> > > >
> > > [Hiremath, Vaibhav] If I fail to convince on this, then I think t=
he
> only
> > > left option is to make WAITFORGO ioctl generic. And put a disclai=
mer
> on
> > > WAITFORVSYNC, it must not be used in panning use-case.
> > >
> > >
> > [Hiremath, Vaibhav] Also let me bring another point here,
> >
> > If I understand correctly most of the application libraries (Direct=
=46B, X,
> etc..) does use FBIO_WAITFORVSYNC to synchronize with HW, and manage =
ping
> pong mechanism.
>=20
> DirectFB uses it also for waiting for vsync.
>=20
[Hiremath, Vaibhav] Mat,

I am not expert on DirectFb stuff; can you please help me to understand=
 what the use-case is? What DirectFB does/expects on this?

Thanks,
Vaibhav
> > With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO
> (breaking standard applications).
>=20
> Applications using the standard fbdev API won't work with manual upda=
te
> displays anyway. You need omapfb specific code to handle it so having
> another small difference is not a big deal.
>=20
> In DirectFB the that's trivial since there's already a simple omap
> gfxdriver where you could override the default flip functionality wit=
h
> WAITFORGO based stuff.
>=20
> Or, as I said, you could add another standard ioctl and fix up usersp=
ace
> to use it where appropriate and if the kernel driver supports it.
>=20
> --
> Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
