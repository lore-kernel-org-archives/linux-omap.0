From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 07 Mar 2012 15:11:40 +0200
Message-ID: <1331125900.4348.41.camel@deskari>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	 <1331040371.2059.113.camel@deskari>
	 <CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	 <1331044544.2059.150.camel@deskari>
	 <CAF6AEGvtGjgw+uEKTu34ukXNqZ-+gS6pQtv2oFM11X8ik1zY5w@mail.gmail.com>
	 <1331121599.4348.22.camel@deskari>
	 <CAF6AEGsoXye0jdbZrkBpXTSHPhV6Zue7K9YLw_FopoLHGwE2vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-nFCaMp3nLQnTsS5DXvf0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:35226 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755380Ab2CGNLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 08:11:44 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so7260013lag.3
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 05:11:43 -0800 (PST)
In-Reply-To: <CAF6AEGsoXye0jdbZrkBpXTSHPhV6Zue7K9YLw_FopoLHGwE2vg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org


--=-nFCaMp3nLQnTsS5DXvf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-07 at 07:06 -0600, Rob Clark wrote:
> On Wed, Mar 7, 2012 at 5:59 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:

> > Hmm, why does the drm core care about it?
>=20
> Because it is the one generating the bus-id.. see
> drivers/gpu/drm/drm_platform.c drm_platform_set_busid()
>=20
> Anyways, it's just a detail about how libdrm/drmOpen() can
> differentiate between multiple instances of the same driver, similar
> to how PCI bus-id is used in the desktop world.  It is not difficult
> to change in drm_platform_set_busid(), although not sure if that would
> be considered an ABI change to userspace.  (Maybe it is less critical,
> I'm under the impression that other platform-drm users didn't even
> realize we had a bus-id.)

Ok. Well, I'm fine with id 0 also, if it makes sense in the DRM side. It
was just something that caught my eye.

> > Okay, let me ask the other way. Is 32MB enough for everyone? Hardcoding
> > a value like that without any possibility to adjust it just sounds like
> > a rather bad thing.
>=20
> The main requirement is that, on omap3 or before (platforms without
> DMM) you need enough to allocate all of your scanout buffers.
>=20
> I'm not against having a bootarg to adjust, although I strongly prefer
> sane defaults and not requiring a million bootargs just to boot in
> some usable fashion.

Well, those are two different things. I'm fine with a default of 32MB.
My point was, what if I need more, or I don't need any.

 Tomi


--=-nFCaMp3nLQnTsS5DXvf0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPV16MAAoJEPo9qoy8lh71XNoP/A3mu9jsuexqdO108STsHFBH
1iulOuvx5mIVuuPTPc0QAo0WJxqP3ODp1JlhjtdVN9Gu/QvgRe+OfgrbirPeD0SW
gW/NrsxM6+lSTHEYH5kA2Efq16DCKAHPIT6XiIkhc9fT8A72clegx4ikcFapKIO3
SR5yccVAyv7lw5FcM4MM89MSJkBjh7DinAHsNm7hAUA9eC58S1QQVaasfVrtiEg8
1zX4ABOWWNJv1XPgWrnyvAO7kBN5mmklXYIrxAMAmMMQVuUNdIOwS8YKKCGBcILk
9mIzs9PewSbcH9zRYqOWGsMEd0ixXmGe8KTqVSVRnkOCgXTcsbk5BZrI7/8QGg+n
PhGx/vGjPDNJciX4MzLMs/2I/lqGwFgtXoEIg25Ewcu1j2+MxbdWy49GafcxvkBH
8SAnIxzIisc9iw+VkyMXwCXvLJJs0Ys0/+YRRtqe203NDl1zLw3RiYZuArnzVahN
7HNTAyHZPS1c7go1961paPg/WBJdYhs8MVkacVeElvlXFoyhvGRyM0Omy6CDudwJ
9K8Vic8BaXi2IN10MsMSCRxs83don+3zBcZh+Md7ss+iUhj/57/2Cql1JqOskEPW
Ng+2Jc4UAIv7RA52pt2q/YXQn9hEbSFFDZL0nyc1QiQ7iEWWrHqLTCiJ866Mz6M7
vqFS4V5HBGM+ZI4DKqUQ
=NmOz
-----END PGP SIGNATURE-----

--=-nFCaMp3nLQnTsS5DXvf0--

