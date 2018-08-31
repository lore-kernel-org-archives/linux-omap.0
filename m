From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfc] leds: add TI LMU backlight driver
Date: Fri, 31 Aug 2018 23:30:31 +0200
Message-ID: <20180831213030.GA23447@amd>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
 <20180830201825.GA1936@amd>
 <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Aha. I did not realize that was for same hardware... I should have
> > cc-ed you, I guess.
>=20
> No worries Jacek cc'd me.

Good.

> >> I do not like this driver.
> >> I don't like that it smashes numerous devices into some structure with=
 varying register maps.
> >>
> >=20
> > Can you elaborate? The chips are similar enough that single driver
> > makes sense, and we certainly want to maintain one driver, not 6
> > drivers differing only in .. what exactly?
>=20
> Well I think it is justified to have independent drivers as each device h=
as different features from
> this basic LED driver.  If we are just looking for basic support then yes=
 this driver is fine.

> But here is where a single driver will start getting messy and support di=
fficult
>=20
> LM3533 has ALS and an ADC for an ALS analog sensor
> LM3631 has no ALS functionality
> LM3632 has strobe functionality and no ramp support
> LM3633 has indicator support coupled with the hvled support
> LM3695 does not even appear to be available publicly
> LM3697 is the only device that that this driver could be used for as is.

Ok, so ... yes, I'm really interested in basic support. But drivers
seem to have a lot in common, voltage limits, for example.=20

> In addition if I wanted to only support a single device I have to pull in=
 the full data
> file that defines all the other devices.  That is pretty bad to increase =
the size of the kernel
> image to have support for devices that are not even on the target product=
=2E  The ti-lmu data file
> alone is ~15k, the ti-lmu code does not even build with this patch (So th=
is is a nack on the patch as it is.)
> but commenting out the offending code gives me at least ~23k more data on=
 top
> of the ti-lmu MFD framework which is ~33k.  That is ~71k of code just to =
support 1 LED device
> that is 3x what we have now.  That is not good for IoT devices.

> The LM3697 is 22k without ramp support.

Well, I don't think object file size is huge problem. First,
"distribution" kernel with support for 6 different chips will be ~71k,
while your proposal will result in ~136k. Second, yes, we could put
ifdefs into ti-lmu data file to make it smaller.

Anyway, clean source code and easy maintainance is more important.

>=20
> And I will continue. TI LMU really means nothing unless you know what LMU=
 stands for.  But this
> also now implies support for all of TI's lighting products which will con=
fuse the heck out of
> customers and TI support staff.  We have a similar issue in our SoC sound=
 CODECs code that we are
> attempting to clean up.  We have a generic driver that is supposed to sup=
port a common set of features
> but when extending support for other features the code gets very complica=
ted and it is almost more
> beneficial to re-write and create a new driver.
>=20
> I would be OK with creating a ti-lmu framework that commonizes the functi=
onality and create children that
> register to that framework but even that is over kill.
>

I believe there's quite a lot of code that could be shared.=20

> >> Not only that but it appears that you just pulled this driver from a r=
epo and posted it without clean up.
> >>
> >=20
> > a) No I did not, feel free to generate a diff.
> >=20
>=20
> No I looked at this driver before and determined a re-write was a waste o=
f time.
> If you look that the LM3697 driver I submitted it configures the banks vi=
a the config file.
>=20
> Only the ramp code is missing and the code is much simpler in nature.  We=
 could adopt that
> code to extend out to the other devices as well and base the register map=
 deltas on the=20
> device configuration file.  I am already using the fwnode calls and setti=
ng up the banks.

Well, you may know that hardware better than I do. But if you generate
a diff...

> > b) Even if I did, why would that be a problem?
>=20
> So what you are saying is all I have to do is look for other peoples work=
 pull it in to a branch
> slap a new copyright on it, push to a list and claim support?

=2E..you'll see I did quite some changes.

> I don't think you checked with the original author on pushing it upstream=
=2E  Milo has not updated
> his email with a public one unless you sent him a private email and recei=
ved and ack on pushing
>

Tony Lindgren asked me to get support merged, and that's what I'm
trying to do. I have Milo's sign off, that means he is/was ok with
upstreaming that code; no, I did not have reason to contact him.

> > Well all 6 chips this driver supports seem to be similar enough, so
> > that single driver makes sense.
>=20
> See above on device differentiation. So in my opinion a single driver tha=
t supports
> basic functionality is good but when adding additional support this drive=
r will get very
> complicated as to only allow different features for different devices.

Well, the devices seem to have quite a lot in common. Yes, single
driver for all of them will be somehow complex; but I believe that's
still better than copy&pasting code.

Anyway, I showed my proposal. I need support for ti,lm3532, but I can
get basic support for many other chips with very little code.

Do you plan basic support for support other chips in near future? Is
TI willing to maintain the LED drivers?

What is your proposal for lm3532 support? Should I just cp lm3697
lm3532, then adjust register map? (Will not that cause rather ugly
code duplication?)

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluJs3YACgkQMOfwapXb+vK0QgCgrQkZ5TzvGqSlHPd2YifIfe4p
CDoAniNnC95TNnqKjwmoHIBEq4jlP6wm
=uVnF
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
