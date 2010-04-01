From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] omap DEBUG_LL and multiboot changes for 2.6.34
Date: Thu, 1 Apr 2010 05:13:09 -0700
Message-ID: <20100401121309.GQ31200@atomide.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221AAC6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51752 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab0DAMLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 08:11:22 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032221AAC6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [100324 04:39]:
> Tony Lindgren wrote:
> > These patches clean up the DEBUG_LL code for mach-omap1 and mach-omap2
> > and then makes multiboot work for mach-omap2.
> > 
> > Note that these patches currently allow only multiboot for 2420 + 36xx.
> > Adding 2430 and omap4 needs further work.
> > 
> 
> Tony,
> 
> Purely out of curiosity (triggered by someone asking about 2430SDP on
> the list), do you know what it'll take to get mutli-boot working on 2430?

It should work assuming the debug_ll code worked earlier. Do you have
the right serial port connected and CONFIG_EARLYPRINTK enabled? You
also need earlyprink on the kernel cmdline.
 
> I'm not familiar with those boards of course - does anyone still have
> them around?

Yeah, looks like people are using 2430.

Tony
