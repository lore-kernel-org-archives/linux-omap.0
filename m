From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC 2/2] OMAP: PM: implement context loss count APIs
Date: Fri, 10 Dec 2010 16:43:32 -0800
Message-ID: <87zksd5ebv.fsf@deeprootsystems.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com>
	<1291939712-25487-2-git-send-email-khilman@deeprootsystems.com>
	<44f6fc2f0c975af7273975385567acd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:45700 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab0LKAnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 19:43:37 -0500
Received: by gwb20 with SMTP id 20so3582436gwb.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Dec 2010 16:43:36 -0800 (PST)
In-Reply-To: <44f6fc2f0c975af7273975385567acd2@mail.gmail.com> (Vishwanath
	Sripathy's message of "Fri, 10 Dec 2010 16:58:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

> Kevin,
[...]

>> @@ -288,20 +290,19 @@ unsigned long omap_pm_cpu_get_freq(void)
>>
>>  int omap_pm_get_dev_context_loss_count(struct device *dev)
>>  {
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	int count;
>> +
>>  	if (!dev) {
>>  		WARN_ON(1);
>>  		return -EINVAL;
>>  	};
>>
>> -	pr_debug("OMAP PM: returning context loss count for dev %s\n",
>> -		 dev_name(dev));
>> +	count = omap_device_get_context_loss_count(pdev);
>> +	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
>> +		 dev_name(dev), count);
>
> Shouldn't this implementation be part of omap-pm.c where all the OMAP PM
> functions are to be implemented? 

Where is omap-pm.c?

Kevin

