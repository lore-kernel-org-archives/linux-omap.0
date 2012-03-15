From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 15 Mar 2012 10:46:17 +0200
Message-ID: <1331801177.2768.8.camel@deskari>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	 <1331728737.2386.76.camel@deskari>
	 <CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
	 <1331730465.1542.8.camel@lappy>
	 <CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
	 <1331732624.1542.32.camel@lappy>
	 <CAF6AEGsCpz4zXCSXhP5qA7hL4Xac9+c03rS1PZejhUog_+SHkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-O1t2ngEjpfh9WxpmzJVC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52680 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760273Ab2COIqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 04:46:21 -0400
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so2592149lag.30
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 01:46:20 -0700 (PDT)
In-Reply-To: <CAF6AEGsCpz4zXCSXhP5qA7hL4Xac9+c03rS1PZejhUog_+SHkg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org


--=-O1t2ngEjpfh9WxpmzJVC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-14 at 10:06 -0500, Rob Clark wrote:

> > Well, as I said, it's not an issue for me and from my side it can be
> > improved later.
>=20
> yeah, when CMA is actually merged, there are a few other things I'd
> like to do to, incl converting omapfb over to use CMA and remove
> omap_vram.. but I guess those will be other patches.

Right, I just realized CMA is not in the kernel, nor does it seem to be
in the linux-next. Is there a reason why you want it already merged?
Wouldn't it be easier to get it in only when it can actually be used.
Especially if there's room for improvement.

 Tomi


--=-O1t2ngEjpfh9WxpmzJVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPYaxZAAoJEPo9qoy8lh71uxUQALHOBsdBVBLABg3qSrO5jpDZ
Jn2ZLPglFZ7p9ZUIPSSSEqzOEVj+eYNvvk+QH3XvpVEdACKKUazvllNsAse+JbMg
TnBnj/uu4qs4tIQBjG8mYg++e5qp6CCM6ZEprp5fwvSac/4sjXoYTQX9Ew77SyBE
6wzLBst7u2diUJ+FznRtH6tMkL2CY6W+cdyHK+yyLeKa05FTGQ0AE7JewcDmoUsZ
FHX2cFRDnd9Vt/f0i5dyOHswOW9YBCeMmdwoF81x37gPDv+C+I55vwSZWtF9PSa1
5gKFyk8XU3JZbiku4zgH0w+Rrv8qZd6sN3fNziI1rxI+cVkxraQ+4bjH8larRDvz
BoBSeGxwNFn4aPnzuV8kDU6uFGdhywv1vMA/qWhAnxzYm8Ir2UCVWvS1UubkTq8v
BjqCtKgey4IJytuZ6EDNZQwxOsEaTVD9L80ZT32ZmhY8xlIZI9j09bbWtzxDpqNt
Xgb1cAWrv5nzKBUBnRkR9v0ja6i1Ko5dV/kCr35HgErMvSUSo61whSCkXZpCcIyp
F9+mUGF8JSV4VCB02Fw82OgH+tp+brOrIs0V61EiaUj0I1co0e7Cnc+6GmTyT1p3
zeZcyB4xunEKLpumevlNuM0mejh3FtwpVlj4E07p3LUzzm6CeGhdp3VmDGhrXVWC
AYAX/lNsbqCrZPWFCRgl
=X8f/
-----END PGP SIGNATURE-----

--=-O1t2ngEjpfh9WxpmzJVC--

