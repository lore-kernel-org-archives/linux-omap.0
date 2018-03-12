From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
Date: Mon, 12 Mar 2018 23:30:39 +0100
Message-ID: <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
References: <20180308221949.12054-1-merlijn@wizzup.org>
 <20180309141130.GM14921@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309141130.GM14921@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1
Content-Type: multipart/mixed; boundary="O7xnJYU27dPwxbH59fq8DAMfxtW76xdW9";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
 linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
References: <20180308221949.12054-1-merlijn@wizzup.org>
 <20180309141130.GM14921@uda0271908>
In-Reply-To: <20180309141130.GM14921@uda0271908>

--O7xnJYU27dPwxbH59fq8DAMfxtW76xdW9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Bin,

On 09/03/18 15:11, Bin Liu wrote:
> Hi,
>=20
> On Thu, Mar 08, 2018 at 11:19:48PM +0100, Merlijn Wajer wrote:
>> This fixes an oops on unbind / module unload (on the musb omap2430
>> platform).
>>
>> musb_remove function now calls musb_platform_exit before disabling
>> runtime pm.
>>
>> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
>=20
> Applied. Thanks.

Thank you. Is there any chance that this patch and the vbus patch could
end up in the 4.16-rc series? I was waiting for another rc to see if the
vbus patch would land, but it didn't land with 4.16-rc5.

Cheers,
Merlijn


--O7xnJYU27dPwxbH59fq8DAMfxtW76xdW9--

--UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqb/jwAKCRAGN09rynK8
WhpvAQDSuTmrMue0QSzM6ybPqwVFmIOYvbA/EJxsc8iBgT2u/AD+Logq+0vKNYp4
wbJqVHTIK6iQik+3j68BkaxGdKNnwQI=
=Y3T/
-----END PGP SIGNATURE-----

--UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1--
