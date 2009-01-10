From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: updated git pull request for omap compile fixes, mailbox and hsmmc
Date: Sat, 10 Jan 2009 11:05:24 +0000
Message-ID: <20090110110524.GC28945@n2100.arm.linux.org.uk>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090107161843.GA11471@n2100.arm.linux.org.uk> <20090107175020.GU27566@atomide.com> <20090107220053.GD11471@n2100.arm.linux.org.uk> <20090108073611.GW27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48222 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZAJLFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 06:05:33 -0500
Content-Disposition: inline
In-Reply-To: <20090108073611.GW27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>

On Thu, Jan 08, 2009 at 09:36:12AM +0200, Tony Lindgren wrote:
> OK, here's the pull request again:
> 
> The following changes since commit ede6f5aea054d3fb67c78857f7abdee602302043:
>   Linus Torvalds (1):
>         Fix up 64-bit byte swaps for most 32-bit architectures
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-misc-for-rmk
> 
> Hiroshi DOYU (10):
>       omap mailbox: cleanup omap2 register definition with macro
>       omap mailbox: add initial omap3 support
>       omap mailbox: print hardware revision at startup
>       omap mailbox: fix empty struct device for omap_mbox
>       omap mailbox: fix empty struct device for omap1
>       omap mailbox: fix empty struct device for omap2
>       omap mailbox: add save_/restore_ctx() for PM
>       omap mailbox: move mailbox.h into mailbox.c
>       omap mailbox: convert sequence bit checking to module paramter
>       omap mailbox: remove unnecessary header file inclusion

I'd rather avoid adding new stuff this late in the merge window - it's
had no exposure in linux-next, etc.

> Jarkko Nikula (1):
>       ARM: OMAP: Fix gpio by switching to generic gpio calls, v2
> 
> Madhusudhan Chikkature (1):
>       omap mmc: Add new omap hsmmc controller for 2430 and 34xx, v3

This I'd argue falls into the same category, but since its well known
between us and Pierre who's acked it, I think it has sufficiently low
impact that it can be accepted.

> Tony Lindgren (1):
>       ARM: OMAP: Fix missing includes

The vast majority of this one is already in via a wider ranging change.
