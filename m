From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/17] OMAPDSS: Add some new fields to omap_video_timings
Date: Wed, 27 Jun 2012 16:02:02 +0300
Message-ID: <1340802122.2649.86.camel@deskari>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
	   <1340703414-1915-7-git-send-email-archit@ti.com>
	  <1340797733.2649.48.camel@deskari> <4FEAFC02.2070006@ti.com>
	 <1340800933.2649.72.camel@deskari> <4FEB00CB.4070502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-G0c4AYUdfZEaiLtc1Y2r"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:53792 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775Ab2F0NCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 09:02:08 -0400
Received: by bkcji2 with SMTP id ji2so962238bkc.5
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 06:02:04 -0700 (PDT)
In-Reply-To: <4FEB00CB.4070502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Archit Taneja <archit@ti.com>, rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-G0c4AYUdfZEaiLtc1Y2r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 18:17 +0530, Archit Taneja wrote:
> On Wednesday 27 June 2012 06:12 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-06-27 at 17:56 +0530, Archit Taneja wrote:
> >> On Wednesday 27 June 2012 05:18 PM, Tomi Valkeinen wrote:
> >>> On Tue, 2012-06-26 at 15:06 +0530, Archit Taneja wrote:
> >>>> Some panel timing related fields are contained in omap_panel_config =
in the form
> >>>> of flags. The fields are:
> >>>>
> >>>> - Hsync logic level
> >>>> - Vsync logic level
> >>>> - Data driven on rising/falling edge of pixel clock
> >>>> - Output enable/Data enable logic level
> >>>> - HSYNC/VSYNC driven on rising/falling edge of pixel clock
> >>>>
> >>>> Out of these parameters, Hsync and Vsync logic levels are a part of =
the timings
> >>>> in the Xorg modeline configuration. So it makes sense to move the to
> >>>> omap_video_timings. The rest aren't a part of modeline, but it still=
 makes
> >>>> sense to move these since they are related to panel timings.
> >>>>
> >>>> These fields stored in omap_panel_config in dssdev are configured fo=
r LCD
> >>>> panels, and the corresponding LCD managers in the DISPC_POL_FREQo re=
gisters.
> >>>>
> >>>> Add the above fields in omap_video_timings. Represent their state vi=
a new enums.
> >>>> The parameter pclk_edge is configured via omap_dss_signal_level, how=
ever it
> >>>> actually configures whether data is driven on the rising or falling =
edge. This
> >>>> is a bit unclean, but it prevents us from creating another enum.
> >>>
> >>> Hmm, why can't omap_dss_signal_edge be used for pclk_edge? I think it=
'd
> >>> fit fine, except OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES would be an illegal
> >>> value for it.
> >>
> >> I think my paragraph is a bit misleading. The issue is more about the
> >> default value. For hsync_vsync_edge(which programs ONOFF and RF), the
> >> default value is OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES, and is the case for
> >> most panels. But for pclk_edge, the value for most panels is
> >> OMAPDSS_DRIVE_SIG_ACTIVE_HIGH.
> >>
> >> So if I use the same enum for both, I'll need to populate either
> >> pclk_edge or hsync_vsync_edge for almost every panel. With my approach=
,
> >> I only need to populate these fields for panels having the non-default
> >> requirements. The negative thing is that it's a bit misleading to
> >> represent pclk_edge with the omap_dss_signal_level enum.
> >
> > Ah, I see.
> >
> > I really think using the ACTIVE_LOW/HIGH for pclk_edge is quite ugly =
=3D).
> >
> > Well, one option is to add new entry for the enums, "UNDEFINED" or
> > perhaps "DEFAULT", which would have value 0. Then omapdss would know
> > that it should use the default value, whatever that is.
> >
> > Another option is to have all panels define the pclk_edge, so that
> > there's no default value needed.
>=20
> I think I'll go with this.

Ok. But if you do this, then perhaps you should fill all the other
properties also. It looks a bit strange to require only one particular
to be always entered, while the others have default values.

But I guess that's not a bad thing at all. If the panel doesn't define
what kind of signal it wants, and trusts that the defaults are always
the same, it may break later or perhaps with other platforms.

So I think the panel drivers should define all the signal properties,
and not leave them to default values. That's the safest option, although
a bit verbose.

 Tomi


--=-G0c4AYUdfZEaiLtc1Y2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6wRKAAoJEPo9qoy8lh71TtUP/jaccSlSApEStbVWhW42bJ0c
kEcmZkhn0juqNiZh0GX52N1ufh9fx4FQ8dA3EBNZ0c9jT7tgjWto9CkSIo8/ASXj
eE6oO8ZfFaqoU0GGIfiU+OMBZSKUMubgevYaMvxRCUKX4SQYdRPppqVqp5vlUEV8
LfpOyCM+RUEQyzRIJEF6S5nY3wccNMtue0CkrTzYWcbuSbkl9NdVmnlYXUNyMeIy
yFk1yVMk/wJTW0zzLKAfOvRsCpk5K+Xuas8aph029d4fu3oKcQkzs1DIBEIDws8Q
txo+RIjcn9Cp0Mlgz6CZQ5h5Um/1+dCjDIiHRc/3V9C8ToX0E596OYSq7UAt12eY
I694b+Cs7hfXc9pndhtk437eoqhE568TDiMRjAYBLpUjsq9f8FnFp/XqrrhJoSFZ
hBBdx75mDet1qkxwcold85YFtmpuNJqYFOLB56Cn/FgzDCRMPbfOV9wHQkTa8EH7
rhhXHJBRnc4ZOXjug/jgNjBgyfgHAMU+uNPwsPBQjCiw+/VXh0LnNUzz+PPDZS0L
xG9xzzGBoAIxfNYasV2jTU5pW4ShK8pxRrwRtnu99TAmI3SNQqbayDCxuJhqE1Ga
uALP/0Zwj8PVLJInNRfPn+ynaf33w+cPuvv9GnEJPqqVLH1M0Ob8eEyBFTRQx6xR
e+uj1iZMDHmNXV8jSgbC
=SquS
-----END PGP SIGNATURE-----

--=-G0c4AYUdfZEaiLtc1Y2r--

