From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Tue, 08 Feb 2011 15:43:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
 <20110208164747.GD6188@n2100.arm.linux.org.uk>
 <78d0134576ace6be5874871076cf0c10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:34921 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab1BHUnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 15:43:15 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGB003D6G6CZJB0@vl-mh-mrz25.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 08 Feb 2011 15:42:12 -0500 (EST)
In-reply-to: <78d0134576ace6be5874871076cf0c10@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 8 Feb 2011, Santosh Shilimkar wrote:

> > I think it's probably going to be better to _purposely_ break the 
> > OMAP build when it covers v6 and v7 CPUs in these kernels as I don't 
> > think it's sanely fixable given where we are.

Agreed.  At least making SMP unavailable when both v6 and v7 are 
configured should be small and good enough for 2.6.38-rc5.

> Any alternative possible other than breaking the omap2plus build?
> It's quite useful to have one build which covers majority of the
> omap machines.

Just merge this patch series in your testing tree, or create two configs 
(two builds) instead of only (a broken) one.

Or use linux-next for testing which would be even more beneficial.


Nicolas
