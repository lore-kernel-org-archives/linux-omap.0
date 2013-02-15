From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 1/2] ARM: OMAP2+: hwmod-data: UART IP needs
 software control of sidle modes
Date: Fri, 15 Feb 2013 14:50:55 +0200
Message-ID: <20130215125055.GA16558@arwen.pp.htv.fi>
References: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161286Ab3BOMvL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 07:51:11 -0500
Content-Disposition: inline
In-Reply-To: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2013 at 05:38:26PM +0530, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>=20
> This however breaks in case of device tree because of missing
> idle handling. With the provided flags, idle mode handling is transparent=
ly
> handled by runtime time pm code.

this last sentence can be improved a bit.

--=20
balbi

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHi8vAAoJEIaOsuA1yqRE4dAP/2rL9+9lnkagVdJzcBkbGMni
tjfM5UlQCOjKRdBkTpSX7q1p4XvLPCubr4retgmjIP+m5i4smsRY4JJ4nCsJxy8y
ok22gG/oqpSIAJUNeeyNFsHpEzadPI8abR03K4pSdjapmIRxNEWhdD18Pp+hjZEu
38IsRDlF/TLCl0V2S6I+dfpFBtyMoxv0QiV1AWEj5PA183ofRxKxRX38NGhyyn78
X/t7aQD0ryzJWM1IgfZJ/erLJiFKYRmhdtFyH0YPumiT6b1J9bpP7fSR7zQsOYVY
OIZP2TwG+c4uMRmzfW1QIvumwGWiPQPVHYLNl8M9RyizMJZLpGBSi9beUr9ld45b
KJKwgpocoYp7P47cYJ4zrlsZF4An8Nf87vnCxjngoAg/2XxvObyjC2ijzDiFMuG1
Fxynp6SVkruorYLz6PR/Ho2lhBuwItTPe0u6alNxg7NyvISxInoClj94oL9VVx/I
Hg/4P2daCNT4IFvdub65wfX3nX54tFFA2ka618HGhUJBnnrGqyT8AxZZE6Gab5gL
PYoCbsTtBelQ8Pi6QEvKbCmCKfVFuUlvTjmK6CP7Mg+UrkVaNhhxwHfN2GAuwGzd
pSdYPrJ5+UFeUMUm4bRjmC06YrK9VaVeraXc3CC+h37cEfVLvLxzQ+pFLzKtL7G4
3hrMJ3ClPSDgnSTMieOv
=/a8d
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
