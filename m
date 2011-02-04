From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Allow using machine ID for DEBUG_LL macros
Date: Thu, 3 Feb 2011 19:13:08 -0800
Message-ID: <20110204031307.GS3322@atomide.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1102032057070.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41427 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab1BDDNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 22:13:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102032057070.12104@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [110203 18:01]:
> On Thu, 3 Feb 2011, Tony Lindgren wrote:
> 
> > Hi all,
> > 
> > Here are two patches that allow using machine ID for DEBUG_LL
> > macros by adding a new macro inituart.
> 
> This won't work with the device tree support as the machine ID is then 
> replaced with a catch-it-all-with-dt-support machine ID.

Hmm, maybe for device tree we could only have it initialized later
on by setting up custom early_printk in early_printk.c based on the
device tree data or machine ID?

It won't work very early then though.. If we want it to work early
we could allocate some fixed memory chunk for addruart etc functions
for which the bootloader just passes addresses.

Tony
