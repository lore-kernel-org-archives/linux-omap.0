From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 4/4] ARM: OMAP: Map SRAM later on with ioremap_exec()
Date: Wed, 05 Oct 2011 19:01:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110051900230.9106@xanadu.home>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005004546.26980.31836.stgit@kaulin.local>
 <alpine.LFD.2.02.1110042107230.9106@xanadu.home>
 <20111005221320.GE6324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:46418 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935484Ab1JEXBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 19:01:11 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSM00IIB7XZ3K00@VL-VM-MR006.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Wed, 05 Oct 2011 19:01:11 -0400 (EDT)
In-reply-to: <20111005221320.GE6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, 5 Oct 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [111004 17:34]:
> > On Tue, 4 Oct 2011, Tony Lindgren wrote:
> > 
> > > This allows us to remove omap hacks for map_io.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Nice cleanup.
> > 
> > Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This one needed minor changes for the omap1 omap_sram_init
> call. Updated patch below, still assuming I have your ack
> for this one too.

Sure.


Nicolas
