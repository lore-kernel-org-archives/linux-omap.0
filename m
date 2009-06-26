From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and
 kick
Date: Fri, 26 Jun 2009 02:45:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906260052230.2676@utopia.booyaka.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com> <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038E317258@dlee02.ent.ti.com> <alpine.DEB.2.00.0906231342350.6545@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038E3DA683@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42094 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbZFZIpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 04:45:22 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038E3DA683@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 23 Jun 2009, Woodruff, Richard wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, June 23, 2009 3:05 PM
> 
> > Looks like the significant difference is the use of CLKCTRL = 0x2 (+
> > AUTOCOUNT).  Maybe there is some SDRC bug related to CLKCTRL = 0x2 that
> > causes this problem?  Perhaps the problem is partially related to PWDENA =
> > 1 and erratum 1.150?  Anyway, will do a test run here with this SDRC_POWER
> > register value and see if the problem reproduces.
> 
> It is my guess not for PWDENA as it was reported on a system with that 
> not set.  Yes that should not enabled per errata.  Anyway it only does 
> something in OFF type scenarios where you don't use self-refresh. 
> "Typical" use cases don't seem to be using this.
> 
> There are a few unlock events which are best for any focused test. Most 
> are supposed to auto-relock but ... I've heard of some validation tests 
> in a few areas maybe they will yield something.

A quick note: in stress testing here, was able to confirm that SDRC_POWER 
= 0x000200AD causes problems under memory load and intensive CORE DVFS.  
SDRC_POWER = 0x0002009D seems to work fine.  The difference is CLKCTRL = 1 
(works) vs. CLKCTRL = 2 (fails).  According to the TRM, CLKCTRL = 2 
enables self-refresh when AUTOCOUNT reaches 0.  There is probably some 
race between AUTOCOUNT and the CORE DVFS SRAM code, or it is tickling some 
SDRC bug.  Will look into this further later.

By the way, there appears to be a TRM bug in the "Dynamic Power Saving 
Configurations" table in the SDRC chapter.  The "External SDRC CLK" column 
should have "after AUTOCOUNT expiration" for CLKCTRL = 1 rows.


- Paul
