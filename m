From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Tue, 8 Jan 2013 10:00:42 +0000
Message-ID: <20130108100042.GD21994@gmail.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <93BF5C62-ADE8-4EFC-9175-C2D7E43300E3@antoniou-consulting.com>
 <20130107210551.GL14149@atomide.com>
 <201301072135.05166.arnd@arndb.de>
 <89A7A8FD-935E-4225-8C7B-EA1DBA0C2780@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <89A7A8FD-935E-4225-8C7B-EA1DBA0C2780@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus.wall>
List-Id: linux-omap@vger.kernel.org

> >>> At the end of the line, some kind of hardware glue is going to be=
 needed.
> >>>=20
> >>> I just feel that drawing from a sample size of 1 (maybe 2 if I ge=
t to throw
> >>> in the beagleboard), it is a bit premature to think about making =
it overly
> >>> general, besides the part that are obviously part of the infrastr=
ucture=20
> >>> (like the DT overlay stuff).
> >>>=20
> >>> What I'm getting at, is that we need some user experience about t=
his, before
> >>> going away and creating structure out of possible misconception a=
bout the uses.=20
> >>=20
> >> IMHO stuff like this will be needed by many SoCs. Some examples of=
 similar
> >> things for omaps that have eventually become generic frameworks ha=
ve been
> >> the clock framework, USB OTG support, runtime PM, pinmux framework=
 and
> >> so on.
> >>=20
> >> So I suggest a minimal generic API from the start as that will mak=
e things
> >> a lot easier in the long run.
> >=20
> > I agree. The ux500 platform already has the concept of "user interf=
ace boards",
> > which currently is not well integrated into devicetree. I believe S=
ascha
> > mentioned that Pengutronix had been shipping some other systems wit=
h add-on
> > boards and generating device tree binaries from source for each com=
bination.
> >=20
> > Ideally, both of the above should be able to use the same DT overla=
y logic
> > as BeagleBone, and I'm sure there are more of those.
>=20
> Hmm, I see.=20
>=20
> I will need some more information about the interface of the 'user in=
terface boards'.
> I.e. how is the board identified, what is typically present on those =
boards, etc.

User Interface Boards are mearly removable PCBs which are interchangeab=
le
amongst various hardware platforms. They are connected via numerous
connectors which carry all sorts of different data links; i2c, spi, rs2=
32,
etc. The UIB I'm looking at right now has a touchscreen, speakers, a ke=
y
pad, leds, jumpers, switches and a bunch of sensors.

You can find a small example of how we interface to these by viewing
'arch/arm/boot/dts/stuib.dtsi'. To add a UIB to a particular build, we
currently include it as a *.dtsi from a platform's dts file.

> Can we get some input by the owner of other similar hardware? I know =
the FPGA
> people have similar requirements for example. There are other people =
that are hitting
> problems getting DT to work with their systems, like the V4L people w=
ith the order
> of initialization; see http://lwn.net/Articles/531068/. I think the V=
4L problem is
> cleanly solved by the overlay being contained in the V4L device node =
and applied just before
> the device is probed.
>=20
> In the meantime it would be better to wait until we have some ack fro=
m the maintainers
> of the core subsystems about what they think.
> =20
> Regards
>=20
> -- Pantelis
>=20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
