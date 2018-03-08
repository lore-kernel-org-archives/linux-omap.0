From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu, 8 Mar 2018 23:17:48 +0100
Message-ID: <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
References: <20180308204049.29474-1-merlijn@wizzup.org>
 <20180308211525.GJ14921@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308211525.GJ14921@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk
Content-Type: multipart/mixed; boundary="k49r6CPKRrTkyWNAwi9FQK9rq2GfAxbBA";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
 linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
References: <20180308204049.29474-1-merlijn@wizzup.org>
 <20180308211525.GJ14921@uda0271908>
In-Reply-To: <20180308211525.GJ14921@uda0271908>

--k49r6CPKRrTkyWNAwi9FQK9rq2GfAxbBA
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/03/18 22:15, Bin Liu wrote:

> please add patch version numbers in the subject when necessary. This
> helps cross-referencing.

Will do. I naively assumed that the first patch would implicitly be
number 1. Will send out v2 now.

>> =20
>> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>=20
> Does it solve the issue if not moving this line? I'd like to have
> minimum change if possible.

Yes, it does. The only reason I moved musb_writeb is because I
understood you wanted me to move both (per previous message: "This can
be move down to out side of holding the spinlock").

Thanks for the tips.

Cheers,
Merlijn


--k49r6CPKRrTkyWNAwi9FQK9rq2GfAxbBA--

--BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqG2jQAKCRAGN09rynK8
WtJ4AP4gr4QRu+iZHEY1fP6vDc5hm7+e6TEtFNkIdmwFdCLXoAEA6RqkCUMx2v8o
ncTfy4KbWPE6VufCw2lfB/2fLkWVWQc=
=Uwkz
-----END PGP SIGNATURE-----

--BP69vjzFv59E1ArwQG3w5DE8LTP1MK6hk--
