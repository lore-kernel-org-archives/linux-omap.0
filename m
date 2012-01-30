From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the suspend is not implemented
Date: Mon, 30 Jan 2012 23:58:25 +0100
Message-ID: <201201302358.26152.rjw@sisk.pl>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com> <20120124090630.GR16726@n2100.arm.linux.org.uk> <1327923953.2487.13.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57119 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab2A3Wys (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 17:54:48 -0500
In-Reply-To: <1327923953.2487.13.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Monday, January 30, 2012, Artem Bityutskiy wrote:
> On Tue, 2012-01-24 at 09:06 +0000, Russell King - ARM Linux wrote:
> > > However, the bug made it into the 3.3 merge window, so shouldn't this
> > > bugfix be sent upstream immediately?
> > 
> > David is the MTD maintainer, and Artem just helps out.  I believe Artem
> > is waiting for David to finish travelling before asking David (last seen
> > at Hong Kong airport) to pull these fixes.  David in turn will pass them
> > onto Linus.  Plus, Linus only started adding to -rc1 yesterday, so its a
> > little early to expect this to be fixed.
> 
> Hi,
> 
> here is the latest version of the fix.
> 
> http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/283d43b9ce2952535aa89c0195085e2a1b7e5fce
> 
> Also attached.
> 
> From 283d43b9ce2952535aa89c0195085e2a1b7e5fce Mon Sep 17 00:00:00 2001
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Date: Mon, 16 Jan 2012 11:07:16 +0200
> Subject: [PATCH] mtd: fix MTD suspend
> 
> Commits 3fe4bae88460869a8e553397cd9057a4ee7ca341 and
> 079c985e7a6f4ce60f931cebfdd5ee3c3 broke MTD suspend in 2 ways:
> 
> 1. When the '->suspend' method is not present, we return -EOPNOTSUPP,
> but
>    the callers of 'mtd_suspend()' expects 0 instead.
> 2. Checking of the 'mtd' parameter against NULL has been incorrectly
> removed
>    in 'mtd_cls_suspend()'.
> 
> This patch fixes the breakages. This has been found, analyzed, reported
> and tested by Rafael J. Wysocki <rjw@sisk.pl>.
> 
> Note, this patch is not needed in the stable tree because it causes a
> regression introduced during the v3.3 merge window.
> 
> Reported-by: Rafael J. Wysocki <rjw@sisk.pl>
> Tested-by: Rafael J. Wysocki <rjw@sisk.pl>
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Thanks, but is anyone actually going to push it to Linus any time soon?

If not, then I can do that through the linux-pm tree.  I'll be sending
at least one more pull request with fixes for v3.3.

Thanks,
Rafael


> ---
>  drivers/mtd/mtdcore.c   |    2 +-
>  include/linux/mtd/mtd.h |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index b265188..de96865 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -119,7 +119,7 @@ static int mtd_cls_suspend(struct device *dev,
> pm_message_t state)
>  {
>  	struct mtd_info *mtd = dev_get_drvdata(dev);
>  
> -	return mtd_suspend(mtd);
> +	return mtd ? mtd_suspend(mtd) : 0;
>  }
>  
>  static int mtd_cls_resume(struct device *dev)
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 1a81fde..d8c7aad 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -427,9 +427,7 @@ static inline int mtd_is_locked(struct mtd_info
> *mtd, loff_t ofs, uint64_t len)
>  
>  static inline int mtd_suspend(struct mtd_info *mtd)
>  {
> -	if (!mtd->suspend)
> -		return -EOPNOTSUPP;
> -	return mtd->suspend(mtd);
> +	return mtd->suspend ? mtd->suspend(mtd) : 0;
>  }
>  
>  static inline void mtd_resume(struct mtd_info *mtd)
> 

