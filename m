From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Thu, 31 May 2012 09:31:09 +0300
Message-ID: <1338445869.1864.3.camel@lappyti>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com>
	 <4FC704A4.2050806@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wRWXWluoJQC9XTgRTUo0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55707 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955Ab2EaGbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 02:31:19 -0400
Received: by lags15 with SMTP id s15so493638lag.20
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 23:31:16 -0700 (PDT)
In-Reply-To: <4FC704A4.2050806@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, Xiao Jiang <jgq516@gmail.com>, linux-omap@vger.kernel.org


--=-wRWXWluoJQC9XTgRTUo0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-31 at 08:41 +0300, Jarkko Nikula wrote:
> On 05/31/2012 02:35 AM, Ricardo Neri wrote:
> > Build breaks because there some patches [1] that are still missing in
> > Linus' tree. ASoC HDMI audio driver for OMAP[2] now uses the new DSS
> > audio functionality in [1], but ASoC patches were merged first. DSS
> > patches have been accepted and they are part of Tomi's pull request for
> > DSS for K3.5. Hopefully this will be fixed when v3.5-rc1 is out.
> >=20
> Then there was an error already in the process if dependent sets didn't
> go together via the same merge or in next merge window. Remember each
> commit must compile alone.

They are going in in the same merge window. The asoc stuff has been
already merged, but the omapdss stuff hasn't.

It's true that there's a commit range where the asoc stuff doesn't
compile, and I agree that it's not good. But you need to explicitly
enable the HDMI ASOC support to get the error.

> It's quite boring to try to bisect over multiple kernel versions and
> where most of the time goes solving random unrelated build breakages.

How to get arm/arm/, omapdss, omapdrm and asoc driver changes in at the
same time? All go through various different trees and maintainers. I
haven't found a solution for this. If you have good ideas, please share
=3D).

 Tomi


--=-wRWXWluoJQC9XTgRTUo0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPxxAtAAoJEPo9qoy8lh71ZPsP/3iP4nNjLkh5SqojK4W0p04P
RdYHuYicn8hyEbI+N1u9IOldQh9a4ReoUhlLiT1kU4y9DKRJrVMbE5o5wINPzpi9
ohX74d3tOrMOShkt5NuG9OJUkq7qywzuhu5PkrSl7vbyQ4RcXXtFvKe/vy3+kasE
bog3dbhuHF6Q3eMwV1hWev9uCw0MUW5+fNBG8GDcBmL5awb2+RWBd1iE/PbdI3FF
LgA2T1EQXhdAhg3fTFySdJx6Zt7/JZS/V1UKp9taZ9lWtvlBs7S6DvaP2idkthwR
dVIqgnkqZx3K5C9ullUy6GudHTY9l57Ekn4SWK3aKeJDIlrAkJHOPQ93W+/qCpd7
rsMYSvsDoQibQiXkVh6iUH6Gqtoj1vpCZXZgH+iqGzT4Qi0ZgPSEVz8jSKuwFj1s
FLf5MC6GhJL/hY3o2qZo9qOEqWL8zIClsNSFT0eSnF1IQXqBn+kW/jJoWm1QToDF
wD4t3pOfeIUl2ikhrj1d9zDioQagdgUf1M0zewJfEhahNdQTtbWC913XjaqDxzuI
RXIGDf3AvAfYx371kO0iZjN9KFSjo031nMbWApatotm9HpzVtD5JFNTcJBSqy3zH
liNNjCQkZdLe8tnsriO9L6f9MCgoCHpoeD6o5FMrRBgHpqr4hhtk3CJFCjRuQu4s
ubEee2LPu4tei/hi/+Is
=/6NY
-----END PGP SIGNATURE-----

--=-wRWXWluoJQC9XTgRTUo0--

