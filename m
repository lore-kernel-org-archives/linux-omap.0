From: Tony Lindgren <tony@atomide.com>
Subject: Re: [rfc/rft/patch-v2.6.32-omap1+ 2/2] arm: omap: add missing
 __initdata to omap_board_config_kernel
Date: Thu, 7 Jan 2010 10:54:43 -0800
Message-ID: <20100107185442.GG11511@atomide.com>
References: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com>
 <1261000355-2174-3-git-send-email-felipe.balbi@nokia.com>
 <20091216234144.GA11702@localhost.localdomain>
 <20100105234403.GG14533@atomide.com>
 <1262863782.2127.12.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63833 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0AGSyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 13:54:47 -0500
Content-Disposition: inline
In-Reply-To: <1262863782.2127.12.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <kjh@hilman.org>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100107 03:29]:
> On Wed, 2010-01-06 at 00:44 +0100, ext Tony Lindgren wrote:
> > Tomi,
> > 
> > * Ladislav Michl <Ladislav.Michl@seznam.cz> [091216 14:40]:
> > > On Wed, Dec 16, 2009 at 11:52:35PM +0200, Felipe Balbi wrote:
> > > > we still need to get rid of the OMAP_TAG_LCD, but while
> > > > it's still there, let's kill the section mismatches.
> > > 
> > > Hmm, couldn't we just simply remove all empty declarations first? As data section
> > > is zeroed it should not cause any harm. Anyway, patch bellow is entirely untested
> > > and posted for your convenience only :-)
> > 
> > Can you please queue this (and any other fb/dss related board fixes) into your 
> > dss fixes queue?
> 
> Yes, I can take this. Some board changes will cause headaches, as they
> depend on patches in linux-omap, but not in linux. But I guess I'll
> manage =).

Yeah it's always a bit of a pain with the board changes.. Anyways,
if there are some conflict areas, let's try get those patched
away ASAP to remove the dependencies.

Regards,

Tony
