From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 1/2] OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Date: Thu, 18 Mar 2010 07:48:28 -0700
Message-ID: <87ljdpofcz.fsf@deeprootsystems.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com>
	<1268888148-10983-2-git-send-email-pramod.gurav@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F078B5E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55913 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0CROsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 10:48:31 -0400
Received: by pwi5 with SMTP id 5so571726pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 07:48:31 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F078B5E@dbde02.ent.ti.com> (Manjunath Kondaiah G.'s message of "Thu\, 18 Mar 2010 11\:47\:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Gurav , Pramod" <pramod.gurav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Reddy, Teerth" <teerth@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> +#ifdef CONFIG_ARCH_OMAP3
>> +void (*_omap3_sram_delay)(unsigned int);
>> +unsigned int  measure_sram_delay(unsigned int loop)
>> +{
>> +	static struct omap_dm_timer *gpt;
>> +	unsigned long flags, diff = 0, gt_rate, mpurate;
>> +	unsigned int delay_sram, error_gain;
>> +	unsigned int start = 0, end = 0;
>> +
>> +	omap_dm_timer_init();
>> +	gpt = omap_dm_timer_request();
>> +	if (!gpt) {
>
> Request timer API returns NULL on failure. 
> Use   BUG_ON(gpt == NULL);

No.  BUG_ON() will panic the kernel and hang here.  There is no need
to crash the kernel for that.

Current aproach is fine, or if a more verbose warning is desired,
you can use if (WARN_ON(!gpt)) ... and drop the pr_err()

Kevin
