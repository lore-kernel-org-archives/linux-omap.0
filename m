From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2: use 'int' instead of 'unsigned' for
 variable 'gpmc_irq_start'
Date: Thu, 22 Aug 2013 01:32:06 -0700
Message-ID: <20130822083206.GU7656@atomide.com>
References: <521479B4.8030604@asianux.com>
 <20130822071402.GQ7656@atomide.com>
 <5215C12D.5020807@asianux.com>
 <5215C209.3080606@asianux.com>
 <20130822075731.GT7656@atomide.com>
 <5215C555.9060902@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54600 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752251Ab3HVIcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 04:32:15 -0400
Content-Disposition: inline
In-Reply-To: <5215C555.9060902@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Chen Gang <gang.chen@asianux.com> [130822 01:10]:
> On 08/22/2013 03:57 PM, Tony Lindgren wrote:
> > * Chen Gang <gang.chen@asianux.com> [130822 00:55]:
> >> 'gpmc_irq_start' is mostly used as 'int', and for a variable, do not
> >> suggest to only use 'unsigned' as its type, so use 'int' instead of
> >> 'unsigned' for variable 'gpmc_irq_start'.
> >>
> >> Also it will fix the related issue (dummy the real world failure):
> >>
> >>   arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> >>
> > 
> > Thanks applying into omap-for-v3.12/fixes-non-critical.
> > 
> 
> Thank you too.
> 
> Hmm... excuse me, I am not quite familiar with the omap version trees,
> so may have a doubt: "it seems this is a real bug, is it suitable to
> belong to fixes-none-critical tree ?"

For the -rc cycle we try to limit the patches to oopses and regressions,
especially this close to v3.11 being tagged.

It seems the bug has been there for quite some time, and that we don't
seem to have oopses or other failures reporting this. So it seems there's
no reason for urgency to have it merged into the current -rc series.

If you (or somebody else) strongly feels that it should be in applied
to the current -rc series as a fix instead of during the merge window,
then please let me know the failing cases with logs showing what
happens.

Regards,

Tony
