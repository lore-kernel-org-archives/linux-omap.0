Return-Path: <SRS0=olK2=BH=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2642C433E1
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jul 2020 03:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D46C20775
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jul 2020 03:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgG1DoB (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:44:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbgG1DoB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 27 Jul 2020 23:44:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34EDD7B55506FB966D52;
        Tue, 28 Jul 2020 11:43:58 +0800 (CST)
Received: from [10.174.179.105] (10.174.179.105) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 28 Jul
 2020 11:43:57 +0800
Subject: Re: [PATCH] clk: ti: clkctrl: add the missed kfree() for
 _ti_omap4_clkctrl_setup()
To:     Stephen Boyd <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <robh@kernel.org>, <t-kristo@ti.com>, <tony@atomide.com>
References: <20200720122343.178203-1-jingxiangfeng@huawei.com>
 <159589945839.1360974.1977401781355555451@swboyd.mtv.corp.google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F1F9EF8.6090304@huawei.com>
Date:   Tue, 28 Jul 2020 11:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <159589945839.1360974.1977401781355555451@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.105]
X-CFilter-Loop: Reflected
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org



On 2020/7/28 9:24, Stephen Boyd wrote:
> Quoting Jing Xiangfeng (2020-07-20 05:23:43)
>> _ti_omap4_clkctrl_setup() misses to call kfree() in an error path. Add
>> the missed function call to fix it.
>>
>> Fixes: 6c3090520554 ("clk: ti: clkctrl: Fix hidden dependency to node name")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> ---
>>   drivers/clk/ti/clkctrl.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
>> index 864c484bde1b..868e50132c21 100644
>> --- a/drivers/clk/ti/clkctrl.c
>> +++ b/drivers/clk/ti/clkctrl.c
>> @@ -655,8 +655,10 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>>                  }
>>
>>                  hw = kzalloc(sizeof(*hw), GFP_KERNEL);
>> -               if (!hw)
>> +               if (!hw) {
>> +                       kfree(clkctrl_name);
>>                          return;
>> +               }
>
> Why not goto cleanup?

Thanks, I will change it as you suggested.

>
>>
>>                  hw->enable_reg.ptr = provider->base + reg_data->offset;
>>
>> --
>> 2.17.1
>>
> .
>
