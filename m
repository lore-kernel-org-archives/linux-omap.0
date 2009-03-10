From: David Brownell <david-b@pacbell.net>
Subject: Re: [APPLIED] [PATCH v2] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Tue, 10 Mar 2009 13:05:45 -0800
Message-ID: <200903101405.46229.david-b@pacbell.net>
References: <notify-1236713705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n12b.bullet.mail.mud.yahoo.com ([209.191.125.179]:43929 "HELO
	n12b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755008AbZCJVLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2009 17:11:40 -0400
In-Reply-To: <notify-1236713705@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Juha Yrjola <juha.yrjola@solidboot.com>

On Tuesday 10 March 2009, Tony Lindgren wrote:
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.

  CC      arch/arm/mach-omap2/prcm.o
arch/arm/mach-omap2/prcm.c: In function 'omap_prcm_arch_reset':
arch/arm/mach-omap2/prcm.c:56: error: 'OMAP343X_SCRATCHPAD' undeclared (first use in this function)
arch/arm/mach-omap2/prcm.c:56: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/prcm.c:56: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-omap2/prcm.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

> 
> Commit: 73b65cde9647508313b3d686dff0f3d1d92482d1
> 
> PatchWorks
> http://patchwork.kernel.org/patch/10718/
> 
> Git
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=73b65cde9647508313b3d686dff0f3d1d92482d1
> 
> 
> 

