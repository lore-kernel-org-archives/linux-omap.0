From: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Subject: Re: Re: [RFCv4 06/11] misc: Introduce Nokia CMT driver
Date: Wed, 18 Dec 2013 00:25:27 +0100
Message-ID: <20131217232525.GA12152@earth.universe>
References: <1387150085-23173-1-git-send-email-sre@debian.org>
 <1387150085-23173-7-git-send-email-sre@debian.org>
 <CACRpkdYjjXgE_W8gq1e6z=nGMF=r-m+o2kkvrBFrEMm3o0=RwQ@mail.gmail.com>
 <20131216121524.GA6177@earth.universe>
 <CACRpkdbx=Ye8xo4wMkyntME45xv15DeyqV32aeCAcSaa+vDpfA@mail.gmail.com>
 <20131216183448.GA10614@earth.universe>
 <52B090E0.5040006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52B090E0.5040006-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivajlo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, pavel@ucw.c
List-Id: linux-omap@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 07:58:56PM +0200, Ivajlo Dimitrov wrote:
> >On Mon, Dec 16, 2013 at 02:31:53PM +0100, Linus Walleij wrote:
> >>I am very reluctant in letting device trees specify exports of GPIOs
> >>to userspace, not so much because it's Linux-specific but for
> >>the fact that people are doing things in userspace that should not
> >>be done in userspace.
> >>
> >>Last time it was proposed I asked to the specific usecase,
> >>exactly why userspace needed this handle on a physical
> >>GPIO line, and why it can't use another userspace interface
> >>(example: leds, keys etc.)
> >There are a couple of lines ("cmt_apeslpx", "cmt_rst_rq", "cmt_en",
> >"cmt_rst", "cmt_bsi"), which are handled by ofono to do the correct
> >power sequence for the modem. The relevant ofono code is here:
> >
> >https://git.kernel.org/cgit/network/ofono/ofono.git/tree/plugins/nokia-g=
pio.c
> >
> >In MeeGo etc. they have a little board specific init script, which
> >exports the gpio lines and setups some symlinks. IMHO at least the
> >board specific stuff should be handled by the kernel, thus I added
> >this code to the driver. I guess you prefer to move the power
> >sequencing completly to the kernel?
>=20
> Don't forget there is not only ofono, but rtcom-call-ui and all the
> telephony stack in Maemo 5 :). However, power sequencing and control
> is specific not only to the modem model, but to the firmware version
> the modem is running as well (afaik). IMO you can't simply move the
> modem power/reset/sleep control to the kernel and hope for the best,
> I am not sure there is enough documentation (if any) for this to be
> done reliably, esp on n900 with its BB5 modem. The point is that
> those gpios are used not only for the initial power-up, but for
> control of the modem state and reset (if needed) during normal
> usage. The APE reset line is an example of stuff that can't be moved
> to the kernel without providing some interface/feedback to/from the
> userspace IMO - what if she is dialing 112 at the moment the modem
> decides it is too hot and wants a device reset (or whatever reason
> there could be for a modem to request a device reset)? The same goes
> for the APE sleep request line (cmt_apeslpx) - based on what should
> the kernel decide whether to put the modem in sleep?
>=20
> Sure, exporting gpios to userspace might not be the best way to
> achieve the required functionality, but every way could be argued if
> it is the best. And for sure labeling a modem "LED" won't make it
> such.

Yes, but as far as I know the kernel design rules are not bended for
nonfree userspace components. Using the nonfree Maemo stuff should
be supported by disabling the CMT driver and exporting the pins from
userspace using some board specific init script (=3D> this is how its
done until now).

I had a look at both ofono's and freesmartphone.org's implementation
for the GPIO handling and both implementations are very similar. I
think it should be possible to move the state machine described in
[0] into the kernel and provide a simple sysfs/uevent interface.

I was thinking of something like /sys/devices/platform/nokia-cmt/state,
which accepts "enable", "disable" and "reset" as input and outputs the
current state.

[0] https://git.kernel.org/cgit/network/ofono/ofono.git/tree/plugins/nokia-=
gpio.c

-- Sebastian

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSsN1lAAoJENju1/PIO/qaZ3QP/0z/Bio3vzPk2PMFF6Bedo21
t8CZM9lZvlVDKRoNy/54cN8wtImBYpT0n3x3888Ph8//ITjq9U7RywIbtLsY2gnq
jeVoGpXpoFel+dsHRL9MULww+K1lxZ7O4mHZ4Rxd4Kzmm4bptTmmPtTliIy9RnVF
NcZizYKJgasMAiIlOMXJgVbJA/9iGWAiOXyW5j4g0sXpJXURznRNtuZ3A+Z+hdMW
qKYDhL9hFSiDr40BXiVoBc/NH2fhNCqoxJAwxDVBDNbL+IR1Y3XO+vUfJdjx6PF/
A/68ryI5d85S1FJnPmE7wCW8ii78nu8pgS2aqz6MonJkci2cu/PDRtqyAg/ZbM/U
XTt0gDZ5DkhhxH+dnvBgLI995JialKx3uzK5SR9cRKXRqiNXs0veBHI9Gq80suTg
WkvvTbTmAxRV2SN914vHbjy1IJAo3ZrwkpgJmUQk+AA9QPYSJkAjVUWd0sFRsS5U
P86sxG3y4Qib8Vo029u1enAP9hIOgOGJYal8LTQDj7GqrSo3LeX3Dd658VrGtI8F
rBhrmfleQisZ/VanWZiSg4ajxV+rLwllxLGAL9U/ccJOOkuLyzRrTsv+FEV3Qz06
BnLF1T8N6WMgCdfz4v1UwKguIhzBv8J9iAaFuVL2+rNVCKgPBfCfyUMMSD+gTnEv
aVgnqXZ+A8DAGtvKQQ+i
=X1qW
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
