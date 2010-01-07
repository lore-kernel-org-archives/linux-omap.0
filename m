From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [rfc/rft/patch-v2.6.32-omap1+ 2/2] arm: omap: add missing
 __initdata to omap_board_config_kernel
Date: Thu, 07 Jan 2010 13:29:42 +0200
Message-ID: <1262863782.2127.12.camel@tubuntu.research.nokia.com>
References: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com>
	 <1261000355-2174-3-git-send-email-felipe.balbi@nokia.com>
	 <20091216234144.GA11702@localhost.localdomain>
	 <20100105234403.GG14533@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16759 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0AGLbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 06:31:19 -0500
In-Reply-To: <20100105234403.GG14533@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <kjh@hilman.org>

On Wed, 2010-01-06 at 00:44 +0100, ext Tony Lindgren wrote:
> Tomi,
> 
> * Ladislav Michl <Ladislav.Michl@seznam.cz> [091216 14:40]:
> > On Wed, Dec 16, 2009 at 11:52:35PM +0200, Felipe Balbi wrote:
> > > we still need to get rid of the OMAP_TAG_LCD, but while
> > > it's still there, let's kill the section mismatches.
> > 
> > Hmm, couldn't we just simply remove all empty declarations first? As data section
> > is zeroed it should not cause any harm. Anyway, patch bellow is entirely untested
> > and posted for your convenience only :-)
> 
> Can you please queue this (and any other fb/dss related board fixes) into your 
> dss fixes queue?

Yes, I can take this. Some board changes will cause headaches, as they
depend on patches in linux-omap, but not in linux. But I guess I'll
manage =).

 Tomi


