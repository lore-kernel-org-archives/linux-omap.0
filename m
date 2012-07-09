From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] arm/dts: Audio support for OMAP4 devices (SDP,
 PandaBoard)
Date: Mon, 9 Jul 2012 05:50:25 -0700
Message-ID: <20120709125025.GG1122@atomide.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
 <4FFACC55.4060106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FFACC55.4060106@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120709 05:24]:
> Hello,
>=20
> On 06/08/2012 04:01 PM, Peter Ujfalusi wrote:
> > Hello,
> >=20
> > The following series enable the audio functionality on OMAP4 based =
devices using
> > twl6040 as audio codec.
> >=20
> > The series adds the needed bindings in the dts for the OMAP IPs, tw=
l6040 MFD
> > device and for the audio connection on the board.
> >=20
> > To be able to differentiate between PandaBoard and PandaBoardES (th=
ey have a bit
> > different audio configuration) a new dts file has been created whic=
h only
> > changes the audio properties different between the two boards.
> >=20
> > Patches for the drivers involved and the documentation related to d=
ts sections
> > has been either in 3.5 or heading for 3.6.
>=20
> Probably this series has been overlooked, since I have not received f=
eedback
> on it.
> Should I resend the series? Which tree should I use to rebase it?

Hmm yeah looks good to me. I guess I was waiting for Benoit to apply or=
 ack
them. I'll apply them into devel-dt branch.

Regards,

Tony
=20
> Thank you,
> P=C3=A9ter
>=20
> >=20
> > Regards,
> > Peter
> > ---
> > Peter Ujfalusi (7):
> >   arm/dts: omap4: Add entry for OMAP McPDM IP
> >   arm/dts: omap4: Add entry for OMAP DMIC IP
> >   arm/dts: omap4-sdp: Add fixed regulator to represent VBAT
> >   arm/dts: omap4-sdp: Add support for twl6040
> >   arm/dts: omap4-sdp: Enable audio support via device tree
> >   arm/dts: omap4-panda: Audio support for PandaBoard 4430
> >   arm/dts: New dts file for PandaBoardES (4460)
> >=20
> >  arch/arm/boot/dts/omap4-panda.dts   |   37 +++++++++++++++++++
> >  arch/arm/boot/dts/omap4-pandaES.dts |   24 ++++++++++++
> >  arch/arm/boot/dts/omap4-sdp.dts     |   68 +++++++++++++++++++++++=
++++++++++++
> >  arch/arm/boot/dts/omap4.dtsi        |   18 +++++++++
> >  4 files changed, 147 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap4-pandaES.dts
> >=20
>=20
>=20
