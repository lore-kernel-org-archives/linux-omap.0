From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: fix bridge_open memory leaks
Date: Tue, 31 Jan 2012 11:17:51 +0300
Message-ID: <20120131081751.GB3294@mwanda>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
 <1327972818-30993-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SHFFXbs3XlGSDX14"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:63749 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab2AaIQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 03:16:25 -0500
Content-Disposition: inline
In-Reply-To: <1327972818-30993-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org


--SHFFXbs3XlGSDX14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2012 at 07:20:17PM -0600, Omar Ramirez Luna wrote:
> There are two members of pr_ctxt allocated during bridge_open that
> are never freed resulting in memory leaks, these are stream_id and
> node_id, they are now freed on release of the handle (bridge_release)
> right before freeing pr_ctxt.
>=20
> Error path for bridge_open was also fixed since the same variables
> could result in memory leaking due to missing handling of failure
> scenarios. While at it, the indentation changes were introduced to
> avoid interleaved goto statements inside big if blocks.
>=20

You mentioned in the cover letter email that you wanted these to go
into stable.  I don't think that is needed here.  These are tiny
leaks that we aren't going to hit in real life.

But if we did want to include them in stable then we would add a tag
to the patch next to the Signed-off-by.

Read Documentation/stable_kernel_rules.txt.  It's short.

regards,
dan carpenter


--SHFFXbs3XlGSDX14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJ6OuAAoJEOnZkXI/YHqRiL4P/3eRZcwhKZQq+YpKtPkzomC/
1V9cOZL23JFcmdqIaC1oBcgWototSbauI79ZoDFKa+r4YM1UdPlHt+QRao8nA3a3
kGr7fK49lo/PKb0ABbokeSRcb2YbZ1H/so0tn/Hi3lnVxcIgqCOgVD5WenenTUBz
p0DSORsybL0+KhdR+tYbssj9hE3j4EjHSMnWz0xE3hHf6NLBUskaMFUNgp3KL2AV
gLxXU2cJd+Z6cLB+cyDFPsyJashinCiegOvwBhq3IsTsqENAsGsnMoIf7qVv0W6+
1llq8c/Cb6RXJEenrDeu2kcuDnw6iob4GWEXMFal5N0Ep9LyPEAQDGPMMN21a5KK
ELYgu8AKJ5hDofqgD4Y2wtTyBYEM/yILZzsacajhrpQJpcuFGKFfmK1l4tGV33Zl
+DAciUYr3N8Mz4OpBzkQVfO1JDdNTGpn7m+IrTi/HR3icEDSXLRwnYU+jp66veXY
BQCm/q5NuGilTXiN2bN0VUhH1DTmqTCA3QNI67QwE184EGtz02pgt0KNTSqam4sK
skHkvTpVMHJB10ERroxmp09IXyZPSd6V7dqvkYo5qFhxdbX382aRFClzdGTpBQRd
S3SfhbE9Hz15Ks2Bw+DtVazudfsOU5Bd+8Q86t2SFdpmtXL3fafYYmfgs0V4xCqI
NMJgyxp80syrj/FHp3oI
=6uIj
-----END PGP SIGNATURE-----

--SHFFXbs3XlGSDX14--
