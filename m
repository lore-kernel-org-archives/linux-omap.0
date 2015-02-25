From: NeilBrown <neilb@suse.de>
Subject: Re: "advanced" LED controllers
Date: Thu, 26 Feb 2015 10:55:52 +1100
Message-ID: <20150226105552.367fc141@notabene.brown>
References: <20150219211424.GN13603@saruman.tx.rr.com>
	<20150223223457.GA4073@amd>
	<20150223225836.GB4355@saruman.tx.rr.com>
	<20150225214940.GA29527@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/zMyO/wKCo8cm5ZvSfL26Pv."; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225214940.GA29527@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@ti.com>, cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/zMyO/wKCo8cm5ZvSfL26Pv.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2015 22:49:41 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2015-02-23 16:58:36, Felipe Balbi wrote:
> > On Mon, Feb 23, 2015 at 11:34:57PM +0100, Pavel Machek wrote:
> > > On Thu 2015-02-19 15:14:24, Felipe Balbi wrote:
> > > > Hi,
> > > >=20
> > > > Do we have support for LED controllers which can handle patterns of
> > > > different kinds ? I mean, currently, if we have an LED controller s=
uch
> > > > as TPIC2810 [1] which can control 8 different leds and each LED
> > > > corresponds to one bit on register 0x44, we could control leds by j=
ust
> > > > "playing" a wave file on the controller and create easy patterns wi=
th
> > > > that.
>=20
> > > > [1] http://www.ti.com/product/tpic2810
> > > >=20
> > > > ps: tpic2810 is probably the simplest example, lp551, lp5523 and ot=
hers
> > > > have even more advanced pattern engines which can even handle RGB l=
eds.
> > >=20
> > > Well... some more advanced pattern engines can actually run code, up
> > > to and including prime number computation. So yes, this is complex,
> > > and how to handle it nicely is a question...
> > >=20
> > > I have "notcc" to compile for that.
> >=20
> > right, the point is that this is a solution which only works with lp5523
> > and IMO linux led subsystem should do a little more for such devices.
>=20
> Well, question is what we want. Possibilities I see:
>=20
> 1) We won't support all the features, just some common subset. Kernel
> will get commands for LED controller and translate them. Question is
> what reasonable subset is, then.
>=20
> I guess "delay", "set led brightness to X", "jump" would be minimal
> shared command set. lp5523 can do also "slowly increase/decrease
> brightness to X" (I believe we should support that one), arithmetics,
> conditional jumps, and communications between 3 threads.
>=20
> 2) We want to support all the features. I guess that would mean doing
> compilation in userspace, and having "compiler" for each led
> controller. Having common source code would still be nice.
>=20
> 									Pavel

All (most) current options for controlling LEDs are based on what a user
might want, rather than what the hardware can provide.

I think it would be good to keep that approach, but add more "interesting"
functions which each hardware can support in whichever way suits it best.

So "ramp_blink" which allow a ramp on/off time to be specified would be
useful.

"audio_meter" which allows a particular sound card (or output or something)
to be specified would also be useful.  You could also specify a what volume
the LED saturates.
Then if you set each led on a given controller to saturate at different lev=
el
and to use the same sound  source, then you could get the "graphic equalise=
r"
effect.

Maybe 'blinking' should have a 'synchronise' setting to that a bunch of LEDs
can be synchonised so you can create a "cylon eye" effect.

i.e. don't focus on the low-level 'what can we provide' but on the high lev=
el
"what might users want".

NeilBrown

--Sig_/zMyO/wKCo8cm5ZvSfL26Pv.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVO5hCDnsnt1WYoG5AQKShA/9GGRUQbZW9pY2v4LFeUVOLSmvKBxBR/9m
EqaJne7E7BDISVsHqHuy5H9CxqzW0irPh2sMFioL0gdMZFDdkLFV+hSr6CGqPXkA
bnGJGBaveiQKwp3VoEnY5UdyDRle4ly3rhFkGUX2ltlG1n0G217S1vpbSsLEj5fk
NkM1sXuC9NV0K9UTaSymoimfyXh/ai8L9qRxFulucuBaFhEn6jnWFPp2BHN/jTqV
4yrVNa9oMn10grFhzT41L3dYPNMgxg5XPqkjR9wdTtZQi+OO3CLUHyI+5mjwUOjn
dgAO6QxVrgA8yEuXD1wjB6X5E5MeUPiGKPgP00EYuJ18InQWOkD3UWe9kGh8jo3+
Ct40ioK68BZRhEeaxRP1z7FFxIYb/FGwSn3q1CLRIq7MLEdSHkl0A00OzLJ1TZnZ
l4yiuq/sHb+6CxbDQnyydUPRK5Dem4gGlMHG9EsAeqMOfCO6Z5DwrQMWWY+PqM2n
EOs70FXujCBo9RXayHLV4j2tdOaHRW/LCkiwM924h2S8FSQwL9EbPbffI0fEtiDd
yws0V9QfAytAaAPiisk8B8E9xbt0PTH1m1B0pDFUg4bi0+89wfU/L7rAYuJWpXWa
4KsKuvBJmYtP4zXCx7JDZYbFCUUv817ORJX8KJmpbYFNedH2Qb2pZd+Zq0am04jM
RQQgSHJ83MI=
=x2Oy
-----END PGP SIGNATURE-----

--Sig_/zMyO/wKCo8cm5ZvSfL26Pv.--
