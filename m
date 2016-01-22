From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Fri, 22 Jan 2016 06:41:45 +0100
Message-ID: <20160122064145.36b7f2b4@ipc1.ka-ro>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
	<1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
	<20160120164258.GF6588@sirena.org.uk>
	<20160121080524.27af489f@ipc1.ka-ro>
	<20160121102015.GI6588@sirena.org.uk>
	<20160121112611.34e17cb2@ipc1.ka-ro>
	<20160121111115.GJ6588@sirena.org.uk>
	<20160121123311.5346e40d@ipc1.ka-ro>
	<20160121162646.GK6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121162646.GK6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

> On Thu, Jan 21, 2016 at 12:33:11PM +0100, Lothar Wa=C3=9Fmann wrote:
> > > On Thu, Jan 21, 2016 at 11:26:11AM +0100, Lothar Wa=C3=9Fmann wro=
te:
> > > > > On Thu, Jan 21, 2016 at 08:05:24AM +0100, Lothar Wa=C3=9Fmann=
 wrote:
> > > > > > > On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa=C3=9F=
mann wrote:
>=20
> > > > > > > > This pin is used as IRQ pin for the LTC3589 PMIC on the=
 Ka-Ro
> > > > > > > > electronics TX48 module. Make the IRQ optional in the d=
river and use a
> > > > > > > > polling routine instead if no IRQ is specified in DT.
> > > > > > > > Otherwise the driver will continuously generate interru=
pts and make
> > > > > > > > the system unusable.
>=20
> > It won't. That's the whole purpose of this patch.
> > I'm afraid, I don't quite understand what you want to say...
>=20
> Your commit message (quoted above) claims that without this patch if =
no
> interrupt is supplied then the unsupplied interrupt will somehow be l=
eft
> screaming and make the system unusable.  This doesn't make sense, if
> there is no interrupt there is nothing to scream.
>=20
"Otherwise" meant the case where the IRQ is specified in DT as is
currently required to get the driver loaded at all.

> > Without this patch there will be a constantly active interrupt, whi=
ch
> > will stall the system because the nNMI interrupt (on the EXTINTn pi=
n) is
> > level triggered.
> > Since the polarity of the interrupt input is fixed, there is no way=
 to
> > use it in our HW.
>=20
> So, contrary to what you've been saying, the interrupt is actually
> connected (and worse, connected to a NMI) but apparently not describe=
d
> in DT.  Why is it sensible to make the driver poll (which will affect
> all systems using this device, even those that don't care) and not ju=
st
> describe the interrupt in DT so it can be handled promptly in the nor=
mal
> fashion?  Presumably this will run into serious problems if the
> interrupt actually fires at runtime since the NMI will scream, it's n=
ot
> clear to me how the poll will manage to run successfully in that case=
=2E
>=20
Currently the driver won't even load without an IRQ specified in DT.
My patch makes it possible to use the driver without requiring an IRQ!


Lothar Wa=C3=9Fmann
