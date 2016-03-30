From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Wed, 30 Mar 2016 16:10:00 +0300
Message-ID: <87mvpgi02f.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457594332-7490-3-git-send-email-tqnguyen@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org
Cc: Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Thang Q. Nguyen" <tqnguyen@apm.com> writes:

> [ text/plain ]
> From: "Thang Q. Nguyen" <tqnguyen@apm.com>
>
> The xhci-hcd child node needs to inherit archdata attribute to use
> dma_ops functions and attributes. This patch enables the USB DWC3
> driver to pass archdata attributes to its xhci-hcd child node.
>
> Changes from v2:
> 	- None
>
> Changes from v1:
> 	- None

changes should be between tearline and diffstat.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+9AoAAoJEIaOsuA1yqREd48P/3xxKJCWbQYW83UwzDUo+N0x
3bFp1ybQLw4PdYm76kLK+Wi6XTZZgkxdO1DueC+eR8ZyOvKs6U/NcBpe16iQVcQy
51kUPmGuKxkwZyDdIj6JP702EADdcP6qvnOMUP8XH/pB8zmJ3Om47+YJzgo0ngyI
q4c10ZkarT127uVGMrEGrH5a2e/dnBctZ1wUK4kjhzfuKjyFmlE0toYdnsq1dhGx
byU2xHQwQ3jj2DEjWmV6+AOSvho4Hwti5WS0ox0AC38jPohiZvqwa1Lh4eeB1/PO
yIlkCllHRhtQpfLK8t2Kor8ZEE4Yf9aApswVyCyCB4EuFMb2NtYr0PlOamiv94El
DKA4PktnEbfI7mp7I/nFYcoUOWOr4yBPwhtZKLQpXh//zJc3AKASvvPowDMIzBx8
aY9AceqGBMZR2bMCmzKENuEPhDg1jyd2Si1dAPS4pInudz3aCj7hFSoy35tF3t+U
BsJ1E923xyV8P1GkxxjkWihIbcgkJNOWiikSvvI5f8KxKRS9gsbZqkeUMrAqQuYH
5TPTnwJG6GHT2jL3uVJfgaMgKXAbRcdOztRIfwg6VsBFPJx9usWWPKGctApRPYe9
eCIT4Q0PI6jtedBN2Aim/DYt/FM69EbL+QRTLO8stL88kn2U05ibQYAm7uuyfCE1
wOB4nBIdBI+w00hAoqLc
=lrLN
-----END PGP SIGNATURE-----
--=-=-=--
