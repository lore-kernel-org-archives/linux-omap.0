From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Tue, 8 Jan 2013 10:48:32 +0000
Message-ID: <20130108104832.GE21994@gmail.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <93BF5C62-ADE8-4EFC-9175-C2D7E43300E3@antoniou-consulting.com>
 <20130107210551.GL14149@atomide.com>
 <201301072135.05166.arnd@arndb.de>
 <89A7A8FD-935E-4225-8C7B-EA1DBA0C2780@antoniou-consulting.com>
 <20130108100042.GD21994@gmail.com>
 <21E7B891-269B-422D-9038-381FAA15B59B@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21E7B891-269B-422D-9038-381FAA15B59B@antoniou-consulting.com>
Sender: linux-doc-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus.wall>
List-Id: linux-omap@vger.kernel.org

On Tue, 08 Jan 2013, Pantelis Antoniou wrote:

> Hi Lee,
>=20
> On Jan 8, 2013, at 12:00 PM, Lee Jones wrote:
>=20
> >>>>> At the end of the line, some kind of hardware glue is going to =
be needed.
> >>>>>=20
> >>>>> I just feel that drawing from a sample size of 1 (maybe 2 if I =
get to throw
> >>>>> in the beagleboard), it is a bit premature to think about makin=
g it overly
> >>>>> general, besides the part that are obviously part of the infras=
tructure=20
> >>>>> (like the DT overlay stuff).
> >>>>>=20
> >>>>> What I'm getting at, is that we need some user experience about=
 this, before
> >>>>> going away and creating structure out of possible misconception=
 about the uses.=20
> >>>>=20
> >>>> IMHO stuff like this will be needed by many SoCs. Some examples =
of similar
> >>>> things for omaps that have eventually become generic frameworks =
have been
> >>>> the clock framework, USB OTG support, runtime PM, pinmux framewo=
rk and
> >>>> so on.
> >>>>=20
> >>>> So I suggest a minimal generic API from the start as that will m=
ake things
> >>>> a lot easier in the long run.
> >>>=20
> >>> I agree. The ux500 platform already has the concept of "user inte=
rface boards",
> >>> which currently is not well integrated into devicetree. I believe=
 Sascha
> >>> mentioned that Pengutronix had been shipping some other systems w=
ith add-on
> >>> boards and generating device tree binaries from source for each c=
ombination.
> >>>=20
> >>> Ideally, both of the above should be able to use the same DT over=
lay logic
> >>> as BeagleBone, and I'm sure there are more of those.
> >>=20
> >> Hmm, I see.=20
> >>=20
> >> I will need some more information about the interface of the 'user=
 interface boards'.
> >> I.e. how is the board identified, what is typically present on tho=
se boards, etc.
> >=20
> > User Interface Boards are mearly removable PCBs which are interchan=
geable
> > amongst various hardware platforms. They are connected via numerous
> > connectors which carry all sorts of different data links; i2c, spi,=
 rs232,
> > etc. The UIB I'm looking at right now has a touchscreen, speakers, =
a key
> > pad, leds, jumpers, switches and a bunch of sensors.
> >=20
> > You can find a small example of how we interface to these by viewin=
g
> > 'arch/arm/boot/dts/stuib.dtsi'. To add a UIB to a particular build,=
 we
> > currently include it as a *.dtsi from a platform's dts file.
>=20
> I see. What I'm asking about is whether there's a method where you ca=
n read
> an EEPROM, or some GPIO code combination where I can find out what ki=
nd of board
> is plugged each time.
>=20
> If there is not, there is no way to automatically load the overlays; =
you can always
> use the kernel command line, or have the a user space application to =
request the loading
> of a specific board's overlay.

Unfortunately, there is no way to probe the UIBs. :(

> >> Can we get some input by the owner of other similar hardware? I kn=
ow the FPGA
> >> people have similar requirements for example. There are other peop=
le that are hitting
> >> problems getting DT to work with their systems, like the V4L peopl=
e with the order
> >> of initialization; see http://lwn.net/Articles/531068/. I think th=
e V4L problem is
> >> cleanly solved by the overlay being contained in the V4L device no=
de and applied just before
> >> the device is probed.
> >>=20
> >> In the meantime it would be better to wait until we have some ack =
from the maintainers
> >> of the core subsystems about what they think.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
