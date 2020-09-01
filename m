Return-Path: <SRS0=f1XC=CK=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CCC433E2
	for <linux-omap@archiver.kernel.org>; Tue,  1 Sep 2020 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B014F20FC3
	for <linux-omap@archiver.kernel.org>; Tue,  1 Sep 2020 07:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAHLs (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:11:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgIAHLr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 1 Sep 2020 03:11:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4EA634177EED400AC60E;
        Tue,  1 Sep 2020 15:11:45 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 15:11:39 +0800
Subject: Re: [PATCH -next] memory: omap-gpmc: Fix -Wunused-function warnings
To:     <rogerq@ti.com>, <tony@atomide.com>, <krzk@kernel.org>
References: <20200901035642.22772-1-yuehaibing@huawei.com>
 <20200901070753.24328-1-yuehaibing@huawei.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <5f8ae4a2-7d20-6621-67a9-4a47df2e3763@huawei.com>
Date:   Tue, 1 Sep 2020 15:11:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200901070753.24328-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Pls ignore this.

On 2020/9/1 15:07, YueHaibing wrote:
> drivers/memory/omap-gpmc.c:987:12: warning: ‘gpmc_cs_remap’ defined but not used [-Wunused-function]
>  static int gpmc_cs_remap(int cs, u32 base)
>             ^~~~~~~~~~~~~
> drivers/memory/omap-gpmc.c:926:20: warning: ‘gpmc_cs_get_name’ defined but not used [-Wunused-function]
>  static const char *gpmc_cs_get_name(int cs)
>                     ^~~~~~~~~~~~~~~~
> drivers/memory/omap-gpmc.c:919:13: warning: ‘gpmc_cs_set_name’ defined but not used [-Wunused-function]
>  static void gpmc_cs_set_name(int cs, const char *name)
>              ^~~~~~~~~~~~~~~~
> Make them as  __maybe_unused to fix this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/memory/omap-gpmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index ac0f577a51a1..24372254986e 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -916,14 +916,14 @@ static bool gpmc_cs_reserved(int cs)
>  	return gpmc->flags & GPMC_CS_RESERVED;
>  }
>  
> -static void gpmc_cs_set_name(int cs, const char *name)
> +static void __maybe_unused gpmc_cs_set_name(int cs, const char *name)
>  {
>  	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
>  
>  	gpmc->name = name;
>  }
>  
> -static const char *gpmc_cs_get_name(int cs)
> +static const __maybe_unused char *gpmc_cs_get_name(int cs)
>  {
>  	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
>  
> @@ -984,7 +984,7 @@ static int gpmc_cs_delete_mem(int cs)
>   * "base". Returns 0 on success and appropriate negative error code
>   * on failure.
>   */
> -static int gpmc_cs_remap(int cs, u32 base)
> +static int __maybe_unused gpmc_cs_remap(int cs, u32 base)
>  {
>  	int ret;
>  	u32 old_base, size;
> 

