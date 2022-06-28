Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE005C43334
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jun 2022 04:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiF1EFZ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbiF1EFU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2022 00:05:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 272C22BB3F
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2022 21:05:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CA64B8106;
        Tue, 28 Jun 2022 04:00:06 +0000 (UTC)
Date:   Tue, 28 Jun 2022 07:05:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] arm/mach-omap2: Fix refcount leak bugs
Message-ID: <Yrp9/Sv6peETdx8v@atomide.com>
References: <20220620155421.4076532-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620155421.4076532-1-windhl@126.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Liang He <windhl@126.com> [220620 15:49]:
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -135,6 +135,7 @@ static int __init omap4_sram_init(void)
>  		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
>  			__func__);
>  	sram_pool = of_gen_pool_get(np, "sram", 0);
> +	of_node_put(np);
>  	if (!sram_pool)
>  		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
>  			__func__);

Here sram_pool is used after of_node_put() on it. Don't we want to do the
put only after no users?

Regards,

Tony
