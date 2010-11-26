From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Fri, 26 Nov 2010 17:33:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCCA401A@dbde02.ent.ti.com>
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
Received: from comal.ext.ti.com ([198.47.26.152]:59769 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126Ab0KZMDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 07:03:52 -0500
In-Reply-To: <yw1xeia81nts.fsf@unicorn.mansr.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of M=E5ns Rullg=E5rd
> Sent: Friday, November 26, 2010 2:09 PM
> To: linux-omap@vger.kernel.org
> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>=20
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
>=20
> >> -----Original Message-----
> >> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> >> Sent: Wednesday, November 24, 2010 10:01 PM
> >> To: Hiremath, Vaibhav
> >> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
> >> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> >>
> >> On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaibhav wr=
ote:
> >> >
> >> > > -----Original Message-----
> >> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> >> > > Sent: Wednesday, November 24, 2010 2:28 PM
> >> > > To: Hiremath, Vaibhav
> >> > > Cc: linux-omap@vger.kernel.org
> >> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> >> > >
> >> > > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote=
:
> >> > > > Hi,
> > <snip>
> >> >
<snip...>
> >>
> >> If you want to standardise WAITFORGO type of stuff then just add
> >> another standard ioctl for it.
> >>
> > [Hiremath, Vaibhav] I still believe we should not only look at the
> > name of IOCTL (WAITFORVSYNC) and define what it should do, it may
> > change based on your platform/HW to get the desired functionality
> > out of it.
>=20
> It is impossible to know what every user expects from it.  A user may
> very well be using WAITFORVSYNC for timing purposes.  If it then were
> to sometimes wait more than one vsync, it would be useless.
>=20
[Hiremath, Vaibhav] I completely understand and agree with your stateme=
nt here, but I think the finding and recommendation which I am talking =
about does address this.

Let's consider 2 Options/use-cases -=20

1) Application expecting correct number of VSYNC interrupts -

Here application wants to use WAITFORVSYNC ioctl to get correct number =
of VSYNC interrupt and do some operation (not related to buffer data or=
 no Fbdev config change). Then WAITFORGO will work exactly same as WAIT=
=46ORVSYNC.

Let me state one more time "WAITFORGO makes sure that the configuration=
 change gets applied to actual HW". If application is changing some con=
figuration of HW, does it makes sense to return without making sure tha=
t whether it has been consumed by HW or not.

2) Application does update the buffer and synchronizes with HW on WAIFO=
RVSYNC -

As I mentioned this is un-doubtfully conformed that it has valid bug wh=
ere there is chance of software going out of sync with actual HW.


> > In OMAP there is chance of miss-match between user application and
> > Display HW if user uses FBIO_WAITFORVSYNC ioctl in multi-buffer
> > use-case.
> >
> > while (1) {
> > 	Update/Create the next buffer
> > 	FBIO_PAN
> > 	FBIO_WAITFORVSYNC //assuming HW-SW stay in sync (which is not)
> > }
> >
> > There is definitely an issue with above use-case which has been
> > un-doubtfully conformed now.
>=20
> The bug could still be argued to be in the application.
>=20
[Hiremath, Vaibhav] No, you can not. Please refer to the wiki page (htt=
p://processors.wiki.ti.com/index.php/OMAP35x_Linux_-_DSS_FAQ) which exp=
lains OMAP HW issue I am talking about.

Actually with the same context I was referring to some of other devices=
 like S3C, etc... and I believe they handle double-buffering in differe=
nt way. In case of S3C, HW does support 2 sets of separate configuratio=
n to handle double buffering. Spec doesn't talk about any shadow regist=
er, when HW latches it, etc... But I believe it makes sense that, it mu=
st be getting latched on next vsync.


> > At least in case of OMAP, WAITFORVSYNC is useless in multiple
> > buffering use-case, application has to use WAITFORGO.
>=20
> Why does it take so long for the changes to reach the hardware? =20
[Hiremath, Vaibhav] It doesn't take time to reach HW. What if applicati=
on writes exactly during this period (VFP - VSYNC), could it be delay d=
ue to extra time for image creation, or anything.

> Once
> written to the registers, the values are latched at the next vsync, s=
o
> the delay is higher up the stack.  Is there any way it could be
> eliminated?  This would not only fix the "bug" under discussion here,
> but also reduce the latency of page flipping.
>=20
[Hiremath, Vaibhav] Mat,

Exactly same thing I am bringing out here, OMAP3 DSS doesn't fall under=
 this. In case of OMAP3, the latching doesn't happen on VSYNC, it happe=
ns on VFP (Vertical front porch). There is time gap between VFP and VSY=
NC; this is what I am referring to.=20

If application changes/writes during this period (after VFP and before =
VSYNC) you are going out of sync, that's where the tearing effect is ob=
served.

> > As far as WAITFORGO is concerned, I think GO bit concept is
> > something OMAP notion/term and doesn't make sense to standardize
> > it. Atleast I am not aware of any other architecture having GO bit.
>=20
> Naming is minor detail.  Feel free to suggest a better one.
>=20
[Hiremath, Vaibhav] If I fail to convince on this, then I think the onl=
y left option is to make WAITFORGO ioctl generic. And put a disclaimer =
on WAITFORVSYNC, it must not be used in panning use-case.


> --
> M=E5ns Rullg=E5rd
> mans@mansr.com
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
