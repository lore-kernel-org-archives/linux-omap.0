From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Thu, 2 Sep 2010 09:34:54 -0700
Message-ID: <20100902163453.GR11597@atomide.com>
References: <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902162039.GM11597@atomide.com>
 <20100902162537.GU26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0IBQfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 12:35:03 -0400
Content-Disposition: inline
In-Reply-To: <20100902162537.GU26319@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 09:18]:
> On Thu, Sep 02, 2010 at 09:20:40AM -0700, Tony Lindgren wrote:
> > >From 253e91b76e104dbdf05c5c3eaf9cbf426972c938 Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Wed, 1 Sep 2010 16:49:13 -0700
> > Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
> > 
> > Fix v7wbi_tlb_flags for SMP on UP. Note that we must enable MULTI_TLB
> > to avoid undefined reference to cpu_tlb error.
> 
> This isn't required, as it is already covered by my patch.

Yup, seems to be working without this patch.

Tony
