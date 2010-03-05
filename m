From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/16] OMAP3: PM: Configurations for Smartreflex Class 2 and Smartreflex Class 3
Date: Fri, 05 Mar 2010 11:20:25 -0800
Message-ID: <87635a1sp2.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
	<1267003757-22456-8-git-send-email-thara@ti.com>
	<1267003757-22456-9-git-send-email-thara@ti.com>
	<1267003757-22456-10-git-send-email-thara@ti.com>
	<1267003757-22456-11-git-send-email-thara@ti.com>
	<1267003757-22456-12-git-send-email-thara@ti.com>
	<87tysyqlyk.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44903 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0CETU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 14:20:28 -0500
Received: by pwj8 with SMTP id 8so2572226pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 11:20:27 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2B3@dbde02.ent.ti.com> (Thara Gopinath's message of "Fri\, 5 Mar 2010 20\:42\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>>  /* PM Debug Fs enteries to enable disable smartreflex.*/
>>>> @@ -448,6 +551,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>>>>     if (odev->hwmods[0]->mpu_irqs)
>>>>             sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;
>>>>     sr_set_clk_length(sr_info);
>>>> +   sr_set_regfields(sr_info);
>>>>
>>>>     /* Create the debug fs enteries */
>>>>     sprintf(name, "sr%d_autocomp", sr_info->srid);
>>>> @@ -456,8 +560,29 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>>>>
>>>>     odev->hwmods[0]->dev_attr = sr_info;
>>>>     list_add(&sr_info->node, &sr_list);
>>>> -   pr_info("SmartReflex driver initialized\n");
>>>>
>>>> +   /*
>>>> +    * Register interrrupt handler if smartreflex class driver is already
>>>> +    * registered and has requested for interrupts. This will be attempted
>>>> +    * in the class driver register again if it does not happen here.
>>>> +    */
>>>
>>>Why the duplicate attempts to request_irq()?  Seems like it's only needed
>>>in the register_class hook above.
>
> Duplicate attempt is so that it does not matter whether the class driver gets registered before the smartreflex driver gets registered. So if smartreflex driver gets registered first the request_irq will happen only when class driver gets registered. On the other hand if class driver gets registered first then the request_irq will happen from here. The thing to notice is that there is only a duplicate attempt. Actual double registrations does not happen.

OK, thanks for the clarification.

Then, the two blocks of code that reqest_irq + init_enable should be
combined into a subroutine (with comment) called from both places.
This will help avoid the confusion I had and increase readability.

Kevin

