Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE4C64E7B
	for <linux-omap@archiver.kernel.org>; Mon, 30 Nov 2020 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB720727
	for <linux-omap@archiver.kernel.org>; Mon, 30 Nov 2020 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AevhoE1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgK3NXU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:23:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60304 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgK3NXT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2020 08:23:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDLRoQ107702;
        Mon, 30 Nov 2020 07:21:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606742487;
        bh=Mfl8piKXq1Vk9257jPjchMPYONo1hkj9MluCkPTJA/U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AevhoE1neDmPS1jW2YCLACZLHAM8lFXKzw17W6Uca8jfteTkJPTq5QWeFQzSzmdou
         oZTxJgbvxjkDjlYFwRtzq4zdoEKIg6wcJ33vzsPiRS9ZcZq4dPL7uTX7591xH8axCJ
         VedfDX3hViNeEjxmLeVjPscOgjzR5seAnrEXQDYU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUDLQlj059044
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 07:21:26 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 07:21:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 07:21:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDLQcC060763;
        Mon, 30 Nov 2020 07:21:26 -0600
Date:   Mon, 30 Nov 2020 07:21:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
CC:     <krzk@kernel.org>, <tony@atomide.com>, <linux@armlinux.org.uk>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, <tmlind@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: drop unused POWER_AVS option
Message-ID: <20201130132126.x5wffoo5oegybehm@surfer>
References: <20201130124233.32569-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130124233.32569-1-andrey.zhizhikin@leica-geosystems.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 12:42-20201130, Andrey Zhizhikin wrote:
> Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
> corresponding Kconfig") moved AVS code to SOC-specific folders, and
> removed corresponding Kconfig from drivers/power, leaving original
> POWER_AVS config option enabled in omap2plus_defconfig file.
> 
> Remove the option, which has no references in the tree anymore.
> 
> Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 34793aabdb65..de3b7813a1ce 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -297,7 +297,6 @@ CONFIG_GPIO_TWL4030=y
>  CONFIG_W1=m
>  CONFIG_HDQ_MASTER_OMAP=m
>  CONFIG_W1_SLAVE_DS250X=m
> -CONFIG_POWER_AVS=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_GPIO=y
>  CONFIG_BATTERY_BQ27XXX=m
> -- 
> 2.17.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
