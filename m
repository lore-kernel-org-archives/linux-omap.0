From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 15:13:01 +0300
Message-ID: <1337861581.12304.7.camel@deskari>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	 <1337839294.2764.7.camel@lappyti>
	 <CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	 <1337843144.2909.17.camel@deskari> <1337844098.2909.20.camel@deskari>
	 <CAF6AEGur-mmZDVrE+Y-6tesNCVKp4xKKuS-C7ozTSJ2KQijHdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-aa8xVZoQSIECn17iPwzz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:43800 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753969Ab2EXMNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 08:13:08 -0400
Received: by lban1 with SMTP id n1so7097519lba.24
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 05:13:05 -0700 (PDT)
In-Reply-To: <CAF6AEGur-mmZDVrE+Y-6tesNCVKp4xKKuS-C7ozTSJ2KQijHdw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-aa8xVZoQSIECn17iPwzz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-24 at 02:44 -0600, Rob Clark wrote:

> but other drivers *can* use tiler, thanks to dmabuf.. I have omap4iss
> v4l2 camera working w/ tiler buffers on my pandaboard, for example.
>=20
> Maybe fbdev is an exception to the rule because it has no way for
> userspace to pass it a buffer to use.  But on the other hand it is a
> legacy API so I'm not sure if it is worth loosing too much sleep over
> that.

I'm not that familiar with dmabuf, but are you saying it's not possible
for a kernel driver to request the buffers? They _must_ come from the
userspace?

Anyway, even if it would be possible, if the tiler is a part of omapdrm
we need omapdrm to get and use the tiler buffers. And we can't have
omapdrm running when using omapfb, because they both use omapdss.

 Tomi


--=-aa8xVZoQSIECn17iPwzz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPviXNAAoJEPo9qoy8lh71Qa8P/2iRlGMz0T6SpZ73/Vk5IdCN
u1Cf0T6svJPm8Sd8Emxdy7Evq5u7d91SxdqEXbyxfFGFD4EkTL3CeM6zsYD1s6+x
i4mgr6Wo3LlkrMHosmgJUxW9ZOf1Msb88BRkITLhqNSl1WlYGvhjXsMI+EKeudPU
BYj6EtD3qCqGeruwAYnwdSoCzjIFzUN7J5tcvsGJ4FTOUk1kNjm1YcNPEf6BK0jI
CY1K1C/lfpOab7O8LLTT0GWldFDtuDjmvN2jhhP62JcqO9jo7guyRwIWcKhUoxP9
7hOuS9cHdS4zYeol20upN8SKf0jr/bRPSdmdLSe0DgCxRnoaaCp9WVrvgipHTIOc
vS/moczwgg4vPNNAEfi8sdIoAEE4o+bz3fTxuI9YVbg95fDU9BBYXCwqGqGx4BmN
OZzyKek3jHa3YC+EOf9T08GMiSXLvahuC09a5vtAQHjIDJIuTFOiwu5ZkhxGdktK
f/UspDaoVJH57ePY73KeQQMh/yCb/qOZmrw7gVrvP9Wa2184R5R5yYZtNj3+fXlc
foHMa2nPrLSSsd3HDiDpO/2WseYFpdD4ujgas73XHMwzgBa25vGXbAObHCoBvnSE
IC3ZNh0AXbN7HJMEEJIqZqALEJpukzPhIc8tZ1PEZUmFM4vm+ujrq6y6WBiSLC95
M8FbwMkjmIdqOy1Z0I+C
=/kEv
-----END PGP SIGNATURE-----

--=-aa8xVZoQSIECn17iPwzz--

