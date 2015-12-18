From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display kconfig options changing
Date: Fri, 18 Dec 2015 17:04:13 +0200
Message-ID: <5674206D.60207@ti.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <CAHCN7xJnHac+50TFSZ-+4Hqq9Of1HA6fTtnPxKUMCq_j5_UqgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4936425825353971361=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xJnHac+50TFSZ-+4Hqq9Of1HA6fTtnPxKUMCq_j5_UqgQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============4936425825353971361==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hrhGAEJmRQkXGl0HhreDuQsm04sOVP2rC"

--hrhGAEJmRQkXGl0HhreDuQsm04sOVP2rC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18/12/15 16:03, Adam Ford wrote:
> Tomi,
>=20
> I'd like to also test the LogicPD Torpedo which has been using the FB
> drivers until this point. I just pushed some LCD info for inclusion in
> 4.5, but if I need to make changes, I'd like to do that sooner than

The DT data is the same for omapfb and omapdrm, so no changes needed.

> later.  Any insturctions would be helpful.  Will this impact people
> who use the SGX drivers?

I'm no expert, but... Yes, I think so. If you were using SGX driver with
some additional omapfb patches, it won't work with omapdrm.

omapdrm + SGX works, but it's a bit tricky setup (need extra kernel
patches, specific userspace libs...). I hope we'll get the SGX side
sorted out during the first quarter, which should make omapdrm + SGX
much easier to get running.

 Tomi


--hrhGAEJmRQkXGl0HhreDuQsm04sOVP2rC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWdCBtAAoJEPo9qoy8lh71a4MP/R6awnelkZFxBSFCgjZ66Uq9
rXBuzNz+39Z5azIglaWqE0MoCvDOX+ND31g2WqlCQDGBU633OPnl8jRb7gPAxspN
SGMdLAI3uskZjoIGuqw1Qxd7a3/irtGwEI//WGXgp00hJ7OIQuwblpvLkBHONmKY
mUgT9Z2rIeC8Q8ZRQj8kvcnypQk3RvOQWTEfFUCb2bYu7qeCEkQ9EDhLtvZ4bUdc
DWhkZxqSW6QtrfKIXF9FbJIazXXCYfP2ZSrDEFavYrp89XK3kPR2ph+n9s3X06DL
eZ8bsaug7c4WzghBr6NphQuQfhRkKXpBcWYJmot5Xaq8LxySlgFYTGmpP4dOZ0JL
bl0XpH4BaoJDGKLA3M/3j87IaKg0qXJzkIgfpVrv2qFS2hSq2lL2adm5vFKxE0pt
QS+ndF+8aa0kVJRBa/LwUsC7EgUtrjHW9OJpcQK/DGmWf/WDZx4RJ4Xvo4XzVapi
ah6EQpMmJMpmTYWkeE/pd3HSR0JzbuHJ8oq4mu4TVM1XdVLMrhp2g5J7Etc7ud7O
ZbHg8G/uV068gJdaJSh14r8xoYvalzA05JmNx072AP0iv0MxkubqMkJnMdomHCz7
TP+4sfeCQ93ZBs51OdIoD3x2JiVXq7jBxUJ7hN7G+qcuCE6teDVZf2RorBkTcTuv
XNK8Vl8EDPXka+rPIqzr
=fSUT
-----END PGP SIGNATURE-----

--hrhGAEJmRQkXGl0HhreDuQsm04sOVP2rC--


--===============4936425825353971361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4936425825353971361==--
