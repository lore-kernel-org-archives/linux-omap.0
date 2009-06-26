From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: RFC: Reclaim address space on omaps, Tony on vacation in July
Date: Fri, 26 Jun 2009 09:37:22 +0100
Message-ID: <20090626083722.GP8354@trinity.fluff.org>
References: <20090626062539.GX7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:54425 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbZFZIh0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jun 2009 04:37:26 -0400
Content-Disposition: inline
In-Reply-To: <20090626062539.GX7352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, Jun 26, 2009 at 09:25:40AM +0300, Tony Lindgren wrote:
> Hi all,
> 
> Last week I posted some more omap io.h clean-up patches to the linux-omap
> list [1], and started looking at what it would take to reclaim lost address
> space on top of the io.h clean-up patches.
> 
> Looks like we should be able to reclaim about 454MB of the 640MB
> of the lost IO address space by doing the following:
> 
> 1. Start converting drivers using omap_read/write to use ioremap +
>    __raw_read/write

ioremap implies readl/writel, the __raw stuff is for items that have been
mapped by iodesc (iirc).

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

