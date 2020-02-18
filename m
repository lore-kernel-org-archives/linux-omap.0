Return-Path: <SRS0=SA7d=4G=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5107BC34031
	for <linux-omap@archiver.kernel.org>; Tue, 18 Feb 2020 05:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8621D7D
	for <linux-omap@archiver.kernel.org>; Tue, 18 Feb 2020 05:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ACmQ44+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgBRF57 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:57:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50950 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgBRF57 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 18 Feb 2020 00:57:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01I5vjwS080484;
        Mon, 17 Feb 2020 23:57:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582005465;
        bh=nz+Gado79oO1FRYIr2KgSIcakRLc083x17+uZVM4+Fw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ACmQ44+bJvDDI/BItW00S3jOVmBEV2t42SRxQU1OzRW/cQnWXA3YDTdMFsRgFLRJy
         bbaGMkgOu78/9P1KgwejNIGK6fiW4F3+QKxbBDMmHqCzN8p9XCpGWQW434wpjfRdkF
         w3YiPP9V8xmRS8/9WECVHQGU4c6IoKUqSQGxtjAY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01I5vj56129995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Feb 2020 23:57:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 17
 Feb 2020 23:57:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 17 Feb 2020 23:57:45 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01I5vc3L019831;
        Mon, 17 Feb 2020 23:57:39 -0600
Subject: Re: [PATCH] i2c: omap: use devm_platform_ioremap_resource()
To:     <qiwuchen55@gmail.com>, <tony@atomide.com>, <aaro.koskinen@iki.fi>
CC:     <linux-omap@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
References: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <5f045d3c-d106-9f2d-1b2c-b7b6b04bfaba@ti.com>
Date:   Tue, 18 Feb 2020 11:28:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org



On 15/02/20 2:06 pm, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use a new API devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/i2c/busses/i2c-omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 2dfea35..47d994a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1355,7 +1355,6 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
>  {
>  	struct omap_i2c_dev	*omap;
>  	struct i2c_adapter	*adap;
> -	struct resource		*mem;
>  	const struct omap_i2c_bus_platform_data *pdata =
>  		dev_get_platdata(&pdev->dev);
>  	struct device_node	*node = pdev->dev.of_node;
> @@ -1375,8 +1374,7 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
>  	if (!omap)
>  		return -ENOMEM;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	omap->base = devm_ioremap_resource(&pdev->dev, mem);
> +	omap->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(omap->base))
>  		return PTR_ERR(omap->base);
>  
> 

-- 
Regards
Vignesh
