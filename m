Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2BC433B4
	for <linux-omap@archiver.kernel.org>; Wed,  7 Apr 2021 06:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CC3613C0
	for <linux-omap@archiver.kernel.org>; Wed,  7 Apr 2021 06:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbhDGGK0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:10:26 -0400
Received: from muru.com ([72.249.23.125]:51756 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhDGGKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 7 Apr 2021 02:10:24 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5805780A4;
        Wed,  7 Apr 2021 06:11:24 +0000 (UTC)
Date:   Wed, 7 Apr 2021 09:10:11 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Vignesh R <vigneshr@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: omap: Fix rumtime PM imbalance on error
Message-ID: <YG1Mw89UGIuuIp80@atomide.com>
References: <20210407033030.13419-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407033030.13419-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dinghao Liu <dinghao.liu@zju.edu.cn> [210407 03:31]:
> pm_runtime_get_sync() will increase the rumtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/i2c/busses/i2c-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 12ac4212aded..c9ee0875a79d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1404,7 +1404,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(omap->dev, OMAP_I2C_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(omap->dev);
>  
> -	r = pm_runtime_get_sync(omap->dev);
> +	r = pm_runtime_resume_and_get(omap->dev);
>  	if (r < 0)
>  		goto err_free_mem;
>  
> -- 
> 2.17.1
> 
