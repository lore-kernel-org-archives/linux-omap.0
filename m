From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Fri, 12 Sep 2008 18:29:37 +0300
Message-ID: <20080912152937.GP31563@intune.research.nokia.com>
References: <1221144955.12281.6.camel@tubuntu> <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65085 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYILPaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 11:30:03 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shah, Hardik" <hardik.shah@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2008 at 07:59:44PM +0530, ext Shah, Hardik wrote:
> It's time to re-design DSS frame buffer driver for the OMAP2/3.  Current =
frame buffer driver is not covering the most of the functionality of the OM=
AP2/3 DSS Hardware like multiple outputs and multiple overlay managers supp=
orted by OMAP2/3 class of SoC. Again there is no V4L2 interface exposed by =
the DSS drivers for controlling the video pipelines of the DSS which is hig=
hly desirable feature as the video pipelines of the DSS hardware is a natur=
al fit to the V4L2 architecture.

If you want to use v4l for video output, don't let me stop you, but I
don't see that it has much actual wide use beyond TI PowerPoint
presentations about their graphical architecture.

> We have already initiated the re-designing of the DSS drivers and already=
 posted the RFC for the same on the Linux-Omap and the V4L2 mailing lists. =
 Below is the link for the RFC submitted by us on the open source mailing l=
ists -
>=20
> http://lists-archives.org/video4linux/23648-omap3-display-driver-v4l2.html
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg02510.html

I like this proposal a lot better, but I think fbdev + v4l is not a
great plan.  Have you looked at DRM modesetting drivers?

Cheers,
Daniel

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjKiuEACgkQ68xJuWtYYdUetwCgtE0hrcK2XU5sJCKVWre+tMHA
F9YAnjEzZDbjhcVT8IlCYI3PfA772zMM
=7Djk
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
