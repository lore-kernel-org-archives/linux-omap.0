From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] PRM/CM: Add several new PRM/CM mutator functions
Date: Fri, 4 Apr 2008 12:46:09 +0300
Message-ID: <20080404094609.GI3505@atomide.com>
References: <20080403223439.820599556@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63020 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbYDDJqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 05:46:12 -0400
Content-Disposition: inline
In-Reply-To: <20080403223439.820599556@pwsan.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080404 01:38]:
> 
> Hello, 
> 
> The following two patches add several new PRM/CM manipulation functions
> and convert existing code to use them when appropriate.  
> 
> At the moment, there are not very many users, but the (as yet unpublished)
> PM patches make more extensive use of these.
> 
> Boot-tested on N800.

Pushing today.

Tony


> - Paul
> 
> 
> size:
> 
>    text    data     bss     dec     hex filename
> 2812474  128976   86636 3028086  2e3476 vmlinux.orig
> 2812378  128976   86636 3027990  2e3416 vmlinux
> 
> diffstat:
> 
>  arch/arm/mach-omap2/clock.c       |    8 +++-----
>  arch/arm/mach-omap2/clock24xx.c   |   15 ++++-----------
>  arch/arm/mach-omap2/cm.h          |   34 +++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/pm.c          |   19 +++++--------------
>  arch/arm/mach-omap2/prcm.c        |   14 ++++++++------
>  arch/arm/mach-omap2/prm.h         |   37 ++++++++++++++++++++++++++++++++++---
>  drivers/dsp/dspgateway/dsp_core.c |   14 +++++---------
>  7 files changed, 92 insertions(+), 49 deletions(-)
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
