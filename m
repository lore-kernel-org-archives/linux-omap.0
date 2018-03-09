From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec
	support
Date: Fri, 9 Mar 2018 17:48:35 +0100
Message-ID: <20180309164835.m442tmulhrknzqe3@earth.universe>
References: <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
 <20180308112528.GC6019@sirena.org.uk>
 <20180309083414.s57eq3kw325magwz@dell>
 <20180309124017.GB5252@sirena.org.uk>
 <20180309151153.GR5799@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4885533374270456646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180309151153.GR5799@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, kernel@collabora.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============4885533374270456646==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cab7dvhmsquaalf"
Content-Disposition: inline


--3cab7dvhmsquaalf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 09, 2018 at 07:11:53AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180309 12:41]:
> > On Fri, Mar 09, 2018 at 08:34:14AM +0000, Lee Jones wrote:
> > > On Thu, 08 Mar 2018, Mark Brown wrote:
> >=20
> > > > Linux.  Clocks are a big issue with audio stuff, right now sections=
 of
> > > > the clock tree get handled in the CODEC driver but we're going to w=
ant
> > > > to push them out to a clock driver so we're not reimplementing hand=
ling
> > > > for clocks.
> >=20
> > > How is the CODEC controlled?  Does it have its own registers?  I guess
> > > by "it's not a separate device or IP" you mean that it doesn't.  But
> > > that begs the question, how does this then device differ from all the
> > > other devices (adc, battery, charger, regulator, rtc, pwrbutton,
> > > usb-phy and led)?
> >=20
> > I'm not convinced that this is a particularly good idea for the other
> > functions but anyway...  the big thing here is that in these devices the
> > CODEC is generally not the level that the IP is created at, it's a
> > collection of interlinked IPs which usually includes not only audio
> > stuff but also some clocking stuff.  The repeatable blocks that could
> > get reused independently are generally a level down from the CODEC
> > level, for example if you look at something like wm8994 there's a couple
> > of identical FLL IPs which could make sense to enumerate individually in
> > the DT.  The top level generally doesn't get reused and is purely an
> > encoding of what Linux is currently doing.
>=20
> It seems that most of the components in the PMICs are just standard
> components packed into the PMIC with a control interface provided
> over I2C or SPI.
>=20
> So using compatible for things like ADC, RTC and so on makes sense
> if eventually figure out which ones are shared across various
> drivers.
>=20
> Sounds like audio is a bit more fuzzy like Mark describes above.
> And by not using a compatible for audio we can have things working
> while not establishing and ABI for something that might change
> in the future.

I would agree, if there was no ABI now, but we still have the
ABI. Instead of specifying the compatible property, we now need
to specify what the node name should look like (see my binding
update). That's just a different ABI.

-- Sebastian

--3cab7dvhmsquaalf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqiut4ACgkQ2O7X88g7
+ppWPw/+PciwoCoSEod5sIunUAX6qvRTE2Dn0D4xbh9/gLRXOxmNJPMabj7tXaZe
KFqEMkTCmqO42klBMcQijcBTc5AC3YzMcFLI61LjlQREXeKPchn3rJhIQTwQUqQJ
jXHj1Af6+pzaZohie9awDqTBdSPhnj6OGx/eG48MWPdE3oPtV4n7MWlCcj1j8e6y
gyEoQfr+St08vJHPVsIzIPmC+iBXSz2dvkTiwKDMtWghKfFxuN9oAdma/4+C+idl
UNzhdSgHeiTIfCBp8gHbJ9tYCSmxOUFfyTI8q2xeTs580b2B/a5kskqG9NfQ7ltc
Y1bFTDCWyOb6Gyh0d243ooEZYEvQRYHAjiwkrXQQCnyfwCCsBaE7NDH9/IhMOoZf
971xNwxlz4+cDXmuRFkj2hAjQPepeyYRWCm1r+HKYaeLvIIZcQITPMczI8Tw/OyI
wS7oReHF2g+H0CS8uJZKimS/kAB1vokUGm819TyfVZWY38VSu8dZ/1ZrQLf0/EUi
ZJT/UqCMQ7FndZkVIqHjnKI0dKnW963QD7FpAvESrcRjl2tSeyuV1EEjMlnl/ePP
R7zmp6jobKkh4JhJid6YEWzsohjh/y+ckHsKJaXhd94zwX7xNBO5OGyNDASRA/0r
chjiOreAH5kNagFDs1LTmz358VoPBW3wdj6ujtGJCxqBXIFAlrU=
=QYsg
-----END PGP SIGNATURE-----

--3cab7dvhmsquaalf--

--===============4885533374270456646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4885533374270456646==--
