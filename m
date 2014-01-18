From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Sat, 18 Jan 2014 19:11:49 +0100
Message-ID: <20140118181148.GA10339@earth.universe>
References: <20140116213954.4167.37071@quantum>
 <87r486mrh5.fsf@linaro.org>
 <20140117175312.GH7993@atomide.com>
 <52D9723A.6000700@ti.com>
 <20140117205832.4167.95162@quantum>
 <52D9C484.6000404@ti.com>
 <CAOesGMiniMi9xG6ByL0pQE7wzpM82JB40cPvfJcSYkXPs3PrDw@mail.gmail.com>
 <52D9C88C.3020508@ti.com>
 <CAOesGMjB-Np1hkHfAPWeCxGK20OzWBt5zumFzDp5WLKTrntUAQ@mail.gmail.com>
 <52D9D6C6.2000700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:58524 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaARSMS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Jan 2014 13:12:18 -0500
Content-Disposition: inline
In-Reply-To: <52D9D6C6.2000700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 07:20:06PM -0600, Nishanth Menon wrote:
> On 01/17/2014 06:23 PM, Olof Johansson wrote:
> > On Fri, Jan 17, 2014 at 4:19 PM, Nishanth Menon <nm@ti.com> wrote:
> >> On 01/17/2014 06:12 PM, Olof Johansson wrote:
> >>> On Fri, Jan 17, 2014 at 4:02 PM, Nishanth Menon <nm@ti.com> wrote:
> >>>
> >>>> clk-next-6a0cad9 + next-20140117 multi_v7_defconfig + CONFIG_LPAE=3D=
y:
> >>>>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21GRhEOj4
> >>>>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20zcNsD8h
> >>>>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s27U9IfRKR
> >>>>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2zYyeonec
> >>>>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21iCRjTHK
> >>>>  6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s20bPGL3Sz
> >>>>  7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21AhFmkCk
> >>>>  8:      crane: No Image built - Missing platform support?:
> >>>>  9:       dra7:  Boot FAIL: http://slexy.org/raw/s21Qh3sQRu
> >>>> * DRA7 not enabled?
> >>>> 10:        ldp:  Boot PASS: http://slexy.org/raw/s21fvBfBgs
> >>>> 11:   panda-es:  Boot FAIL: http://slexy.org/raw/s20RsgVUZJ
> >>>> * known issue (https://patchwork.kernel.org/patch/3084521/)
> >>>> 12:    sdp2430:  Boot FAIL: v6 platform - wont boot with multi_v7
> >>>> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20rhjjBwe
> >>>> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2My0UfNPm
> >>>> 15:       uevm:  Boot PASS: http://slexy.org/raw/s21aqF6eMN
> >>>> TOTAL =3D 15 boards, Booted Boards =3D 11, No Boot boards =3D 4
> >>>
> >>>
> >>> I have a hard time believing the above; A8/A9 boards are not bootable
> >>> with CONFIG_LPAE=3Dy...
> >>
> >> You are right! Drat!! I had CONFIG_LPAE=3Dy in my script, not
> >> CONFIG_ARM_LPAE=3Dy! Grrr...
> >>
> >> Retest in a around 30 mins..
> >=20
> > It's not a huge concern though; it's unlikely that LPAE makes a
> > functional difference on this patch series. It's still useful to catch
> > warnings, etc (most likely printk formats and the like).
> >=20
> I suppose, as expected:
> clk-next-6a0cad9 + next-20140117 multi_v7_defconfig + CONFIG_ARM_LPAE=3Dy
> * .config =3D http://slexy.org/view/s208uSeQS8
> * Build warnings: http://slexy.org/raw/s20n7YwbwN
>  1: am335x-evm:  Boot FAIL: http://slexy.org/raw/s20tF2eUZG
>  2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2uP65lOMQ
>  3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s2Lx13gsFZ
>  4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s2eOLXxvsT
>  5: am43xx-epos:  Boot FAIL: http://slexy.org/raw/s24coJzGvR
>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s240WznuPd
>  7: BeagleBone-Black:  Boot FAIL: http://slexy.org/raw/s20NG2UVTU
>  8:      crane: No Image built - Missing platform support?:
>  9:       dra7:  Boot FAIL: http://slexy.org/raw/s21T3RpHx2
> ^^ might probably boot if we enable CONFIG_SOC_DRA7XX in multi_v7
> (this is another A15 target)
> 10:        ldp:  Boot FAIL: http://slexy.org/raw/s2F4VO9hDM
> 11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s20HpzT1jW
> 12:    sdp2430:  Boot FAIL: http://slexy.org/raw/s21snV1EvL
> 13:    sdp3430:  Boot FAIL: http://slexy.org/raw/s2FwkVfG5R
> 14:    sdp4430:  Boot FAIL: http://slexy.org/raw/s2xiWxlpTj
> 15:       uevm:  Boot PASS: http://slexy.org/raw/s2LWUOmfiG
> TOTAL =3D 15 boards, Booted Boards =3D 1, No Boot boards =3D 14
>=20
> I am running a defconfig set check on next-20140117 and will do one
> with next-20140118 once that is ready for comparison results

Just for reference: I tried booting Nokia N900 using mike's
clk-next-omap branch (HEAD =3D 3e04915):

n900:  Boot PASS: http://paste.debian.net/77085/

-- Sebastian

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJS2sPkAAoJENju1/PIO/qau8kP/27ACAmU6bq4rTUQRfFtd2F1
0rfy6ulRl+oHKJyC/vGfG8vq17xeTP115zT5kin+ik3FkGpZpetjoss5sENt7AUG
IfnEVKYPjRR+jjiDBRBTj5KlTffkZXp1CtTcN4dG5Gu4Qur9fuUGqbYy3n41DtwQ
nadoQySRdCzwDD5Z8QBRZda74FTGM6ELeNFLnY6lVUfMA7YwAusHaw3iI6kZ92yT
wW5LDIrJVgLfTNt4hE/pfXJ389JhLO37lRzXOd6xXkqF34wZLxWoqPtW0IBre0ET
suNr2Qx2P375ecjJiTgMekMZ+s1V4Il1i+bpSh4yYNOhEYZQZ2DCLPKI04g7JmMt
SL6vKs9NeE+mFs978542dNQ6dnHIFcVfycW16Z1n/ZzBpeSk7XN4qZfO5ngYNZzy
+SMNYtzNl6CIeJz0fiPIAVRj4KqQqRtU7o2I3J4OwOgAu4gji593kFxmg0ldq7tf
dAi0vLNk8p8JghEBfk4ZJ6PmbTUxoMhBvLFRHwTEmy3uqWZiy0CtSj9sbIEeCD/E
seXjHsTmJrmDvx5e7PMczTBA02O7SQIf0Ltgi6Hq5+KB+MMvOs915SksxaY1U0o0
IHb/+tgyTBiwLTtMrgWPEvpDVGOpRkluxy8dCGlUnmUmhqN98DARWUQNB8febr4Y
NLPc2b6fE4bpRW0sb6Hc
=8BxF
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
