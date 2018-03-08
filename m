From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu, 8 Mar 2018 19:00:16 +0100
Message-ID: <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
References: <20180308093121.11943-1-merlijn@wizzup.org>
 <20180308164613.GH14921@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hZm75pODmaTlC2rCo1648J4tazCEjJbCy"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308164613.GH14921@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hZm75pODmaTlC2rCo1648J4tazCEjJbCy
Content-Type: multipart/mixed; boundary="Erz2WJu99MJKUZTagPtI0FRF5jcanhWAv";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
 linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
References: <20180308093121.11943-1-merlijn@wizzup.org>
 <20180308164613.GH14921@uda0271908>
In-Reply-To: <20180308164613.GH14921@uda0271908>

--Erz2WJu99MJKUZTagPtI0FRF5jcanhWAv
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/03/18 17:46, Bin Liu wrote:


> No need to flush, the work is already cancelled at this point.
>=20
>> +
>>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>> +	musb_platform_exit(musb);
>=20
> This can be move down to out side of holding the spinlock,
>=20
>>  	spin_unlock_irqrestore(&musb->lock, flags);
>=20
> to here.

Thank you - with I've verified that it works with these changes. I'm
surprised, because I believe that I had tried this already. I must have
missed a step in my testing-routine.

I will send a patch shortly.

Cheers,
Merlijn


--Erz2WJu99MJKUZTagPtI0FRF5jcanhWAv--

--hZm75pODmaTlC2rCo1648J4tazCEjJbCy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqF6MAAKCRAGN09rynK8
WnwlAQDgI+riQNOpGw/F6Y5s/lB5gMX/BlHIaF/xZYU0qhhGHAD/aH7m4PUJjiXH
vhZzxUJi3W4oTueuQMh2b5UeRmpG/AY=
=A+1J
-----END PGP SIGNATURE-----

--hZm75pODmaTlC2rCo1648J4tazCEjJbCy--
