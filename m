From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv2 3/3] arm: dts: add bandgap entry for OMAP4460 devices
Date: Wed, 29 May 2013 11:42:35 -0400
Message-ID: <51A621EB.5080805@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com> <1368629928-6723-4-git-send-email-eduardo.valentin@ti.com> <5193A875.1020000@ti.com> <5193B9AA.7020507@ti.com> <519488D3.5070003@ti.com> <5194D0AF.3010407@ti.com> <51A60C74.4010307@ti.com> <51A60E7E.2070905@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2KVESOHHRXAJFUWOMHFSK"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A60E7E.2070905@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

------enig2KVESOHHRXAJFUWOMHFSK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29-05-2013 10:19, Cousson, Benoit wrote:
> Hi Eduardo,
>=20
> On 5/29/2013 4:11 PM, Eduardo Valentin wrote:
>> Salut Monsieur Benoit,
>>
>> On 16-05-2013 08:27, Eduardo Valentin wrote:
>>> On 16-05-2013 03:20, Benoit Cousson wrote:
>>>> Hi Eduardo,
>>>>
>>
>> <cut>
>>
>>>> We need to check.
>>>
>>> Yeah, I also dont think this will work, because we will reparent the
>>> interrupt, setting to a different controller. That will break the TAL=
ERT
>>> signal already defined at GIC (check original patch).
>>>
>>> I propose keeping the way I sent. Unless there is a way to set two
>>> different controllers to same device.
>>>
>>
>> Any idea on this patch? Shall we keep the way it is?
>=20
> Well since we cannot use directly interrupt, I think we need to use at
> least the proper gpio binding.
>=20

hmm... OK. sounds reasonable. I will change the driver and resend this
one in one single series.

> Thanks,
> Benoit
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2KVESOHHRXAJFUWOMHFSK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGmIesACgkQCXcVR3XQvP37TQEAxrSUBxkTI4JmfVk7HhZWLm0g
G9lnqJzWPAGmxXVi6yYA/jiTHsN0hzhgGxYSTuTK2S/iITYDpfH6mDuLyew4Z64A
=wxT/
-----END PGP SIGNATURE-----

------enig2KVESOHHRXAJFUWOMHFSK--
