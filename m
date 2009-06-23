From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and
 kick
Date: Tue, 23 Jun 2009 14:05:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906231342350.6545@utopia.booyaka.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com> <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162038E317258@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42705 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZFWUFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 16:05:25 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038E317258@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Richard, 

On Fri, 19 Jun 2009, Woodruff, Richard wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Thursday, June 18, 2009 4:07 PM
> 
> > On Wed, 17 Jun 2009, Woodruff, Richard wrote:
> >
> > > I've only seen the condition along side of very aggressive SDRC_POWER
> > > settings.
> >
> > Could you send over the SDRC_POWER settings that cause this problem?
> 
> This is one pulled for a custom board:
> 
> # ./readmem 0x6d000070
> 0x000200AD

Thanks.

According to the 34xx TRM Table 11-178 this sets the following: (asterisks 
mark differences from the current linux-omap code base.)

  WAKEUPPROC = 0
* AUTOCOUNT = 0x200 
* SRFRONRESET = 1
  SRFRONIDLEREQ = 0
* CLKCTRL = 2
  EXTCLKDIS = 1
  PWDENA = 1
  PAGEPOLICY = 1

Looks like the significant difference is the use of CLKCTRL = 0x2 (+ 
AUTOCOUNT).  Maybe there is some SDRC bug related to CLKCTRL = 0x2 that 
causes this problem?  Perhaps the problem is partially related to PWDENA = 
1 and erratum 1.150?  Anyway, will do a test run here with this SDRC_POWER 
register value and see if the problem reproduces.


- Paul
