From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Expose omap tags as debugfs binary blob
Date: Tue, 22 Apr 2008 12:23:34 -0700
Message-ID: <20080422192333.GG24257@atomide.com>
References: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com> <1208848630-6771-2-git-send-email-Hiroshi.DOYU@nokia.com> <1208848630-6771-3-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56374 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764989AbYDVTXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 15:23:36 -0400
Content-Disposition: inline
In-Reply-To: <1208848630-6771-3-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080422 00:17]:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/common.c |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index f80dab8..5a501e1 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -289,7 +289,26 @@ void __init omap2_set_globals_343x(void)
>  #endif
>  
>  #ifdef CONFIG_DEBUG_FS
> +
>  struct dentry *omap_debugfs_root;
> +
> +#ifdef CONFIG_OMAP_BOOT_TAG
> +static int __init add_tag_blob(void)
> +{
> +	struct dentry *d;
> +	static struct debugfs_blob_wrapper blob;
> +
> +	blob.data = omap_bootloader_tag;
> +	blob.size = omap_bootloader_tag_len;
> +
> +	d = debugfs_create_blob("tag", 0444, omap_debugfs_root, &blob);
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
> +	return 0;
> +}
> +late_initcall(add_tag_blob);
> +#endif
> +
>  static int __init omap_debugfs_init(void)
>  {
>  	struct dentry *d;
> @@ -301,4 +320,4 @@ static int __init omap_debugfs_init(void)
>  	return 0;
>  }
>  arch_initcall(omap_debugfs_init);
> -#endif
> +#endif	/* CONFIG_DEBUG_FS */
> -- 
> 1.5.5.rc2.6.gf58d

The omap specific ATAGs are not going to mainline as discussed on
few occasions already over past few years..

We should convert all omap specific ATAGs to be arm generic ATAGs
and get rid of the rest and use data in board-*.c files. We can
add a generic ATAG_BOARD_REVISION or similar to set GPIO pins
in board-*.c files based on the board revision.

Tony
