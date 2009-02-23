From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH B 06/10] OMAP3 pwrdm: add CORE SAR handling (for USBTLL module)
Date: Mon, 23 Feb 2009 14:38:01 +0000
Message-ID: <20090223143801.GA27145@n2100.arm.linux.org.uk>
References: <20090128024301.27240.39391.stgit@localhost.localdomain> <20090128024421.27240.95450.stgit@localhost.localdomain> <13B9B4C6EF24D648824FF11BE89671620376DEB7A5@dlee02.ent.ti.com> <alpine.DEB.2.00.0901290042020.32081@utopia.booyaka.com> <alpine.DEB.2.00.0901290212360.18004@utopia.booyaka.com> <20090131142213.GL1394@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0902052050220.8131@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53951 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbZBWOiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 09:38:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0902052050220.8131@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, Feb 05, 2009 at 08:52:17PM -0700, Paul Walmsley wrote:
> Hello Russell,
> 
> On Sat, 31 Jan 2009, Russell King - ARM Linux wrote:
> 
> > On Thu, Jan 29, 2009 at 02:15:44AM -0700, Paul Walmsley wrote:
> > > Hi Richard,
> > > 
> > > On Thu, 29 Jan 2009, Paul Walmsley wrote:
> > > 
> > > > > TLLSAR is not functional till ES3.1 (and beyound).  Is it possible to flag it this way?
> > > > 
> > > > Yes, it's easy in this case.  Thanks for the note.  I will send along an 
> > > > updated patch for this.
> > > 
> > > N.B. - fixxing this required a separate change to the omap_chip flag 
> > > system, so I'll send the two necessary patches to the linux-omap mailing 
> > > list for further testing.
> > 
> > I'll hold off on this patch then.
> 
> The patches that obsolete patch B 06 have lasted a week on linux-omap@vger 
> without any comment, so am passing them along in subsequent E-mails.

It seems that the patches don't obsolete this patch, but instead
require this patch to be applied first.

We really really need to get out of this pattern of building fixes
on top of bad patches.  If a patch is the wrong approach then it is
the wrong approach and should be dropped, or it should be merged with
the patches which fix stuff up to the new approach.

I'm going to combine B06 with patch 2 and hope things come out right.
