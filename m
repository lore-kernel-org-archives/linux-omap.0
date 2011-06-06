From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
	to use REGULATOR_SUPPLY
Date: Mon, 6 Jun 2011 20:13:28 +0300
Message-ID: <20110606171326.GK12242@legolas.emea.dhcp.ti.com>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
	<20110606092126.GG18731@legolas.emea.dhcp.ti.com>
	<EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0872620745=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Nishant Kamat <nskamat@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org


--===============0872620745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Content-Disposition: inline


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2011 at 11:45:29AM -0400, Oleg Drokin wrote:
> >> -static struct regulator_consumer_supply sdp4430_vaux_supply[] =3D {
> >> -	{
> >> -		.supply =3D "vmmc",
> >> -		.dev_name =3D "omap_hsmmc.1",
> >> -	},
> >> -};
> >> +static struct regulator_consumer_supply sdp4430_vaux_supply =3D
> >> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
> > this should be an array, as it was before.
>=20
> Only one is defined right now.
> Whoever needs a second element can convert it to array, I think?
> What;s the importance of having it as an array right now?

because later patches will be easier to review. Look below:

When I have this:

static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
};

static struct regulator_init_data sdp4430_vmmc =3D {
	.constraints =3D {
		.min_uV			=3D 1200000,
		.max_uV			=3D 3000000,
		.apply_uV		=3D true,
		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
					| REGULATOR_MODE_STANDBY,
		.valid_ops_mask	 =3D REGULATOR_CHANGE_VOLTAGE
					| REGULATOR_CHANGE_MODE
					| REGULATOR_CHANGE_STATUS,
	},
	.num_consumer_supplies  =3D ARRAY_SIZE(sdp4430_vmmc_supply),
	.consumer_supplies      =3D sdp4430_vmmc_supply,
};

and I want to add a new REGULATOR_SUPPLY() the diff is simple:

@@ -1,5 +1,6 @@
 static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
+	REGULATOR_SUPPLY("vmmc2", "omap_hsmmc.0"),
 };
=20
 static struct regulator_init_data sdp4430_vmmc =3D {

now when I have this:

static struct regulator_consumer_supply sdp4430_vmmc_supply =3D
	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");

static struct regulator_init_data sdp4430_vmmc =3D {
	.constraints =3D {
		.min_uV			=3D 1200000,
		.max_uV			=3D 3000000,
		.apply_uV		=3D true,
		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
					| REGULATOR_MODE_STANDBY,
		.valid_ops_mask	 =3D REGULATOR_CHANGE_VOLTAGE
					| REGULATOR_CHANGE_MODE
					| REGULATOR_CHANGE_STATUS,
	},
	.num_consumer_supplies  =3D 1,
	.consumer_supplies      =3D &sdp4430_vmmc_supply,
};

and I want to add the same supply, the diff is less obvious:

@@ -1,5 +1,7 @@
-static struct regulator_consumer_supply sdp4430_vmmc_supply =3D
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
+static struct regulator_consumer_supply sdp4430_vmmc_supply[] =3D {
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
+	REGULATOR_SUPPLY("vmmc2", "omap_hsmmc.0"),
+};
=20
 static struct regulator_init_data sdp4430_vmmc =3D {
 	.constraints =3D {
@@ -12,6 +14,6 @@ static struct regulator_init_data sdp443
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  =3D 1,
-	.consumer_supplies      =3D &sdp4430_vmmc_supply,
+	.num_consumer_supplies  =3D ARRAY_SIZE(sdp4430_vmmc_supply),
+	.consumer_supplies      =3D sdp4430_vmmc_supply,
 };

can you see now ?

--=20
balbi

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7Qq2AAoJEAv8Txj19kN12JkH/RHhgIUMqSqoFCVToq+RYohR
GAIxw8rGqaFa0wvFB10/gTOck8QZgCuJxe1k6cmSBJ+bZIrvvWbHqJEm6hqUi1uF
vZYmwtJUIngr+usy4VwVhOj60jXm8ihQ0cKeSvoB8619qbU6BR2GAvfQBGWflFA2
P/rlGMcXnTFepyv70OaTgpfqW8VtgLDBfvBRd4Iuv/RDlYlbEvqzB3zU/NVSPify
kfytkSB1T/+9bKcnNxAMxdBe7ho3S7+A92P0pms0Ag6pMjuTXdYtdwDpoZ3HPI+r
5/p+EjKwpjsF61bIWAVq6RusNY1WeOJ5jj66mjgB14JRFu83C708DOchMNq+mQY=
=DQdn
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--


--===============0872620745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0872620745==--
