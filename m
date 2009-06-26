From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Fri, 26 Jun 2009 11:07:55 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E4C7BDC@dlee02.ent.ti.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
 <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E317258@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906231342350.6545@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E3DA683@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906260052230.2676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbZFZQIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 12:08:04 -0400
In-Reply-To: <alpine.DEB.2.00.0906260052230.2676@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

> On Tue, 23 Jun 2009, Woodruff, Richard wrote:
>
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Tuesday, June 23, 2009 3:05 PM
> >
> > > Looks like the significant difference is the use of CLKCTRL = 0x2 (+
> > > AUTOCOUNT).  Maybe there is some SDRC bug related to CLKCTRL = 0x2 that
> > > causes this problem?  Perhaps the problem is partially related to PWDENA =
> > > 1 and erratum 1.150?  Anyway, will do a test run here with this SDRC_POWER
> > > register value and see if the problem reproduces.
> >
> > It is my guess not for PWDENA as it was reported on a system with that
> > not set.  Yes that should not enabled per errata.  Anyway it only does
> > something in OFF type scenarios where you don't use self-refresh.
> > "Typical" use cases don't seem to be using this.
> >
> > There are a few unlock events which are best for any focused test. Most
> > are supposed to auto-relock but ... I've heard of some validation tests
> > in a few areas maybe they will yield something.
>
> A quick note: in stress testing here, was able to confirm that SDRC_POWER
> = 0x000200AD causes problems under memory load and intensive CORE DVFS.
> SDRC_POWER = 0x0002009D seems to work fine.  The difference is CLKCTRL = 1
> (works) vs. CLKCTRL = 2 (fails).  According to the TRM, CLKCTRL = 2
> enables self-refresh when AUTOCOUNT reaches 0.  There is probably some
> race between AUTOCOUNT and the CORE DVFS SRAM code, or it is tickling some
> SDRC bug.  Will look into this further later.
>
> By the way, there appears to be a TRM bug in the "Dynamic Power Saving
> Configurations" table in the SDRC chapter.  The "External SDRC CLK" column
> should have "after AUTOCOUNT expiration" for CLKCTRL = 1 rows.

That is an interesting result.

My suspicion also has been with some kind of self-refresh race and DLL lock/unlock conditions.  DVFS would stress the DLL lock/unlock path.

In your test did you have a crash or just find the DLL did not relock.  The signature I'm looking for is not locking.  A crash in this particular test might point more to some other issue in sequence.

On another thread it was noted you had optimized out a needed delay after M2 divider change for DVFS.  Fixing this might change behavior of this test.  Stress testing in older code bases along with simulation result showed the delay was necessary.

Regards,
Richard W.

