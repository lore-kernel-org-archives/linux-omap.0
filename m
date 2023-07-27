Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD21C04A6A
	for <linux-omap@archiver.kernel.org>; Thu, 27 Jul 2023 12:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjG0MXx (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Jul 2023 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjG0MXZ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jul 2023 08:23:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C730C0;
        Thu, 27 Jul 2023 05:22:58 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBVJ83mtJzrS0S;
        Thu, 27 Jul 2023 20:22:00 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 20:22:54 +0800
Message-ID: <fa679d37-30cd-9f53-1043-f29de93574f0@huawei.com>
Date:   Thu, 27 Jul 2023 20:22:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2] gpio: omap: Remove redundant dev_err_probe()
Content-Language: en-US
To:     Andy Shevchenko <andy@kernel.org>
CC:     <j-keerthy@ti.com>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <grygorii.strashko@ti.com>, <ssantosh@kernel.org>,
        <khilman@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20230727115704.2663211-1-ruanjinjie@huawei.com>
 <ZMJc10fKGbvHDltH@smile.fi.intel.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <ZMJc10fKGbvHDltH@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org



On 2023/7/27 20:02, Andy Shevchenko wrote:
> On Thu, Jul 27, 2023 at 07:57:04PM +0800, Ruan Jinjie wrote:
>> There is no need to call the dev_err_probe() function directly to print
>> a custom message when handling an error from platform_get_irq() function as
>> it is going to display an appropriate error message in case of a failure.
> 
> ...
> 
>> @@ -1415,7 +1415,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>  	if (bank->irq <= 0) {
>>  		if (!bank->irq)
>>  			bank->irq = -ENXIO;
>> -		return dev_err_probe(dev, bank->irq, "can't get irq resource\n");
>> +		return bank->irq;
>>  	}
> 
> Actually you may go further here and drop a dead code:
> 
> 	if (bank->irq < 0)
> 		return bank->irq;
> 
> will suffice.

You are right! platform_get_irq() do not return 0, I'll fix the issue in v3.

> 
