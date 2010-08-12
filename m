From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Thu, 12 Aug 2010 07:11:21 -0700
Message-ID: <87eie3vs3a.fsf@deeprootsystems.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47986 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693Ab0HLOLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:11:25 -0400
Received: by pxi10 with SMTP id 10so441743pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:11:25 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com>
	(Partha Basak's message of "Tue, 10 Aug 2010 20:49:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

>> +/* Attempt to acquire a spinlock once */
>> +int hwspinlock_trylock(struct hwspinlock *handle)
>> +{
>> +       int retval = 0;
>> +
>> +       if (WARN_ON(handle == NULL))
>> +               return -EINVAL;
>> +
>> +       if (WARN_ON(in_irq()))
>> +               return -EPERM;
>> +
>> +       if (pm_runtime_get(&handle->pdev->dev) < 0)
>> +               return -ENODEV;
>> +
>> +       /* Attempt to acquire the lock by reading from it */
>> +       retval = readl(handle->lock_reg);
>> +
>> +       if (retval == HWSPINLOCK_BUSY)
>> +               pm_runtime_put(&handle->pdev->dev);
>
> Any reason for using pm_runtime_put instead of pm_runtime_put_sync?
>
> Using pm_runtime_gett_sync & pm_runtime_put_sync have been recommended
> by Kevin Hilman.

err, not exacly. 

I recommend use of the runtime PM API.  Driver writers can decide
whether they want to use the _sync() version of the API (which has
immediate side effect) or the normal version which may have delayed side
effect.

Kevin





