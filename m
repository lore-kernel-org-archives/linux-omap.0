From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: provide default timings functions for
 panels
Date: Thu, 15 Mar 2012 10:12:36 +0200
Message-ID: <1331799156.2768.6.camel@deskari>
References: <1331551631-11420-1-git-send-email-notasas@gmail.com>
	 <1331724142.2386.25.camel@deskari>
	 <CANOLnOMAg-gdGPCuR1eR39GzNcK0rqFpfx6hiC2ULgPQ5v4qbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Nrv1tcG3s+HIPvokZKZP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:53072 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759405Ab2COIMk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 04:12:40 -0400
Received: by mail-lb0-f180.google.com with SMTP id n10so1717508lbo.11
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 01:12:38 -0700 (PDT)
In-Reply-To: <CANOLnOMAg-gdGPCuR1eR39GzNcK0rqFpfx6hiC2ULgPQ5v4qbA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-Nrv1tcG3s+HIPvokZKZP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-14 at 18:33 +0200, Grazvydas Ignotas wrote:
> On Wed, Mar 14, 2012 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Hi,
> >
> > On Mon, 2012-03-12 at 13:27 +0200, Grazvydas Ignotas wrote:
> >> With this we can eliminate some duplicate code in panel drivers.
> >> Also lgphilips-lb035q02, nec-nl8048hl11-01b, picodlp and
> >> tpo-td043mtea1 gain support of timings control over sysfs.
> >
> > I don't like this patch.
> >
> > Panels usually have a single, fixed timing configuration that should be
> > used, like the ones you mention above. There's no need to alter the
> > timings.
>=20
> But they often have a range of timings they can tolerate, and that can
> be used to alter refresh rate, for example. We do that on pandora to
> match graphics drawing rate (or multiples of it) to create a feeling
> smoothness.

True. And it's a valid operation anyway, so I guess there's no reason
why not to allow changing of the timings there.

> > But it's true that there's some duplicate code currently in the panel
> > drivers. However, adding just simple funcs like you did in this patch
> > doesn't work quite properly. There should be locking (for example to
> > prevent disabling the panel while timings are being set), and currently
> > the locking is panel driver specific.

Oh, and one more problem with the patch is that currently the panel
informs its inability to change timings by leaving set_timings and
check_timings as NULL, and this tells omapfb etc that the timings cannot
be changed, and the patch changes that behavior.

> ok, what about a version of this with .get_timings only then?
> This should not need a lock unless panel has a set function, but in
> that case panel will be expected to provide safe version of .get and
> .set itself.

I guess there's no harm in having default for get_timings(). It should
be present on all panel drivers anyway.

 Tomi


--=-Nrv1tcG3s+HIPvokZKZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPYaRwAAoJEPo9qoy8lh715ocP/3sdNi+PwgkUSC4sDdLXXFfB
sVQc30zNDe09S1qKa+ZlwG8PVXahCz253ZBkZHIXAoiNCYhf3Tsm5Ud7WMA+RGZp
GdIE0mHfaqSBuxJTQM74BolJ/u/rbrr0aaKRL6I0qmppf7d21GDd8X20s6D7RSHj
LvEwIL6pvBg0+Kv8VxB9TVqVE2EdJ9oJLItMkN41Er1N0eet5QKPPFaN328U20GX
+BOy4sT7gnm5LXiN2URjr/VsuYd9b1KhikoGLfDT/u6Jd1w0RR+AkMnPtk4cQDH1
Ilj0yaFdrwjVcOmEcV/xJUK+sySaFavw8qOzw2UjCed8PqWTkBqj7UFXQ9r4OTwI
wezsS5W/ZejgzRFSouR36Z5TH+QcNxg63H6gpgK/nDkMYizutVQ+4ozZGbWL2o+2
Mk/WUwbcv+ShjKlrv3Yxvg/vaW8SoyfOvrwZHVmt3rzFCF5w16yn3jiuQ3/f/bEh
3X8r4krmhytEoQx/pF5OARF0020KQAck1NR+TLCd/uRcamCy5NI2xsvfh5ZlLnUP
oq7TdrEUKoUUgE3N5ZqVmFjzPJpmaz4LySSD9RsjoBBYf2swt5G2jQVjFUpMGvAK
hMjOG0TzyHJjPYLDfuXNx+sfz2WGUgDJeiei1Y7SkeJmszhWpOC9rMAHsXBMPioG
Curc7uwrFVEjSAtZKNP1
=x4//
-----END PGP SIGNATURE-----

--=-Nrv1tcG3s+HIPvokZKZP--

