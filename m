From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Date: Wed, 6 Feb 2019 07:37:32 +0100
Message-ID: <20190206073732.35ad315f@kemnade.info>
References: <20190202055827.12956-1-andreas@kemnade.info>
        <20190204155604.GH5720@atomide.com>
        <20190204193311.102a60e6@kemnade.info>
        <20190204184317.GO5720@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QwS4Tx=f55MQhMz8gZGszh/"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204184317.GO5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/QwS4Tx=f55MQhMz8gZGszh/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Feb 2019 10:43:17 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190204 18:33]:
> > On Mon, 4 Feb 2019 07:56:04 -0800
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]: =20
> > > > Enabling off mode was only reachable deeply hidden
> > > > in the debugfs. As powersaving is an important feature,
> > > > move the option out of its shady place.   =20
> > >=20
> > > How about let's enable always if we have the twl4030
> > > configured to allow it? You can just check if the dts has
> > > "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> > > properties set.
> > >=20
> > > In order to enable deeper idle states, the user space still
> > > needs to idle the UARTs and possibly other hardware blocking
> > > idle. So we should be safe there.
> > >  =20
> > Let us not mix up runtime pm and system pm. The uarts need
> > to be idled for runtime suspend, but they are off/ret for
> > system suspend without userspace intervention, so allowing off mode
> > will have an influence even without uart runtime suspend,
> > and also probably for other powerdomains (non-core/per).
> > So we still need to be sure to handle at least some erratas and
> > context save/restore correctly. =20
>=20
> True that's a good point.
>=20
> > Your Idea seems to be in pseudocode
> > if (powersaving_wanted)
> > 	enable_off_mode()
> >=20
> > I had something in mind like
> > if (system_is_trusted_to_handle_offmode()
> > 	enable_off_mode() =20
>=20
> For omap3, the properties for "ti,twl4030-power-idle" or
> "ti,twl4030-power-idle-osc-off" mean just that.
>=20
Hmm, system =3D software + hardware. At least that I had in mind
when writing this text.
So for the software part: I guess off mode is on our all test
schedule, so it should be reliable.
dt describes the hardware, so there should be any MODE7 quirks
defined if they are required and the proper pmic setting.

But wait... twl4030-power.c is to a big part about switching regulators
on and off. But how does that connect to hwmods going to ret or off
mode? That is imho slightly another topic.
Ok, looking a bit closer, there is the sys_off_mode line
which needs to be used.
So we have to derive that from the devicetree.

> The PMIC is wired and configured for off mode, and those
> properties should not be set unless the system is truly capable
> of entering off mode. If not set, we should not enable off
> idle by default.
>=20
> Otherwise the boards should be already using just
> "ti,twl4030-power" or "ti,twl4030-power-reset".
>=20
We have also
ti,twl4030-power-omap3-sdp,
ti,twl4030-power-omap3-ldp,
ti,twl4030-power-omap3-evm

so we have to maintain a list, especially if we want to allow another
pmic.

But since it is about connecting the soc to the pmic, we could also add a
flag in the dtb on the soc side, so we are prepared if someone uses another
pmic. It feels a bit strange to query something from devicetree for another
device.

Regards,
Andreas
PS: I hope my omap-gta04.dtsi-related patches have made their way into
your review queue and are not starving in a generic lkml fallback folder

--Sig_/QwS4Tx=f55MQhMz8gZGszh/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxagKwACgkQl4jFM1s/
ye8JpA//Vy8EZmxtbWYxWOLs6fx2ndOI9EJF+SaPmSputIA/qyvt0Y49LTQi1shg
XmlBJd8EjYlpw5/JhnZr14U0KjDOd3YjRE1xgAmI/yCfBLiBl7DsabpzMJ2r+F4y
TLncKjw6fqKWUeca06JM94maMkTx8jRmoeRAWfa0Nc3vzTprC5ZZ4ydKaMDY5Wfb
DYVTcr1oaRpiFtG9tARgXPl5bbvs8iDxAIMLUy9m+fbfTPcF9POOdDRzPLL1bBdD
J3g6jW80nDfJABGAhl/25JsvqmrKNA96i6C0mdpF04XauHCMW6+e5V1j/bD06zXX
Q5WvpsK8SRht1kKga8KrZHj3Y4MNsz8nhbG5v9wxmBNH+yd74Of28pIGUQ6hXEz2
TpappPFApC279urffdpJR2A8etxF8RxSWyHOYmt68wiCpuPmEqaSKCoyjnrgyKpu
0FP1kJovxgil3tZuVpaCroSr5GGuvzVVzc9snKdE2igAriYknbwQtYF3GHYpXnPi
ZX+ptcGC4OCAxgpcy02uvYMJKt9ys2YLS7KctmNhBizvN2GF4lmkTlVBBc1PCIlK
7CEMpL+GyEiOSuPBBawpQA4jkRZep+HYnNEOf5vbVWHnfNfC9DDYJX4A1d5k7feJ
PCXS5gKmX1q9k8h580rPLrr0WAnu9oALixQ1z/seiFVXrtUPeq0=
=UHHl
-----END PGP SIGNATURE-----

--Sig_/QwS4Tx=f55MQhMz8gZGszh/--
