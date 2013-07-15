From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] [RFC] usb: dwc3: removal of assumption that usb3 phy
 always present
Date: Mon, 15 Jul 2013 22:17:24 +0300
Message-ID: <20130715191724.GA4063@arwen.pp.htv.fi>
References: <1372919202-26755-1-git-send-email-ruchika@ti.com>
 <51D6D999.5020505@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35966 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124Ab3GOTRv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 15:17:51 -0400
Content-Disposition: inline
In-Reply-To: <51D6D999.5020505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruchika Kharwar <ruchika@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 09:35:05AM -0500, Ruchika Kharwar wrote:
>=20
> On 07/04/2013 01:26 AM, Ruchika Kharwar wrote:
> >DRA7XX has several USB OTG subsystems. USB_OTG_SS1 includes a USB1 and U=
SB2
> >phy. USB_OTG_SS2 includes only a USB2 phy.
> >This patch allows the dwc3 probe to continue if a usb3_phy is not found.
> The need for this will go away as soon as "of_get_maximum_speed" is
> introduced. The speed can then be used to determine if a USB3 phy is
> required or not for dra7xx as well.

there is one problem with this approach (even my approach which I had
cooked before).

I was testing OMAP5 today (finally got most pieces in mainline, so I
could test something with little out of tree), and as it turns out, the
USB3PHY DPLL is used to generate the PIPE3 clock and that clock is used
to power some important part of the IP.

=46rom what I could grasp out of OMAP5 ES2.0 TRM and Synopsys databook, I
believe OMAP5 decided to tie ram_clk to pipe3_clk (the PIP3 bus clock)
and if we let USB3 PHY be optional on OMAP5, we might end up with broken
DTS files which cause device not to work.

That aside, what caught my attention is how the problem exposes itself:

	We end up in a situation where DWC3_DEPCMD_SETEPCONFIG never
	completes although the previous DWC3_DEPCMD_DEPSTARTCFG
	completes just fine.

This happens early on, when we're trying to enable physical endpoint 0,
then the driver bails out.

I'm assuming that DWC3_DEPCMD_DEPSTARTCFG is very easy to process, maybe
it just puts the internal FSM into a post-idle state which simply waits
for the endpoint configuration to come through the registers while, in
turn, DWC3_DEPCMD_DEPSTARTCFG is far more complex to process and needs
other parts of the IP to be fully powered and clocked in order to
complete.

If my speculation is correct thus far, it also means that those blocks
are somehow powered by pipe3_clk (or a derivation of it).

It would be nice if SNPS could shed some light here, but I'll continue
digging the docs, for now the feature of optional USB3PHY will be
pending in a separate branch while I try to get all information related
to this problem.

The decision came after figuring out that if we don't
usb_phy_init(dwc->usb3_phy), OMAP5 would never, ever work because the
USB3 PHY DPLL is locked in ->init() callback of that driver in ordre to
conserve power.

cheers

--=20
balbi

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5ErEAAoJEIaOsuA1yqRE/goQAKNjhl4s0bXqYf2vuKlER2O/
kXGIldX+e8UvrqoKff7s+lDSTyZP8BdKtcfOpIb/KpZ8/VDYI4mdg0V8LGaIOC5w
pdoRpBPdTn0x4YMeTmVzywwHdYfzKiZUfyYEa8LuyfaochNBpjAM/bwIllvTLP8R
LE4Tv2jryssC4P0gdLsH4vsOQU0jKXdhHECXiUV9PTKIg6H+35xIUvKKpgN9GTSb
XFtagPtjCWlwd72XvAMXLwTrrgEIpgJQal8uBCf0KbTOaULdU/Fb2wLzJll5j92/
dYUdEfnCknhu+16kleytDhYytjlYpvSk7BTyr3EpvLSDL2ebG/My0wk6ZrAGvxE8
AfJWoO20ejSxrdbdieuiHm+1ZC6kV1pnDg4VoQnZN6+QYqTeaia0mQV17wz5Wh18
/zq1k8qZbPuPl3H4rlPmqohGguwqavauPH8FXcwRYMPP+Woe++6Ntk2cOjogzH5a
3vJ+3LthEInZlJr0W/WMkaveXoSp6un2P25l5LcDdp2Y+69YghV2c1vrqTcB8s9A
vys6vRwgrbq4KerJ7CP1Q8rzkip5GBWb9YSVbv7Ulai2owDmHxi1kB4tshdrjwnT
GHeDd8QV/4aM2uFnSs4FJ8DBALO6S9DNpIP15He5j2gEmeBMSlJbHC4kkOUpaPZJ
XAzF1vbIyZUonGYQdyF1
=iT1k
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
