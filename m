From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen
 in init_early
Date: Fri, 07 Oct 2011 19:26:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110071926000.6390@xanadu.home>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005014044.GZ6324@atomide.com>
 <alpine.LFD.2.02.1110042150190.9106@xanadu.home>
 <20111006013656.GG6324@atomide.com> <4E8EA2A4.5070301@ti.com>
 <20111007145403.GG6324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:33950 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab1JGX04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 19:26:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSP00063YF1HS50@VL-VM-MR001.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 07 Oct 2011 19:25:49 -0400 (EDT)
In-reply-to: <20111007145403.GG6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, 7 Oct 2011, Tony Lindgren wrote:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:22]:
> > The changes looks fine to me. Though the ugly hard-coding
> > is back with it, it's a step towards generic_io, so hopefully
> > it won't have to stay for long time.
> 
> Nico please correct me if I'm wrong, but I think that with
> generic map_io we have static mappings in place after map_io,
> and then ioremap should work for the static mappings right
> after map_io except without the need for __arch_ioremap.

Yes, that _should_ work.


Nicolas
