From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Mon, 9 Jan 2017 21:32:51 +0100
Message-ID: <201701092132.51414@pali>
References: <201701070007.49137@pali> <201701092029.53939@pali> <20170109193828.rzpyzzl6g3v2nylk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2181871.YleHOu7iZA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109193828.rzpyzzl6g3v2nylk@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart2181871.YleHOu7iZA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2017 20:38:28 Mark Brown wrote:
> On Mon, Jan 09, 2017 at 08:29:53PM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 09 January 2017 20:22:01 Mark Brown wrote:
> > > point where you need an actual change.  Note that if something
> > > holds the microphone bias on (like something using the
> > > microphone) separately then that'll take effect so if you really
> > > need things to get turned off then that won't work but you
> > > probably have trouble anyway in that situation.
> >=20
> > This is needed for cable/jack detection at time when jack is
> > inserted. So before it there cannot be any user of (disconnected)
> > microphone.
>=20
> That's not going to stop userspace, consider what happens if the
> headset gets removed and userspace is slow to stop a recording for
> example.

Ok. But in this case changing mic bias does not introduce any problems
as userspace already trying to record from disconnected microphone.

> > What I need is to enable mic bias, measure ADC of some time period,
> > check status of some GPIOs. Then disable mic bias, measure ADC
> > again and check GPIOs. I in this detection procedure I need to
> > ensure that nobody changes mic bias. So I though that locking the
> > whole procedure could ensure that.
>=20
> That sounds racy and a bit unusual - what's the actual procedure
> here?

The whole old code for production Nokia N900 devices is there:
https://github.com/pali/linux-n900/blob/v2.6.28-nokia/drivers/misc/nokia-av=
=2Ec

If it is usual/unusual/crazy/wtf/:-) I can just tell: it is working fine
with that Maemo 2.6.28 production kernel. And there is no documentation
for it, just code. So the best what we can do is reimplement that driver
for mainline kernel and check if it is working. (Then we can maybe start
changing logic if something make sense...).

It is more complicated, but basic idea seems to be:

Use interrupt handler when jack_detection_gpio changes. When 1 --> jack
unplugged (no detection is needed), otherwise plugged and start
detection.

Start: set eci_sw_gpio to 1, enable mic bias, wait 20msec

Detection point 1: if eci0_gpio is 1 then goto Detection point 3

Detection point 2: measure ECI_ADC (thresholds define type) and goto Stop

Detection point 3: set eci_sw_gpio to 0, wait 20msec, if eci1_gpio is 1 the=
n goto Stop (open cable=20
was inserted)

Detection point 4: set eci_sw_gpio to 1, disable mic bias, measure ECI_ADC =
until it stabilize=20
(thresholds define type)

Stop: set eci_sw_gpio to 1, revert mic bias

Thresholds for Detection point 2 are defined as:
#define THRESHOLD_GROUNDED	40		// HEADPHONES or line input cable or externa=
l mic
#define THRESHOLD_VIDEO_HI	150		// VIDEO_CABLE

Thresholds for Detection point 4 are defined as:
#define THRESHOLD_HEADSET_HI	1000	// BASIC_HEADSET

(probably threshold for basic headset is not correct)

The whole procedure is repeated 5-10 times. If open cable is detected
then eci_sw_gpio is set to 0 and procedure is periodically repeated
after some interval (looking at the code I think that interrupt for
eci1_gpio could be used instead of busy waiting). Optionally if nothing
(=3D unknown) after 5-10 times is detected then another procedure for ECI
headsets could be used. As Joerg pointed that nokia-av.c code has
incorrect detection for ECI it first needs to be investigated. But it
will need to disable TVOUT (OMAP3430 TV_OUT1 and TV_VFB1 pins).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2181871.YleHOu7iZA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhz83MACgkQi/DJPQPkQ1KktQCgh1r6gMLNptLRNM7/CUjB5HQe
YdoAn2qSpMfFKyoLzFQtj4Mo+HVBcGSv
=28+U
-----END PGP SIGNATURE-----

--nextPart2181871.YleHOu7iZA--
