From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Date: Thu, 24 Mar 2011 20:13:27 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103242001460.21914@axis700.grange>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com>
 <AANLkTim61Xdo6ED7mr_SvpLuotso89RdR6Qaz-GCXOmJ@mail.gmail.com>
 <AANLkTinMUCbaEVjwZsHG9BxFVjx0YxS=Sw+3gViDJXhg@mail.gmail.com>
 <20110323081820.5b37d169@jbarnes-desktop> <AANLkTinYHzCgXe9yw1rGHZA0uM=-VrY+Mktpn-HvfRyR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63003 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573Ab1CXTNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 15:13:31 -0400
In-Reply-To: <AANLkTinYHzCgXe9yw1rGHZA0uM=-VrY+Mktpn-HvfRyR@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org

On Thu, 24 Mar 2011, K, Mythri P wrote:

> Hi Jesse,
>=20
> On Wed, Mar 23, 2011 at 8:48 PM, Jesse Barnes <jbarnes@virtuousgeek.o=
rg> wrote:
> > On Wed, 23 Mar 2011 18:58:27 +0530
> > "K, Mythri P" <mythripk@ti.com> wrote:
> >
> >> Hi Dave,
> >>
> >> On Wed, Mar 23, 2011 at 6:16 AM, Dave Airlie <airlied@gmail.com> w=
rote:
> >> > On Wed, Mar 23, 2011 at 3:32 AM, Mythri P K <mythripk@ti.com> wr=
ote:
> >> >> Adding support for common EDID parsing in kernel.
> >> >>
> >> >> EDID - Extended display identification data is a data structure=
 provided by
> >> >> a digital display to describe its capabilities to a video sourc=
e, This a
> >> >> standard supported by CEA and VESA.
> >> >>
> >> >> There are several custom implementations for parsing EDID in ke=
rnel, some
> >> >> of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, I=
deally
> >> >> parsing of EDID should be done in a library, which is agnostic =
of the
> >> >> framework (V4l2, DRM, FB) =A0which is using the functionality, =
just based on
> >> >> the raw EDID pointer with size/segment information.
> >> >>
> >> >> With other RFC's such as the one below, which tries to standard=
ize HDMI API's
> >> >> It would be better to have a common EDID code in one place.It a=
lso helps to
> >> >> provide better interoperability with variety of TV/Monitor may =
be even by
> >> >> listing out quirks which might get missed with several custom i=
mplementation
> >> >> of EDID.
> >> >> http://permalink.gmane.org/gmane.linux.drivers.video-input-infr=
astructure/30401
> >> >>
> >> >> This patch tries to add functions to parse some portion EDID (d=
etailed timing,
> >> >> monitor limits, AV delay information, deep color mode support, =
Audio and VSDB)
> >> >> If we can align on this library approach i can enhance this lib=
rary to parse
> >> >> other blocks and probably we could also add quirks from other i=
mplementation
> >> >> as well.
> >> >>
> >> >
> >> > If you want to take this approach, you need to start from the DR=
M EDID parser,
> >> > its the most well tested and I can guarantee its been plugged in=
to more monitors
> >> > than any of the others. There is just no way we would move the D=
RM parser to a
> >> > library one that isn't derived from it + enhancements, as we'd t=
hrow away the
> >> > years of testing and the regression count would be way too high.
> >> >
> >> I had a look at the DRM EDID code, but for quirks it looks pretty =
much the same.
> >> yes i could take quirks and other DRM tested code and enhance, but
> >> still the code has to do away with struct drm_display_mode
> >> which is very much custom to DRM.
> >
> > If that's the only issue you have, we could easily rename that
> > structure or add conversion funcs to a smaller structure if that's =
what
> > you need.
> >
> > Dave's point is that we can't ditch the existing code without
> > introducing a lot of risk; it would be better to start a library-iz=
ed
> > EDID codebase from the most complete one we have already, i.e. the =
DRM
> > EDID code.

Does the DRM EDID-parser also process blocks beyond the first one and=20
also parses SVD entries similar to what I've recently added to fbdev? Y=
es,=20
we definitely need a common EDID parses, and maybe we'll have to collec=
t=20
various pieces from different implementations.

Thanks
Guennadi

> >
> This sounds good. If we can remove the DRM dependent portion to have =
a
> library-ized EDID code,
> That would be perfect. The main Intention to have a library is,
> Instead of having several different Implementation in kernel, all
> doing the same EDID parsing , if we could have one single
> implementation , it would help in better testing and interoperability=
=2E
>=20
> > Do you really think the differences between your code and the exist=
ing
> > DRM code are irreconcilable?
> >
> On the contrary if there is a library-ized  EDID parsing using the
> drm_edid, and there is any delta / fields( Parsing the video block in
> CEA extension for Short Video Descriptor, Vendor block for AV delay
> /Deep color information etc) that are parsed with the RFC i posted i
> would be happy to add.
>=20
> Thanks and regards,
> Mythri.
> > --
> > Jesse Barnes, Intel Open Source Technology Center
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
