From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-pull-request for omap2-upstream branch for next merge window
 (Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Tue, 26 Aug 2008 12:01:33 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808261154200.1624@xanadu.home>
References: <20080819212300.GF17034@flint.arm.linux.org.uk>
 <20080820072310.GA28862@atomide.com> <20080823233711.GM4713@atomide.com>
 <20080826080616.GC24147@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:24383 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044AbYHZQCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 12:02:07 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6700ARTTULXJ33@VL-MH-MR001.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 26 Aug 2008 12:01:34 -0400 (EDT)
In-reply-to: <20080826080616.GC24147@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, 26 Aug 2008, Russell King - ARM Linux wrote:

> The devel branch is _constantly_ remerged.  Basing your tree on it will
> mean I can't merge it.  Please don't.  Base it either on something in
> Linus' tree _or_ something you've already asked me to pull.
> 
> If this continues, I'll go back to only publishing my git tree in diff
> and mbox form.

What's the advantage of screwing everybody only because few individuals 
don't get it right?

It is easy enough to back out a bad pull with git.  If you're tired of 
flaming people, simply ask that any git pull request message also 
contains the information about the commit it is based on so that you can 
ignore bad pulls up front.


Nicolas
