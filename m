From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
Date: Thu, 29 Jul 2010 15:23:52 +0200
Message-ID: <4C5180E8.3060105@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com> <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A01E@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A1B6@dbde02.ent.ti.com> <8F7AF80515AF0D4D93307E594F3CB40E4D2F3F83@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34884 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755792Ab0G2NX6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 09:23:58 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4D2F3F83@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Marathe, Yogesh" <yogesh_marathe@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Que, Simon" <sque@ti.com>

On 7/29/2010 3:14 PM, Kanigeri, Hari wrote:
> Yogesh,
>
> Nice to see your email.
>
>>>> +/* Release a spinlock */
>>>> +int hwspinlock_unlock(struct hwspinlock *handle)
>>>> +{
>>>> +     if (WARN_ON(handle == NULL))
>>>> +             return -EINVAL;
>>>> +
>>>> +     /* Release it by writing 0 to it */
>>>> +     writel(0, handle->lock_reg);
>>
>> [[Yogesh Marathe]] Releasing the spinlock without knowing who owns it is
>> risky. There should be a check for ownership and if authenticated user has
>> called this api  only then it should be released otherwise permission
>> denied error should be returned.
>
> -- I think if there is another Kernel client that is trying to release that is not owned by it then that Kernel client itself is buggy and needs to be fixed. Please share your thoughts on how we can ensure that we can add some protection.

Yes, I think so as well. The hwspinlock itself was done to be simple. 
The HW is not even checking that the processor that is taking the 
spinlock is the one that will release it.

This is maybe not the ideal and safe way to do that, but I'm not sure 
that we need to add some more complexity than needed for such a basic IP.

BTW, is a Linux kernel spinlock taking care of ownership?

Benoit

>
>>
>>>> +
>>>> +     pm_runtime_put(&handle->pdev->dev);
>>>> +
>>>> +     return 0;
>
> Thank you,
> Best regards,
> Hari

