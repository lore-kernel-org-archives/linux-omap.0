From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 14:21:44 +0200
Message-ID: <20121122121845.GB18022@arwen.pp.htv.fi>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org>
 <50ACFC5D.1090406@ti.com>
 <20121121195436.GF14290@arwen.pp.htv.fi>
 <50AD7C2C.7000608@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965073Ab2KVTQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 14:16:10 -0500
Content-Disposition: inline
In-Reply-To: <50AD7C2C.7000608@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: balbi@ti.com, Roger Quadros <rogerq@ti.com>, Alan Stern <stern@rowland.harvard.edu>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2012 at 09:13:16AM +0800, Andy Green wrote:
> On 11/22/12 03:54, the mail apparently from Felipe Balbi included:
> >Hi,
> >
> >On Wed, Nov 21, 2012 at 06:07:57PM +0200, Roger Quadros wrote:
> >>On 11/21/2012 05:32 PM, Alan Stern wrote:
> >>>On Wed, 21 Nov 2012, Roger Quadros wrote:
> >>>
> >>>>On 11/21/2012 04:52 PM, Alan Stern wrote:
> >>>>>On Wed, 21 Nov 2012, Felipe Balbi wrote:
> >>>>>
> >>>>>>On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
> >>>>>>>From: Andy Green <andy.green@linaro.org>
> >>>>>>>
> >>>>>>>This patch changes the management of the two GPIO for
> >>>>>>>"hub reset" (actually controls enable of ULPI PHY and hub reset) a=
nd
> >>>>>>>"hub power" (controls power to hub + eth).
> >>>>>>
> >>>>>>looks like this should be done by the hub driver. Alan, what would =
you
> >>>>>>say ? Should the hub driver know how to power itself up ?
> >>>>>
> >>>>>Not knowing the context, I'm a little confused.  What is this hub
> >>>>>you're talking about?  Is it a separate USB hub incorporated into the
> >>>>>IP (like Intel's "rate-matching" hubs in their later chipsets)?  Or =
is
> >>>>>it the root hub?
> >>>>>
> >>>>
> >>>>This is actually a USB HUB + Ethernet combo chip (LAN9514) that is ha=
rd
> >>>>wired on the panda board with its Power and Reset pins controlled by 2
> >>>>GPIOs from the OMAP SoC.
> >>>>
> >>>>When powered, this chip can consume significant power (~0.7 W) because
> >>>>of the (integrated Ethernet even when suspended. I suppose the ethern=
et
> >>>>driver SMSC95XX) doesn't put it into a low enough power state on susp=
end.
> >>>>
> >>>>It doesn't make sense to power the chip when USB is not required on t=
he
> >>>>whole (e.g. ehci_hcd module is not loaded). This is what this patch is
> >>>>trying to fix.
> >>>
> >>>Ah, okay.  Then yes, assuming you want to power this chip only when
> >>>either ehci-hcd or the ethernet driver is loaded, the right places
> >>>to manage the power GPIO are in the init and exit routines of the two
> >>>drivers.
> >>>
> >>
> >>The Ethernet function actually connects over USB within the chip. So
> >>managing the power only in the ehci-hcd driver should suffice.
> >
> >the thing is that this could cause code duplication all over. LAN95xx is
>=20
> I can see this point.  However DT will soak up these regulator
> definitions, at that point it's "for free".  On Linaro tilt-3.4 we
> already have this on the dts
>=20
> 	hubpower: fixedregulator@0 {
> 			compatible =3D "regulator-fixed";
> 			regulator-name =3D "vhub0";
> 			regulator-min-microvolt =3D <3300000>;
> 			regulator-max-microvolt =3D <3300000>;
> 			gpio =3D <&gpio1 1 0>;		/* gpio 1 : HUB Power */
> 			startup-delay-us =3D <70000>;
> 			enable-active-high;
> 	};
>=20
> 	hubreset: fixedregulator@1 {
> 			compatible =3D "regulator-fixed";
> 			regulator-name =3D "hsusb0";	/* tag to associate with PORT 1 */
> 			regulator-min-microvolt =3D <3300000>;
> 			regulator-max-microvolt =3D <3300000>;
> 			gpio =3D <&gpio2 30 0>;	/* gpio 62 : HUB & PHY Reset */
> 			startup-delay-us =3D <70000>;
> 			enable-active-high;
> 			vin-supply =3D "vhub0"; /* Makes regulator f/w enable power before res=
et */
> 	};
>=20
> which is the equivalent to my patch: I don't think we need to sweat
> about code duplication.

why not ? Just because you have some ready DT files outside of the
mailine kernel ? Sorry, not a good argument.

> >a generic USB Hub + Ethernet combo on one of ports from SMSC. *Any*
> >platform could use it and could hook those power and reset pins to a
> >GPIO. If we handle this at ehci-omap level, we risk having to duplicate
> >the same piece of code for ehci-*.c
>=20
> We need to consider power and reset separately.  Reset is a safe bet
> as a GPIO but power to the smsc chip is not.

so ? I'm saying that it *can* be attached to other architectures and
they *can* decide to put both on GPIOs. I'm not considering the
likelyhood of the situation.

> On panda they happen to fit a gpio-controlled linear regulator to
> provide the smsc 3.3V supply.  On another device that can just as

good to know, then we need a regulator driver (as you added on your DT
file the bindings for it) instead of poking into the GPIO directly.

Again it sounds like something that should be done at the hub driver
level. I mean using the GPIO (for reset) and Power Regulator.

not implementing the regulator part itself, but using it.

> easily be a PMIC regulator channel: it boils down to controlling a
> power rail.  So using struct regulator as the abstraction for the
> power is the right way already.

I agree with you here. Nevertheless, I'm arguing that this all should be
handled by the hub driver, not ehci-omap.

> >Since that's a hub driver anyway, I wonder if it would be better to play
> >with those gpios somewhere else ?!?
>=20
> The patch creates a regulator that binds to a magic regulator name
> defined by the hsusb driver, "hsusb0".
>=20
> That regulator is taken up and down by hsusb driver with the
> lifecycle of the logical hsusb device.  So inserting ehci-hcd module
> powers the regulator until the module is removed.

but this is wrong. What if we use a different HUB part, what if the same
HUB part is used in e.g. Tegra-based platform ?

This is why I say it's *wrong* to handle that at the OMAP USB Host part.
This is why I'm arguing that this whole thing should be handled by the
hub driver itself.

> Originally I bound the regulator to the smsc95xx driver, which also

that's wrong too. You can't assume that the network part of the device
knows when the USB part needs to be powered up. That's just plain wrong.

> offers a struct regulator.  But there is a quirk on Panda that means
> that is not workable.
>=20
> On Panda, they share one SoC gpio to reset both an external ULPI PHY
> chip and the smsc95xx that is downstream of it.

of course. the Network part is attached to one of the Hub ports, that's
why the hub exposes only two ports.

> After you power up the smsc95xx, you must reset it in order for
> correct operation.  This actually resets the ULPI PHY too.
>=20
> The ULPI PHY is permanently powered, only nRESET is provided to
> control it.
>=20
> For that reason, as an attribute of being on a Panda board, we need
> to do the (shared) reset meddling once at hsusb init, and that is why
> the patch is as it is.

yeah, yeah, but it's not correct to push all that code is the OMAP USB
Part when the hub driver is the only one who knows when the hub is going
to be reset and the like.

You're poking into a HUB, not into the EHCI controller.

--=20
balbi

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrhjYAAoJEIaOsuA1yqREsU0P/RBaf+6M3mi9/Dz6Q3qTF6A4
+lZBKP0XMZhzEYwsi4qYqIfxRL80/PxuEoWF7mn0iX9N5eiOKEl81lE/NObdrF17
EtbTIJj0Ln5taBuzNSUOiZGJEkumJS2QGMsVlnOvUuHPNyoNUQ+baU5YJx2YYBJN
9wBWF+PKHy0py1OvGe76LcBldV05Vg3Gkw+YZKXu+BlVZD1EYfgDIAoSZXgQBHSz
UkF1mzG886QE9ha2syHAO6TV4+gwgixrIQbxFAMrMjjUiMb+zHdWL/UjmDCofFsa
C4y2qJM+rvi6gm8SyAIiYafYbLM6a2Cusl8rUzYk5Lw/+Jai8svsRbgxc4PVjGIg
YccVAzcUz+LbDrcaFvB1a41lxVtP7Qab3LyYOFO4oTZYeVsBHgAf82+nROdyG1/6
dt/9LWkd2C5tT0HQ+O4U7Zo9j/Z0VeNoLQLpqeJPt65i9q5qLlyUhajcvBpm7kkx
Rx4shL+AOx3HfYWJd72v5t2NjFGKmKiMWPUx8crwMVdsV/1xjaZVORmbXgJ3UkdJ
4FivRhtpmIJuyq0cOH9vdDQ7O8ba0M68JiKzHCNPL8WafgpayY1hPBS1cQgXiLzF
mN/kZqBj34XHuzJICj8dovksRT0yJoNns85eFb9O4/9WJXAgq1osoemlQ8/u04yM
KsCT5U07F/czHaEvPDrJ
=f9JZ
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
