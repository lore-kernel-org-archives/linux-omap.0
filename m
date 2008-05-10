From: Tony Lindgren <tony@atomide.com>
Subject: Re: Recent OMAP git broken on Beagle
Date: Sat, 10 May 2008 11:09:36 -0700
Message-ID: <20080510180935.GA8121@atomide.com>
References: <48254562.7000006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64417 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbYEJSJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 14:09:37 -0400
Content-Disposition: inline
In-Reply-To: <48254562.7000006@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, beagleboard@googlegroups.com

* Dirk Behme <dirk.behme@googlemail.com> [080509 23:49]:
>
> I tried latest OMAP git (2.6.26-rc1-omap1, git from today, HEAD ==  
> 42fa072e237427675752bb9da05bf406bff19719, "OMAP3 EVM: enable ethernet  
> support")  on OMAP3 based BeagleBoard and it immediately stops after  
> output of Kernel command line (with CONFIG_DEBUG_LL enabled):
>
> ...
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> <5>Kernel command line: console=ttyS2,115200n8 ...
>
> No later output or crash, nothing.
>
> On an older 2.6.25-omap1 kernel next output is
>
> ...
> Kernel command line: console=ttyS2,115200n8 ...
> Clocking rate (Crystal/DPLL/ARM core): 26.0/266/381 MHz
> GPMC revision 5.0
> ...
>
> Assuming that it might be related to recent clock or powerdomain changes 
> [1] I switched back to HEAD == "Fix remaining sparse warnings in 
> arch/arm/mach-omap2" (git-checkout  
> cdda2a9adbc5421f4857e0313afc6c189f422e25) and system now boots again.
>
> Any idea?

Can you try git-bisect to see which one breaks booting on beagle?

Tony


> Many thanks
>
> Dirk
>
> [1] http://source.mvista.com/git/?p=linux-omap-2.6.git;a=summary
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
