From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/4] initialize omap SRAM later on with __arm_ioremap_exec()
Date: Fri, 07 Oct 2011 16:23:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110071622090.6390@xanadu.home>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <4E8C0125.1060300@ti.com> <20111006014219.GH6324@atomide.com>
 <4E8EA35E.6050100@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:31451 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab1JGUXq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 16:23:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSP005N1PZJ4J70@VL-VM-MR005.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 07 Oct 2011 16:23:44 -0400 (EDT)
In-reply-to: <4E8EA35E.6050100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 7 Oct 2011, Santosh Shilimkar wrote:

> I have reviewed and tested this series. No problems seen.
> As asked on other thread, if you are targeting this one for
> 3.2, then sram changes would have a small conflict with
> OMAP4 errata patch. If it is for 3.3, we should be able to
> sort out that conflict easily.

3.2 please.  I've postponed one of my series to 3.3 because it breaks 
OMAP unless those changes are applied first.


Nicolas
