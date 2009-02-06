From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH B 06/10] OMAP3 pwrdm: add CORE SAR handling (for USBTLL
 module)
Date: Thu, 5 Feb 2009 20:52:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0902052050220.8131@utopia.booyaka.com>
References: <20090128024301.27240.39391.stgit@localhost.localdomain> <20090128024421.27240.95450.stgit@localhost.localdomain> <13B9B4C6EF24D648824FF11BE89671620376DEB7A5@dlee02.ent.ti.com> <alpine.DEB.2.00.0901290042020.32081@utopia.booyaka.com>
 <alpine.DEB.2.00.0901290212360.18004@utopia.booyaka.com> <20090131142213.GL1394@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59956 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbZBFDwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 22:52:18 -0500
In-Reply-To: <20090131142213.GL1394@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hello Russell,

On Sat, 31 Jan 2009, Russell King - ARM Linux wrote:

> On Thu, Jan 29, 2009 at 02:15:44AM -0700, Paul Walmsley wrote:
> > Hi Richard,
> > 
> > On Thu, 29 Jan 2009, Paul Walmsley wrote:
> > 
> > > > TLLSAR is not functional till ES3.1 (and beyound).  Is it possible to flag it this way?
> > > 
> > > Yes, it's easy in this case.  Thanks for the note.  I will send along an 
> > > updated patch for this.
> > 
> > N.B. - fixxing this required a separate change to the omap_chip flag 
> > system, so I'll send the two necessary patches to the linux-omap mailing 
> > list for further testing.
> 
> I'll hold off on this patch then.

The patches that obsolete patch B 06 have lasted a week on linux-omap@vger 
without any comment, so am passing them along in subsequent E-mails.


- Paul
