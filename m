From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific
 changes to support OMAP4 mailbox.
Date: Sat, 05 Sep 2009 11:03:58 +0300 (EEST)
Message-ID: <20090905.110358.124081098.Hiroshi.DOYU@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108EA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35857 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZIEIEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Sep 2009 04:04:13 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108EA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rmk@arm.linux.org.uk, h-kanigeri2@ti.com, grgupta@ti.com

Hi Subramaniam,

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific changes to support OMAP4 mailbox.
Date: Fri, 4 Sep 2009 13:47:09 +0200

> From aa759db084be9a2893de5e61b11f6de6d05508d9 Mon Sep 17 00:00:00 2001
> From: C A Subramaniam <subramaniam.ca@ti.com>
> Date: Wed, 2 Sep 2009 17:52:22 +0530
> Subject: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific changes to support OMAP4 mailbox.
> 
> This patch adds changes to the build related files of mailbox
> driver to support OMAP4 mailbox

The above comment doesn't match the this modification since adding
those module isn't just for OMAP4, but for other omap
architecutres(omap2/3/4). So I think that this explanation should be
changed as not only for omap4, but just for adding common mailbox
support in this Makefile.

> 
> Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 735bae5..4bb426d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -39,6 +39,10 @@ endif
>  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
>  
> +# MAILBOX

I think that the above line is not necessary since the module names
are enough self-explanatory, a little bit nitpicky, though....

> +obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
> +mailbox_mach-objs		:= mailbox.o
> +
>  iommu-y					+= iommu2.o
>  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
>  
> -- 
> 1.5.3.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
