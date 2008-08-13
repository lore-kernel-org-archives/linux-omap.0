From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP2/3: fix clock/clockdomain bugs
Date: Wed, 13 Aug 2008 10:43:59 +0300
Message-ID: <20080813074358.GC14224@atomide.com>
References: <20080812212919.24628.82229.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49717 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbYHMHlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 03:41:47 -0400
Content-Disposition: inline
In-Reply-To: <20080812212919.24628.82229.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080813 00:34]:
> This series fixes two bugs that cause N800 to panic on boot:
> 
> - a OMAP2xxx clock code bug, which caused an "Unhandled fault:
>   alignment exception (0x001) at 0xc02....." panic; and
> 
> - an OMAP2/3 clockdomain bug, which caused an "Unable to handle kernel
>   paging request at virtual address 5f75706d" panic.
> 
> These bugs were exposed by 0e5194e1a84c219bebbb78f305b7a8eabc4a3656 and
> 718fc6cd4db902aa2242a736cc3feb8744a4c71a.

Great, thanks! Pushing today.

> With the following patches applied on git head, N800 boots fine, but
> only if CONFIG_DEBUG_LL is enabled.  If it is disabled, it hangs at
> some point in early boot.  Don't know why.

Maybe it needs flasher --enable-rd-mode --set-rd-flags=serial-console?

> These patches also boot-tested cleanly on 2430SDP and 3430SDP, both
> with and without CONFIG_DEBUG_LL.

Good

Tony

>    text    data     bss     dec     hex filename
> 3217805  149808   85008 3452621  34aecd vmlinux.n800.orig
> 3217837  149808   85008 3452653  34aeed vmlinux.n800
> 
>  arch/arm/mach-omap2/clock24xx.c   |    2 ++
>  arch/arm/mach-omap2/clockdomain.c |    6 ++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
