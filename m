From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv2 1/3] arm: introduce config HAS_BANDGAP
Date: Tue, 4 Jun 2013 08:32:58 -0400
Message-ID: <51ADDE7A.6090205@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com> <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com> <CAOMZO5CL=apxbkCHA6Xsw+m5d-rhe_VcOaA9KpkSmiJ=ZRL7gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2UKPRLSOVCDOFNSFTPXTT"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CL=apxbkCHA6Xsw+m5d-rhe_VcOaA9KpkSmiJ=ZRL7gA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

------enig2UKPRLSOVCDOFNSFTPXTT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Fabio,

On 31-05-2013 11:12, Fabio Estevam wrote:
> On Wed, May 15, 2013 at 11:58 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>> Introduce HAS_BANDGAP config entry. This config is a
>> boolean value so that arch code can flag is they
>> feature a bandgap device.
>>
>> This config entry follows the same idea behind
>> ARCH_HAS_CPUFREQ.
>=20
> It would be nice if you explain what BANDGAP means here, since you
> introduce this option in this patch.
>=20
>=20

Yeah, I didnt do it because bandgap is a common term used in digital
circuits [1,2]. Also, as in this patch we do not add term different from
the common used bandgap term, I believe it is self explanatory.

I any case, I am resending with minor explanation.

[1] - http://en.wikipedia.org/wiki/Bandgap_voltage_reference
[2] - http://en.wikipedia.org/wiki/Silicon_bandgap_temperature_sensor

--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2UKPRLSOVCDOFNSFTPXTT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGt3noACgkQCXcVR3XQvP2ANwD/eP/deBrhTgpAmIworDP0bhj0
TZFZ2SS4hPovUf5fQBoBANBj2D06tTpnQZxABD6zhYpoozhzIM9/yD1LoVc0GzDU
=Hi6J
-----END PGP SIGNATURE-----

------enig2UKPRLSOVCDOFNSFTPXTT--
