From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] regulator: tps65217: Add device tree support
Date: Mon, 25 Jun 2012 13:12:20 +0100
Message-ID: <20120625121220.GA30406@opensource.wolfsonmicro.com>
References: <1340625878-32336-1-git-send-email-anilkumar@ti.com>
 <1340625878-32336-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1340625878-32336-2-git-send-email-anilkumar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: sameo@linux.intel.com, lrg@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca
List-Id: linux-omap@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2012 at 05:34:36PM +0530, AnilKumar Ch wrote:
> This commit adds device tree support for tps65217 pmic. And usage
> details are added to device tree documentation.
>=20
> Driver is tested by using kernel module with regulator set and get
> APIs.

This needs to be updated for the patches Laxman recently posted for the
regulator-compatible property (which are currently blocked on review
=66rom the ST Ericcsson guys but I'll probably apply them in the next
couple of days if I don't hear back from them).

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6FSqAAoJEBus8iNuMP3dxIcP/00HGnTnaUH8hckkICDP3Dle
ry/ohUBRawMEenbnOP7YHF5cr4gMzfSOPNE2jnxYUSXfO8cm1GL0+wTUOr4xtpvr
+u7xMbLyshpyqqUu70P0dBCN3RWEABnuK/Sd7nfHCO+46IUdySLNk+k3++iIERhV
C9GxDCtyLNa0PDbeoxHl7o2mfaHbYWZ9buYUMOtJP5FRNxs0+eEFe7N39Ip6O6RS
yGiTeaDUuU9UNjv0ANJBbC59gwH9ESu005N6ZBcsrhZWLzyZ0NXOMoFZmEGhzJLC
MumnU1OVArqQtAC3uIndqdY4zkXK5bOYoAJyzhwWzk7DEavV3ssU6moLFxX8rBSK
R1V5T6d4Njrp+V2f0Ji68OWzzao+wL4t4uOY4uKog+BMo3cbpCNMYrHEp06OTxWX
i77hF0C5NfE9Ij0AUHPWJyiI5f4CIlzPtBVEir3qeMBJ+qcjzEgyRgSN7ILVuzw3
kwxIY3MTWv0352guk0WvOaYiZEqbrDm4fKzuAAAthXagwJBW3exEwd0Xx7a/UoK5
lhgN1VIklc/Ibwcz+VnNdgjf6aEmr4gv454ZSbNuAuI9k2JbVC5ocG7gYY9VByx+
9VyyzbQ+s1+Aofzlg4r8vOGO74l4rSguTwoCTgeorYA7/olGhLyBz1ic7/y5RhK+
33KMVcyPmzbJizMexD+V
=eEeF
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
