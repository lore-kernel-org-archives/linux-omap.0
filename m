From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] staging: drm/omap: add rotation properties
Date: Mon, 2 Jul 2012 17:01:28 +0300
Message-ID: <20120702140128.GA5936@intel.com>
References: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
 <1340966763.2767.8.camel@deskari>
 <CAF6AEGsW158Z1zsTsygmwHfBeLVRdP6zuf06SWvQ=SiRX13X4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56169 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab2GBOBd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 10:01:33 -0400
Content-Disposition: inline
In-Reply-To: <CAF6AEGsW158Z1zsTsygmwHfBeLVRdP6zuf06SWvQ=SiRX13X4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, dri-devel@lists.freedesktop.org, archit@ti.com, s-guiriec@ti.com

On Fri, Jun 29, 2012 at 07:17:23AM -0500, Rob Clark wrote:
> On Fri, Jun 29, 2012 at 5:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
> > On Wed, 2012-06-27 at 09:06 -0500, Rob Clark wrote:
> >> From: Rob Clark <rob@ti.com>
> >>
> >> Use tiled buffers for rotated/reflected scanout, with CRTC and pla=
ne
> >> properties as the interface for userspace to configure rotation.
> >>
> >> Signed-off-by: Rob Clark <rob@ti.com>
> >
> >> +/* this should probably be in drm-core to standardize amongst dri=
vers */
> >> +#define DRM_ROTATE_0 0
> >> +#define DRM_ROTATE_90 =A0 =A0 =A0 =A01
> >> +#define DRM_ROTATE_180 =A0 =A0 =A0 2
> >> +#define DRM_ROTATE_270 =A0 =A0 =A0 3
> >> +#define DRM_REFLECT_X =A0 =A0 =A0 =A04
> >> +#define DRM_REFLECT_Y =A0 =A0 =A0 =A05
> >
> > Are both reflect X and Y needed? You can get all the possible
> > orientations with just one of the reflects.
> >
> > And I think the word "mirror" represents nicely what the reflect do=
es,
> > i.e. if you look at the mirror, the image you see is flipped
> > horizontally.
>=20
> fwiw these values are aligned with what is used in userspace xrandr..
> an earlier version of this patch used just 3 bits, which where aligne=
d
> with what the omap hw uses and can describe all possible combinations
> of mirroring and isomorphic rotation (x-invert, y-invert, and
> xy-flip).  But the advantage of the xrandr approach is you can more
> easily leave out bits for rotation/mirroring modes that your hw does
> not support.. for example if some hw supports only certain rotations
> or does not support mirror/reflect.

When I hear "mirror" I always think of it as the happening after
rotation, but that's not how xrandr does things. I suppose "reflection"
has more or less the same connotation for me, but since it's already
used by xrandr, I know I have to do the necessary mental gymnastics.

If you think about it in terms of matrix multiplication, xrandr does
things like this: x' =3D Rot * Ref * x, whereas for me the more natural
order (for whatever reason) would be x' =3D Ref * Rot * x, where x is t=
he
source coordinates, and x' the destination coordinates.

IIRC in dss mirroring was specified in the post-rotation way, and
the direction of the rotation was also opposite to xrandr (cw in dss,
ccw in xrandr).

So FWIW, my vote goes to "reflect" if we want to match xrandr
semantics. Also I agree on the number of bits, six is better than
three since it allows you to describe the hw capabilities.

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
