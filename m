From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 00:44:22 +0100
Message-ID: <20170218234422.vza3toc3bphixsdn@earth>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <20170218032233.3qh5xdjbx5kkq5hm@earth>
 <95E59EB0-6F96-40BB-B74C-9CD56DDD7783@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wo7bf5vztuwop3mq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <95E59EB0-6F96-40BB-B74C-9CD56DDD7783-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr
List-Id: linux-omap@vger.kernel.org


--wo7bf5vztuwop3mq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 18, 2017 at 12:33:34PM +0100, H. Nikolaus Schaller wrote:
> Hi Sebastian,
>=20
> > Am 18.02.2017 um 04:22 schrieb Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> >=20
> > Hi,
> >=20
> > On Fri, Feb 17, 2017 at 12:40:41PM -0800, Dmitry Torokhov wrote:
> >>> AFAIK there is no mainline board using the DT except ours (and the up=
coming
> >>> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can re=
move this
> >>> compatibility property. We don't need it for our devices.
> >=20
> > $ cd linux.git/arch
> > $ git grep -l tsc2004
> > arm/boot/dts/imx6qdl-nit6xlite.dtsi
> > arm/boot/dts/imx7d-nitrogen7.dts
> > arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
> > arm/boot/dts/omap4-var-som-om44.dtsi
> > $ git grep -l tsc2005
> > arm/boot/dts/omap3-n900.dts
>=20
> Those are not relevant since tsc2004/5 and tsc2007 are independent driver=
s and don't
> share code.

Yes, I'm aware.

> Hence the N900 is not influenced by this patch series.
> If it has a similar issue, it should be fixed of course.

Right. I added them to see every board affect by the patch suggested
by me in my last paragraph.

> > $ git grep -l tsc2007
> > arm/boot/dts/imx28-tx28.dts
> > arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> > arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
> > arm/boot/dts/imx53-tx53-x03x.dts
> > arm/boot/dts/imx6qdl-tx6.dtsi
> > arm/boot/dts/imx6ul-tx6ul.dtsi
> > arm/boot/dts/omap3-gta04.dtsi
> > sh/boards/mach-ecovec24/setup.c
>=20
> Sorry, I was a little imprecise here, because I looked for the min/max pr=
operties.
> Of course, the imx devices use the tsc2007 as well.
>
> Maybe we should edit all these DTS and set the "ti,report-resistance" pro=
perty
> by default. Then, no user should notice a difference.

I suggest to create a patch without the report-reistance stuff and
add it early after the merge window and see what happens. If no
users notices anything the change is not an ABI break from kernel's
PoV.

> Is any user/maintainer of these devices following this discussion and can=
 comment?
>
> >=20
> >> You seem to be treating DT data as something very fluid, which is wron=
g.
> >> You need to treat it as a firmware, unlikely to change once device is
> >> shipped. Unlike legacy platform data, the fact that DTS files are not
> >> present in mainline does not mean that we can ignore such users and
> >> change behavior at will.
> >>=20
> >> That said, if driver behavior is out of line from the subsystem
> >> expectations, we need to fix it.
> >>=20
> >>=20
> >>> That the function name is wrong is a second issue and this double neg=
ation might
> >>> confuse a litte.
> >>>=20
> >>> Please test on a real device if the patched driver reports pressure n=
ow (unless
> >>> ti,report-resistance is specified).
> >>=20
> >> I unfortunately can not test this driver as I do not have the hardware.
> >> So all my observations are from code and data sheets.
> >>=20
> >> That said, what is the values emitted as ABS_PRESSURE when finger is n=
ot
> >> touching the device, barely touching the device, or pressing firmly?
> >> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
> >> confusion as to what is being reported.
> >=20
> > As far as I can see all calculate Rtouch and ADS7846 reports
> > (Rmax - Rtouch), which looks sensible.
>=20
> I don't see where this subtraction from Rmax takes place for the tsc2007:
>=20
> http://lxr.free-electrons.com/source/drivers/input/touchscreen/tsc2007.c#=
L131

sorry if I wrote this ambiguous, let me split my sentence

1. tsc200x & ads7846 calculate Rtouch
2. ads7846 reports Rmax - Rtouch
(3. tsc200x does not, it reports Rtouch instead)
4. ads7846 behaviour looks sensible to me

> >> I am adding a few more folks to the CC so we can try and soft this out.
> >> Sebastian, Pali, Pavel, any input here?
> >=20
> > I think tsc200x works, since usually userspace is Xorg and I think
> > it only cares for x/y coordinates + boolean pressure. Since
> > no-pressure is correctly reported as 0, everything works as
> > expected.
>=20
> No pressure is usually treated as a special case in these drivers,
> so reduction to "boolean" in user-space works well by accident and
> might still hide a bug.

That's what I assumed.

Btw. how did you notice that tsc2007 sends "inverted" pressure values?
Just in evtest or in some non-development application? (Just asking because
the behavour obviously changes at least for that usecase)

> > I currently don't have X running on my N900 due some
> > omapdrm bug, so I can't test this, sorry.
>=20
> I usually look with evtest if ABS_PRESSURE is monotonic.

That would not have helped to check if X handles the touchscreen in
a boolean way. I can provide some N900 evtest data, though (tomorrow,
I don't have my dev N900 with me at the moment).

> > I suggest to put the resistance vs pressure thing in its own patch,
> > that also fixes tsc200x-core and merge it to linux-next after the
> > merge window.

-- Sebastian

--wo7bf5vztuwop3mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlio3EQACgkQ2O7X88g7
+pqHlxAAl/kIQI2eouKGk8du0Q6+26i2tSor7Hk+GZe1/cFNzfk/C8NFi5mUvXRg
dsWFgebfOOpU7OVRwpLssE6O9u/LaCCnXYfh2yVWsfrvqAaGhRkvRo2X9GDa3kMk
66SfFdNptI2qpZZhM5n9HMohNv51cGKrCNC+RUX3lZLENYDrdBS1F2cy4BNLmvET
E8O//6/0jvDRK1hXsbvUsW/pNI4XZrOWTsId88RgUD7hrUvAotjkIkGesVbNyeCO
VgcADhNUjLeyG2f+9tvgoU8X6gZngSelOzP9oNPp9hmLQ3Rh7YWgI34vqFoSQ/Oe
3WHLTGYC0J2Kj8pbpRVmbXv4F75B9pJ3BG9Tub9ZEMtiDvUcq7pgRNeiRoSg0HQ8
J00PY7MZr3O09WLaP+RcRBOxmGWOTeM93rOmoaCSXWbp0Z+2iD3iR3BezbVvF7E6
9/bQZkKhbaNgq7r482GAIpkeDe+nukraNG1aVvYR8aJ3jo3+dwpSos+qNkvIn0tM
HELnKlBDWTvfELouMq8WgqPyYRqHaDCKkAsbguxvosxM5dE9SI2HxACd3H59G9D2
8ko9t58cVBsw+uKPogv/nOn7rv5+Omu4+O5KDvlGAtJsLNfPlGuq4mWKEzAFNMBS
GW6S4eOQJnTylRJg6vVzMv0HY2oZpMfpgT4Sdb+1mcBWhdgeVTk=
=duEK
-----END PGP SIGNATURE-----

--wo7bf5vztuwop3mq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
