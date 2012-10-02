From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP2+: SmartReflex: fix return value check in sr_dev_init()
Date: Tue, 02 Oct 2012 14:37:22 -0700
Message-ID: <87haqc8sj1.fsf@deeprootsystems.com>
References: <CAPgLHd_jXBNGNh452sGh5OweX+CdwpcVuWHmnfZKaCt4FnsTuA@mail.gmail.com>
	<CAORVsuUcOFKFoOuxZqPJR=WSsTouqBH3EP4Xu82o515ofGbn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:38159 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab2JBVhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Oct 2012 17:37:22 -0400
Received: by dakn41 with SMTP id n41so937216dak.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Oct 2012 14:37:22 -0700 (PDT)
In-Reply-To: <CAORVsuUcOFKFoOuxZqPJR=WSsTouqBH3EP4Xu82o515ofGbn+w@mail.gmail.com>
	(Jean Pihet's message of "Fri, 28 Sep 2012 12:41:35 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, tony@atomide.com, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hello,
>
> On Thu, Sep 27, 2012 at 7:54 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function voltdm_lookup() returns NULL
>> not ERR_PTR(). The IS_ERR() test in the return value check
>> should be replaced with NULL test.
>>
>> dpatch engine is used to auto generate this patch.
>> (https://github.com/weiyj/dpatch)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  arch/arm/mach-omap2/sr_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>> index d033a65..c248b30 100644
>> --- a/arch/arm/mach-omap2/sr_device.c
>> +++ b/arch/arm/mach-omap2/sr_device.c
>> @@ -123,7 +123,7 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
>>         sr_data->senp_mod = 0x1;
>>
>>         sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
>> -       if (IS_ERR(sr_data->voltdm)) {
>> +       if (!sr_data->voltdm) {
>>                 pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
>>                         __func__, sr_dev_attr->sensor_voltdm_name);
>>                 goto exit;
>
> This looks good, so here is the ack:
> Acked-by: Jean Pihet <j-pihet@ti.com>
>

Thanks, queuing this one for v3.7-rc.

Kevin
