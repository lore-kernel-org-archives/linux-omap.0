Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF0C433EF
	for <linux-omap@archiver.kernel.org>; Mon,  4 Jul 2022 07:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGDHrE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 4 Jul 2022 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiGDHrE (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jul 2022 03:47:04 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF1CB9FDF
        for <linux-omap@vger.kernel.org>; Mon,  4 Jul 2022 00:47:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C34BC80C1;
        Mon,  4 Jul 2022 07:41:38 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:47:01 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org
Subject: Re: [PATCH 3/3] arm: omap2: prm_common: Add the refcount for new
 reference creation
Message-ID: <YsKa9czyRpYa7UDA@atomide.com>
References: <20220701112649.233322-1-windhl@126.com>
 <20220701112649.233322-3-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701112649.233322-3-windhl@126.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Liang He <windhl@126.com> [220701 14:22]:
> In omap2_prm_base_init(), for_each_matching_node_and_match() can
> automatically increase and decrease the refcounting. However, a
> new reference is escaped out into 'data->np', so we need to use
> of_node_put() for the old reference and use of_node_get() for the
> new one.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/arm/mach-omap2/prm_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index fb2d48cfe756..bed151e3f165 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -764,7 +764,8 @@ int __init omap2_prm_base_init(void)
>  			prm_base.pa = res.start + data->offset;
>  		}
>  
> -		data->np = np;
> +		of_node_put(data->np);
> +		data->np = of_node_get(np);
>  
>  		if (data->init)
>  			data->init(data);

Hmm so I don't get how this improves things? Don't we enable with
the same refcounting?

Regards,

Tony
