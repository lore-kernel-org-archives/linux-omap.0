From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Thu, 31 Mar 2016 11:04:36 +0300
Message-ID: <87k2kjgjjf.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-3-git-send-email-tqnguyen@apm.com> <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com> <87egashxz8.fsf@intel.com> <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Thang Q. Nguyen" <tqnguyen@apm.com> writes:
> [ text/plain ]
> Thanks Grygorii for information.
> I checked but do not see dma_init_dev_from_parent is used in
> linux-next repository. Can you give me more information for what
> branch I can checkout to use it for USB DWC3?

dma_init_dev_from_parent() is still a proposal ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/NoVAAoJEIaOsuA1yqREQUcP/1kJrq9EUvoBIVRWde1dWFnY
lGJZJt8I8CZqvaDF8mNLas7rnkbMILmCpiUuP6Rv83vpsdgWsxFAHKC317XeD1GU
uL9GSaOIzTffEK05qVXcXEduf0dp4wUysnrv5Gs32PJjFkYI5YUr+kCNnAM9tzKf
GENWi7ZY6CvEjo86XHt9GOPipnlcGpy8uqsTd/KQjnGEVpa+nXIHuiYBL9wOTCZc
3J1sMQj/JFRnJxmMOcmfUj2vLFd7Qq8iTyRDFOKqTbkr5/4/eNTXQb7/36vllRE0
Yb6iLEtnvSa8S2W640u0SVkTRX4qzbxDGYrWwJFsVMQF8/U6Jp7JhHxgT3iJUefm
zIG5NstAZNC8Llh+wsFPPqQUVDJIy8bfsiPaPDU0Ic+Y9bF2cgOrJms0Pbdt+Al+
WciaLHlpK3Pnq9KX6dLcJB33v1DCv6iU6OJMBR0KvDRAHvOVazGbiOmvapGOM2so
lzs9XpBWV3TwYN2qoJr3/dZfwdg5ElXMXjPIPvzjgMefvEMT/HVJST9cHALsbwnc
csvQXQI/yWQSLV01tCdraw3oohf3qy8GikClkEkkMCEOk6pLKYfaO+8/M181q4pH
u6QI5vxNKwzPlzyJulCDMjqJ0vcQLMSePj2wn8fmGBnr+atHjigxnfA0F3xXzRJ5
vsTra6n9546pkrsKj7ix
=ESK2
-----END PGP SIGNATURE-----
--=-=-=--
