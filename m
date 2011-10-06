From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Thu, 6 Oct 2011 10:14:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110061005420.4611@utopia.booyaka.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com> <alpine.DEB.2.00.1110051206090.4611@utopia.booyaka.com> <CABi1daF7+Rzq-CWOOW3PVY3cgstBdvqZ0p_HMeLBNJiy1tVVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-33122998-1317917662=:4611"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965046Ab1JFQOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 12:14:24 -0400
In-Reply-To: <CABi1daF7+Rzq-CWOOW3PVY3cgstBdvqZ0p_HMeLBNJiy1tVVbw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Hylands <dhylands@gmail.com>
Cc: linux-omap@vger.kernel.org, sakoman@gmail.com, khilman@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-33122998-1317917662=:4611
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dave,

On Wed, 5 Oct 2011, Dave Hylands wrote:

> On Wed, Oct 5, 2011 at 11:09 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 5 Oct 2011, Dave Hylands wrote:
> >
> >> I have an older overo board, which has an OMAP3503
> >>
> >> U-booot reports:
> >> OMAP3503-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
> >>
> >> In order to get the 2.6.39 kernel to boot, I had to make 2 modificatio=
ns:
> >>
> >> In arch/arm/mach-omap2/pm34xx.c, in the omap_sram_idle routine I had
> >> to put an #if 0 around:
> >>
> >> #if 0
> >> =A0 =A0 =A0 =A0if (omap3_has_io_wakeup() &&
> >> =A0 =A0 =A0 =A0 =A0 =A0(per_next_state < PWRDM_POWER_ON ||
> >> =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_ON)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_prm_set_mod_reg_bits(OMAP3430_EN_=
IO_MASK,
> >> WKUP_MOD, PM_WKEN);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_enable_io_chain();
> >> =A0 =A0 =A0 =A0}
> >> #endif
> >>
> >> or I would get continuous
> >>
> >> Wake up daisy chain activation failed.
> >>
> >> messages on the console.
> >
> > Looking at the 2.6.39 kernel sources, those messages are coming from
> > mach-omap2/pm34xx.c:omap3_enable_io_chain(). =A0That means that somethi=
ng is
> > seriously wrong since that code should only be executing on ES3.1 chips
> > and higher.
> >
> > Could you put something similar to a
> >
> > pr_err("** omap_rev is %08x\n", omap_rev());
> >
> > in your pm34xx.c right above the #if 0 that you added and let us know w=
hat
> > it says?
>=20
> It reports
>=20
> ** omap_rev is 35030234

Thanks.  This particular problem (for the 35xx series) was fixed by commit=
=20
1f1b0353aa3ba5dfc35641452484ea4158ee3c9c ("OMAP3: id: remove=20
identification codes that only correspond to marketing names"), which=20
should go upstream during the 3.2 merge window.

For your local kernel, since you seem okay with modifying it, I'd simply=20
suggest commenting out the call to omap3_enable_io_chain().  You'll=20
probably want to leave in the line that sets the EN_IO bit.

But Steve is correct that these types of unbounded range comparisons=20
shouldn't be done with omap_rev(), at least not without further=20
restrictions as to the SoC type under consideration.  Most of these seem=20
to be located in arch/arm/mach-omap2/pm34xx.c, so what's needed is a patch=
=20
to clean these up that can also go into the stable kernel release series.


- Paul
--155748971-33122998-1317917662=:4611--
