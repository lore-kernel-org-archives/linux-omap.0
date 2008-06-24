From: Arun KS <arunks@mistralsolutions.com>
Subject: Re: [Resend] [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 20:20:30 +0530
Message-ID: <486109B6.8020009@mistralsolutions.com>
References: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com> <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com> <dfeb90390806240554v549cf987h20c68685d3082f2b@mail.gmail.com> <4c2f926971f553819251f824d239ca85@felipebalbi.com> <dfeb90390806240625y7c1309fal44dce5ce3f7f62c1@mail.gmail.com> <48e8658f507de35e2fab060ca2a9db43@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from blrmail.mistralsolutions.com ([220.227.112.130]:4889 "EHLO
	Mistralsoftware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753569AbYFXOu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 10:50:26 -0400
Received: from localhost.localdomain by mistralsolutions.com (MDaemon PRO v9.6.4)
	with ESMTP id 36-md50000013861.msg
	for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 20:20:43 +0530
In-Reply-To: <48e8658f507de35e2fab060ca2a9db43@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Hi Felipe,

Thanks for your comments. I will incorporate those changes
and will send back.

Regards
Arun
Felipe Balbi wrote:
> Hi,
>
> On Tue, 24 Jun 2008 18:55:26 +0530, "Arun KS" <getarunks@gmail.com> wrote:
>
>   
>> +static inline void __init omap2evm_init_smc911x(void)
>> +{
>> +       int gpio = OMAP2EVM_ETHR_GPIO_IRQ;
>> +       int ret;
>> +
>> +       ret = gpio_request(gpio, "smc911x IRQ");
>> +       if (ret >= 0)
>> +               gpio_direction_input(gpio);
>> +       else
>> +               printk(KERN_ERR "Failed to request GPIO for smc911x
>>     
>
> this would look better like this:
>
>           if (ret < 0) {
>              printk(KERN_ERR "Failed to request GPIO %d for smc911x IRQ\n",
> gpio);
>              return;
>           }
>
>           gpio_direction_input(gpio);
>
>
> besides this, it looks fine :-)
>
>   


Please do not print this email unless it is absolutely necessary. Spread environmental awareness.

-------------------------------------------------------DISCLAIMER------------------------------------------------------
The information transmitted herewith is confidential and proprietary information intended only for use by the individual or entity to which it is addressed. If the reader of this message is not the intended recipient, you are hereby notified that any review, retransmission, dissemination, distribution, copying or other use of, or taking of any action in reliance upon this information is strictly prohibited. If you have received this communication in error, please contact the sender and delete the material from your computer.
--------------------------------------------------------------------------------------------------------------------------------



