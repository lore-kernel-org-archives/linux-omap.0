From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Urgent omap4 legacy interrupt regression fix for
 v3.19-rc series
Date: Mon, 19 Jan 2015 16:23:56 -0800
Message-ID: <20150120002356.GJ16883@quad.lixom.net>
References: <20150119230950.GA7718@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41432 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbATAX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 19:23:58 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so41844221pab.4
        for <linux-omap@vger.kernel.org>; Mon, 19 Jan 2015 16:23:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150119230950.GA7718@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jan 19, 2015 at 03:09:51PM -0800, Tony Lindgren wrote:
> The following changes since commit 7ac72746aa9bb305fa74b44ec73eae99bbbe9b66:
> 
>   ARM: dts: Revert disabling of smc91x for n900 (2015-01-06 08:49:57 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gic-regression-v2
> 
> for you to fetch changes up to 0fb22a8fb7f3bc1b00a36d4a97ce4f93191f7559:
> 
>   ARM: OMAP: Work around hardcoded interrupts (2015-01-17 08:56:12 -0800)
> 
> ----------------------------------------------------------------
> A rather urgent pull request to fix omap4 legacy interrupts.
> 
> The legacy interrupts on omap4 got broken when gic got changed to
> use irq_domain_add_linear() instead of the irq_domain_add_legacy(). We
> still have the hardcoded legacy IRQ numbers in use in several places,
> most notably the in the legacy DMA. It took a while to figure out
> what the problem was and how it should be fixed for the -rc series.
> 
> Also include is a regression fix for the dra7 dwc3 suspend.
> 

Merged.


-Olof
