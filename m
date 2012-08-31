From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 10/23] OMAPDSS: DPI: Pass omap_dss_output within the
 driver
Date: Fri, 31 Aug 2012 16:48:50 +0300
Message-ID: <1346420930.7508.9.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-11-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-eQrhPKOEMZzc7Uw/zUhq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:44834 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753200Ab2HaNtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 09:49:00 -0400
Received: by lbbgj3 with SMTP id gj3so1226745lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 06:48:57 -0700 (PDT)
In-Reply-To: <1346326845-16583-11-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-eQrhPKOEMZzc7Uw/zUhq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> When a panel driver calls a DPI function, it passes the omap_dss_device
> pointer, this pointer currently propagates within the DPI driver to confi=
gure
> the interface.
>=20
> Extract the omap_dss_output pointer from omap_dss_device received from th=
e panel
> driver, pass the output pointer to DPI functions local to the driver to
> configure the interface, these functions no longer need omap_dss_device s=
ince
> the driver now maintains a copy of output parameters.
>=20
> Replace dssdev->manager references with out->manager references as only t=
hese
> will be valid later.
>=20
> With the addition of outputs. There is a possibility that an omap_dss_dev=
ice
> isn't connected to an output, or a manager isn't connected to an output y=
et.
> Ensure that the DPI interface functions proceed only if the output is non=
 NULL.

I agree with the direction of this and the similar patches for other
outputs, but I think we should leave these out for now, at least most of
the code here.

So ultimately we'll have the output drivers taking the omap_dss_output
as an argument, and we don't need dssdev anymore. But we can't do that
yet, and now that you mix both approaches I think the end result makes
the code a bit more confusing, and it would be changed again later when
dssdev can be removed.

What I mean is that, for example, display_enable takes dssdev as an
argument. Then you extract output from that, and pass output to some
other functions. Then these functions again extract dssdev from the
output.

This feels like extra churn that doesn't really help anything, and will
be changed later when the functions get output as an argument. So I
propose to keep passing dssdev around until we've removed the
dependencies to dssdev, and we (probably) get the output directly as an
argument to the functions. Then we can clean them up properly at one go.

The dssdev->manager parts still need to be changed to out->manager, of
course, but I think those are minority of the changes here and the
following patches.

 Tomi


--=-eQrhPKOEMZzc7Uw/zUhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQMDCAAoJEPo9qoy8lh71UsUQAJy8W8jwqM3ekT/UH/fcXlmk
6g/HAjfyqR/0/ufxlHUIJXBXHJD4//A1SBnEgwfmCiwEFsbMLpyxpsTsGnKnf7D+
Ze7ebNwX42jlKv27YVK9IGtM1fmk3YvhrDUNIGAVPMdOJ3eU3NSMWFUeTrDOcbwb
tuBssrbT+B/HqLw0wGCl07xLnppQtiVXaFh2fIIchrcYq/6Ab3uHU3a1Ud6o8zUW
3kpHcz/aLA5khY5UHvyG/dq/84aNPm/OBqht5VLdzuApTjjnnA1qBJwEkEvSZLp5
pdRiJ/p2Sm/myJE8cJpEe/4d5/Fm2sK76KowabwgMvTMIRsSpkCMlRccfIjDymkA
3yEvM506V+Jh2YQ/1Gi5jXQ9FtaTojdYh0ur54eehskc2YzT1yNNXM709iqQeblQ
PHGmDSxIohVcmsy3YlWtDNXot6U3ypYhXdiEBF+cLo1uDIDeug89nGnuoUb73cOl
AIMz1G2J/EKbpWxQPR0SYII5hYkCdbFuEH9RW4vi7eRxxOqPa4PMQzJQNJA5mnr7
pnrgfVCWRySoq9Faz7ChNDp1dwZ/t/McwPa7ALleY4OXZTv1CWXVfg3O5JJ8wWtU
L0rHZ86TqV64+527JTpa/1BM6X8oNmN0pQ+MDY7KTYljBM0BpJ6A0AHdBinFkCRb
RfSKxiOeeUI1Xf8xejjH
=ju4W
-----END PGP SIGNATURE-----

--=-eQrhPKOEMZzc7Uw/zUhq--

