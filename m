From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 14:27:27 +0300
Message-ID: <561E3C1F.5000406@ti.com>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
 <20151014111939.GB14340@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WSCMOfi7aURIu9GCrMg9abmABnwxm2PL8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014111939.GB14340@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: tony@atomide.com, wsa@the-dreams.de, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--WSCMOfi7aURIu9GCrMg9abmABnwxm2PL8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/10/15 14:19, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Oct 14, 2015 at 01:44:16PM +0300, Roger Quadros wrote:
>> Let's keep the SSI ports disabled in the omap3.dtsi to avoid
>> getting the following noise on the console for boards that don't
>> use the SSI ports.
>>
>> "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=3D=
-2)"
>>
>> As omap3-n900 uses one SSI port, mark it enabled there.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>=20
> Acked-By: Sebastian Reichel <sre@kernel.org>

Would it be preferable to disable the ssi-controller node as well in the
omap3.dtsi file?

cheers,
-roger


--WSCMOfi7aURIu9GCrMg9abmABnwxm2PL8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWHjwoAAoJENJaa9O+djCTLQwQAIhj2CdIQzcMhPw/7shbUD6Y
VKdIAXoZIVj1MCFRf2tNva0U+s2aRC53gveNUuzJIhT+YUwIBJ8e+Fw6fkwB4Pne
E+dunZmgJRKznb4S1vCLElgTK4c9jxFJYoCl4QfQPU2QZde1D4g6nu3BJXSjCySl
qBfPlabHuP2jzd3BwOIa6+DC6jO6yesRVEDCepMI0wgBwQuCKpDIEyzm4zUa/kFk
VSEiGu4TZzjAUEjpmHJvLH5zni+NA6b/wXjWFat+I9M04vpw6mVmHzGThG6/cSPj
Lzlu+1jnGNqciJdTLkVhhHX0hckWkM4PwRDOXyTa668OlP7r6877KP1jYkXQu711
+GRB64DrafILwqcmfr4uXTUSpKZdFSL7BzEvE1HxOhmKj8poKX11j+SZMDnVyvsg
cjCEmbVxBT9NK4KQeUs2iuQ+//bQq8Re9g6zEGIA0q8DsEVCrP/BHSNkCAOg+FkJ
chlSAYYL1nDRdDPWcBCjrReVmDrKjTjPb+o1dyG9CeZokK/tq5HZVc++JA2UCLVm
oFYz2WX2xx4+JMgy8VSA7yj9glh/X0AVN8Qx6vNsPwz6isHT2W63iE/XKguhauqb
0MU7wcJ3U/IT4vdkBzbqHL+lm0cttCJmLsml5VuC/CFsaT4nAl668AZxM8SIOdI+
8baVRCkP/45L3CGIgKXG
=gn5h
-----END PGP SIGNATURE-----

--WSCMOfi7aURIu9GCrMg9abmABnwxm2PL8--
