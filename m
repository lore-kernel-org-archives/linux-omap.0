From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
Date: Wed, 3 Feb 2016 15:14:54 +0100
Message-ID: <20160203141454.GC9650@ulmo>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
 <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
 <20160201132228.2634b72e.drivshin.allworx@gmail.com>
 <20160201185952.GN19432@atomide.com>
 <20160202162330.GA4918@ulmo>
 <20160202184443.1e1b0bf5.drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202184443.1e1b0bf5.drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 06:44:43PM -0500, David Rivshin (Allworx) wrote:
> On Tue, 2 Feb 2016 17:23:30 +0100
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Mon, Feb 01, 2016 at 10:59:52AM -0800, Tony Lindgren wrote:
> > > Hi,
> > >=20
> > > * David Rivshin (Allworx) <drivshin.allworx@gmail.com> [160201
> > > 10:23]: =20
> > > > On Sat, 30 Jan 2016 15:51:06 +0100
> > > > Neil Armstrong <narmstrong@baylibre.com> wrote:
> > > >  =20
> > > > > 2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx)
> > > > > <drivshin.allworx@gmail.com>: =20
> > > > > > From: David Rivshin <drivshin@allworx.com>
> > > > > >
> > > > > > After going through the math and constraints checking to
> > > > > > compute load and match values, it is helpful to know what the
> > > > > > resultant period and duty cycle are.
> > > > > >
> > > > > > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > > > > > ---
> > > > > >
> > > > > > I found this helpful while testing the other changes, so I
> > > > > > included it in case it may be of use to someone in the
> > > > > > future. I would have no issues with dropping this if it's not
> > > > > > considered worthwhile.   =20
> > > > >=20
> > > > > It's useful, but converting it as a sysfs attribute would be
> > > > > great ! =20
> > > >=20
> > > > Hrm, yes that is an interesting thought. I imagine that many PWM=20
> > > > devices have similar constraints, so perhaps that would be best=20
> > > > handled generically in the pwm core? Maybe as new optional
> > > > get_*() ops, a modification to the config() op to add output
> > > > params, or just updating new fields in the struct pwm directly? =20
> > >=20
> > > Yeah for /sys entry it should be Linux generic. The other option
> > > is to use debugfs for driver specific things. =20
> >=20
> > Let's go with debugfs for this one. This is used for diagnostic
>=20
> I had looked at using the dbg_show() op to add some additional data.=20
> One thing that discouraged me from going down that path was that=20
> it replaced the call to pwm_dbg_show() for that chip. I wouldn't=20
> want to loose the existing output, as it is useful, but also didn't
> like the thought of duplicating the logic/formatting. I think some=20
> way to have both the standard output and add extra output somewhere
> (e.g. same line, line after each pwm_device, block after all=20
> pwm_devices on the chip) would make that path more attractive.
>=20
> Or were you thinking of a separate (per-chip) debugfs file for this=20
> type of information?=20

Yes, generally I'd prefer a separate, chip-specific debugfs file for
extra information. To be honest I'm not entirely sure of the usefulness
of the pwm_dbg_show() or letting drivers override it. But that's
slightly off-topic. However...

> > purposes and not typically needed when configuring a PWM. While other
> > drivers may compute similar hardware-specific values, there's nothing
> > generic to them. The period and duty cycle are the generic input
> > values and those are already exposed via sysfs.
>=20
> Just to clarify, what I was thinking of as generic was the concept
> that "period/duty I asked for" and "period/duty I got" may be
> different, sometimes to a substantial degree. I could imagine=20
> userspace wanting to know the latter, which is what I think Neil=20
> was suggesting.
>=20
> For the sake of an example, the input clock for a dmtimer is sometimes
> (often?) 32768Hz, which means that the real period and duty_cycle output
> are limited to being a multiple of ~61035.2ns (16384Hz). So an attempt=20
> to set a period of 100000ns (10KHz) would result in either 61035.2ns, or=
=20
> 122070.4ns (8192Hz), depending on the implementation of the driver (and=
=20
> patch 2 changes behavior from the former to the latter). You can also=20
> have cases where you desired a 33% duty cycle, but got a 25% duty cycle=
=20
> instead.
>=20
> In a quick look, I see substantially similar calculations (i.e.=20
> clk_rate*period_ns/10^9) in most of the other pwm drivers, which makes=20
> sense for any that are programmed in terms of some input clock. This=20
> type of calculation almost guarantees that requested and actual period/
> duty_cycle are going to be different to some degree. Some drivers look=20
> like they have even more complicated behavior, apparently due to other=20
> hardware constraints. For instance, fsl-ftm (among others) looks to be=20
> using a power-of-2 prescaler to fit the period_cycles into a 16bit field.
>=20
> Of course if the input clock rate for these types of devices is=20
> sufficiently high (enough that the desired period is many input clock=20
> cycles), then the difference between "desired" and "actual" is probably=
=20
> small enough that noone cares. I'm not sure how common it is that
>   a) there is a substantial difference, and
>   b) userspace cares about it, and
>   c) userspace didn't carefully select an achievable value already
> If noone has brought it up before, then I'd guess the answer is "not very=
".

=2E.. I think perhaps a better way yet would be to have drivers update the
period and duty cycle to the actual values. That way there won't be a
delta between what's really being programmed to hardware and what shows
up in sysfs. It would also give users a chance to check if what's been
programmed is within an acceptable range or not.

Thierry

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWsgtbAAoJEN0jrNd/PrOh/JYQAJ5taUj7uLxbmKxkhZFFJTEZ
rNg0Ez0yJb/gcQrjsHy5Z2I/LgrCbeyG5i+vDOqfol8LFy/PCRA9826TEc3b3Y9m
dlhAg7ZWOywYwkXxn4T67Ylt2tIMdBUQ4OxDDUW93gMSG5KaXxDGXnsouhd9p5NX
A8tr8/eF3rgqRW7XROiW4EAWTX33QQjgzTrDVxL4z94djB0X6doDC/cq8tGlnRl6
pjpKTEePisNeg1dDQ6DaMxDFQ8jGAQiQdnElCPFny+Uw0WRRxWAIvr071VVfvXNp
mQ5YxrXJ8VLfYbpDM0eJjV06Bme9wZwhFdbsQQbPze3vzahBP4zlPdEV5ow8PwKZ
C+EsA2be+dIkkHa2oGMkaOfjVvObyU6UvA3swB5+Ma7Sdow5+GQ2YkwVXqd3Ph9C
eDTKleYyp8qZCaRnN5vGGgBUtCHtxnjWf7TA1iD8H90IcC/cdcb917ZdL+FqgfA1
GXdggVinxtzIlhXxMmm7dpIB+a1nSMAZL20BOEaxMuHX2Ux3+8A2Myjfsh85DcXF
f+9MtkLxZ1V3EjvBW1D9jOFFiLLEoYfJBaqteSEwMdDeeP66aCEZt3AM/ZRQsz44
74Du6O0AgbPek/1O0/yBwdk5URaOzOiLAryj3COGABfoPvA1sWPiku9f4WlQOidn
PEHvNKOMwvXcnyHoLSNg
=+u8O
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
