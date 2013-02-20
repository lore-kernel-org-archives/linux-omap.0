From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
Date: Wed, 20 Feb 2013 20:03:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302201917530.10878@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <20130215064429.GA30038@arwen.pp.htv.fi> <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com> <20130220191638.GA25609@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-434138292-1361390596=:10878"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38800 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935172Ab3BTUDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 15:03:17 -0500
In-Reply-To: <20130220191638.GA25609@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-434138292-1361390596=:10878
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 20 Feb 2013, Felipe Balbi wrote:

> On Wed, Feb 20, 2013 at 05:38:49PM +0000, Paul Walmsley wrote:
> > > > Drivers shouldn't touch their IP block's SYSCONFIG registers.  They=
 don't=20
>=20
> just now I noticed this fun fact:
>=20
> "driver's should touch *their* SYSCONFIG registers"
>=20
> You're stating yourself that SYSCONFIG belongs to the IP and the IP is
> fully controlled by its driver. ;-)

Hehe.  I should have used some more convoluted expression :-)

> > Ideally Linux drivers would be as independent as possible from their So=
C-=20
> > or board-specific integration.  This includes bus integration, etc.  Th=
at=20
> > way, an IP block like UART, where most or all of the registers are shar=
ed=20
> > with the common 8250 code, might be able to use a shared driver.
>=20
> right, then why did we even bother adding omap-serial ? If the whole
> idea was to hide integration, what was the point in introducing
> omap-serial ?

My distant recollection was that the main impetus at the time was DMA=20
support.  Which might be moot, now.  Not really my parish.

> > Also, it should be noted that the TI wrapper isn't necessarily common t=
o=20
> > all TI SoCs :-)  The wrapper bits and functions can change from TI SoC =
to=20
> > SoC.
>=20
> yeah, that's because of the chassis architecture definition and has
> little value to current discussion ;-)

The point was that we don't want to duplicate that code in each driver for=
=20
each SoC ... rather, it can live in one place, in some separate=20
integration layer.

> It does touch the IP block. After the asynchronous PM handshake
> (Ack-Req) is successful the IP block isn't in a usable state.

Usually that's just because the PRCM has cut some clock to the device.
You can chat with Beno=EEt about this if you want; we had a discussion last=
=20
year about it in relation to the 32K_SYNCTIMER.

> > As far as reset goes, the chip-wide reset bits affect the IP block too,=
=20
> > but we wouldn't put that code into the drivers :-)
>=20
> why not ?=20

In the OMAP case, the SoC-wide reset bits are in the PRCM somewhere, which=
=20
in turn assert reset for a wide set of IP blocks.  So there's not much=20
point to putting code for that in the drivers.

> What happens when drivers need to reset the IP ? For cases
> where we need "reset in runtime", drivers are the best entities to know
> exactly where the IP must be reset.

We might be miscommunicating.  I was mostly referring to SoC-wide reset in=
=20
my (somewhat silly) counterfactual.

So there are at least three kinds of reset in this context, that I think=20
about:

1. SoC-level reset
2. Bus-level reset
3. Device-level reset

Ideally these are all independent, even though they might share some of=20
the same hardware mechanisms.  The case that's causing us so much hassle=20
is bus-level reset.  The problem is that some of the OMAP devices - say,=20
7-10% - can't be reset and idled simply with a bus-level reset.  I'd=20
consider the exceptions as hardware bugs, but we still have to deal with=20
them.

> Also, IMHO reset should always be done during probe() so driver can be
> dead sure that we're starting from a known state. This is even more
> important for the complex IPs which are licensed from RTL vendors and
> are used in different SoCs. While arch/arm/mach-abc/ resets every IP
> pior to probe() being called, we can't be sure that arch/arm/mach-xyz/
> will do the same thing and imposing such requirement is too difficult.
>=20
> Problem just gets worse when you consider SoCs from completely different
> architectures (say ARM and Blackfin) using the same IP licensed from
> a particular RTL vendor.

Or if there's no driver for the device at all :-(


- Paul
--843723315-434138292-1361390596=:10878--
