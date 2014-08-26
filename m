From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v7 RESEND] ARM: omap: edma: add suspend suspend/resume
 hooks
Date: Tue, 26 Aug 2014 10:46:56 +0200
Message-ID: <53FC4980.1070606@zonque.org>
References: <1408693562-18068-1-git-send-email-d-gerlach@ti.com> <53FC2AD4.4070400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:50956 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932362AbaHZIq6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2014 04:46:58 -0400
In-Reply-To: <53FC2AD4.4070400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Hi,

On 08/26/2014 08:36 AM, Sekhar Nori wrote:
> On Friday 22 August 2014 01:16 PM, Dave Gerlach wrote:

Thanks for pushing that forward!

>> +static int edma_pm_suspend(struct device *dev)
>> +{
>> +	int j, r;
>> +
>> +	r = pm_runtime_get_sync(dev);
>> +	if (r < 0) {
>> +		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
>> +		return r;
>> +	}
> 
> The driver currently does a pm_runtime_get_sync() once during probe. And
> does not do a put(). So this should actually be not required. In fact
> looks like this additional get() call will prevent the clock from
> getting disabled which is probably not what you intend.

Well, the pm runtime is put again ...

>> +
>> +	for (j = 0; j < arch_num_cc; j++) {
>> +		struct edma *ecc = edma_cc[j];
>> +
>> +		disable_irq(ecc->irq_res_start);
>> +		disable_irq(ecc->irq_res_end);
> 
> Do we really need to disable these irqs?
> 
>> +	}
>> +
>> +	pm_runtime_put_sync(dev);

... here, so it's in sync and should be fine.

I was also sure than when I wrote the code, disabling the interrupts
during suspend was necessary, and even the only thing that has to be
done at suspend time. Now that I address this again, my tests show that
in can in fact be omitted.

So I'll send a v9 now that has no edma_pm_suspend() at all anymore.

>> +static const struct dev_pm_ops edma_pm_ops = {
>> +	.suspend_late	= edma_pm_suspend,
>> +	.resume_early	= edma_pm_resume,
>> +};
> 
> You can use SET_LATE_SYSTEM_SLEEP_PM_OPS() as some other DMA drivers are
> doing too.

Sure, why not.


Thanks,
Daniel

