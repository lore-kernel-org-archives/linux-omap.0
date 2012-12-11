From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 12:20:11 +0200
Message-ID: <20121211102011.GG19367@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
 <20121210145947.GK11038@arwen.pp.htv.fi>
 <50C5FD73.1000408@communistcode.co.uk>
 <20121210183500.GB14303@arwen.pp.htv.fi>
 <50C70846.7010207@communistcode.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab2LKK1U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 05:27:20 -0500
Content-Disposition: inline
In-Reply-To: <50C70846.7010207@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <ml@communistcode.co.uk>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 11, 2012 at 10:17:42AM +0000, Jack Mitchell wrote:

<big snip>

> Shubhro, Felipe,
>=20
> Thank you, the reordering dma patch fixed the dma issue I was having!
> However, the bad news, I now get the same results for the dma and
> non-dma spidev test. While the scope shows the SPI clk and data is
> fine, the reading from the program still shows 0x00 for all words.

<removed spidev_test output>

> dmesg shows nothing of interest apart from the spi bus setting up.
> Any ideas?
>=20
> To iterate for my own sanity; I have bridged pins 18 and 21 on the P9
> header which should be the d0 and d1 spi data pins for spi0. This
> result of 0x00 usually comes from a result of not joining the pins,
> but I can assure you they are joined!
>=20
> Thank you for the help so far.

according to the schematics [1], those pins are muxed as UART2_TXD and
I2C1_SDA, have you remuxed them properly ? Can you try with pins 29 and
30 on the same header ? That's SPI1, so you will have to add DT data for
spidev on that bus too.

[1] http://beagleboard.org/static/beaglebone/latest/Docs/Hardware/BONE_SCH.=
pdf

--=20
balbi

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxwjbAAoJEIaOsuA1yqRE6gUQAJQFekEdRzSmj0teyuT1IpOn
UpKO03eRcg/Am8dgWZ6AO43J/aXKRLibqJ5vxVrai43kejwnTjQ1yFKbymeai0FC
IZrusw9vTinjRy09Sq9Dl9vAqT1ItCWcnr+qaRLDDezvkrdl4E/+Rz6GEE565oJJ
9n5Wjj59QC2VYOCuTqhIlfcPJ4RtqxH+fn8yFJgjJlhyya7VpDFZt3FCBdU+dqfz
kOjXzyRXCeEzfGR1gCD1ccYELbIrHBbv0mfJRAQf1+pwbneIGB3A6IpsuR7dPNcB
edQZ09lZlvXYbEFS0Dnq0eLQU3PjQENNCs2OKyxAuLZVzLc0ZP9mYWBUdHp+M5/j
+SSsNpu0bwNcky2WNwvqIRDvuqJsET6TJiZpc3dEHFwXtUHdXDbAVSYc4tzbd6en
C37qzckIHMZ1T7xTbkHVdA2Qhzb9CCjUrSzxvJewWHAhQBNksjO7piDP4rIcLD34
m1zk5kBDfzejp+bQqNUvmGyb+S16qy3X5S77DOCuwzUI/fvnPwvPkhXnJYK2PNMO
rdp+aVy57nG/HLAY6pSdtUF2rexCssck3cjfoOrg+i4YNTcRCv7d1vKaLoqiqEWr
AXwiU9WXolt6BLtYzo7X+m83wC6t2oLxu9fKDjWu7vGZucCnQtCEAld0FfGyk/zy
k9MRzE/iAvZNbWRP2b3q
=S0yA
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
