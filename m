From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/2] hwspinlock/omap: enable module before reading SYSSTATUS
 register
Date: Thu, 24 Jul 2014 10:13:37 -0500
Message-ID: <53D122A1.4040204@ti.com>
References: <1404342060-2919-1-git-send-email-s-anna@ti.com> <1404342060-2919-2-git-send-email-s-anna@ti.com> <CAK=Wgba3OOgZG_smj5=raE+ZXZ-F0ksn4pcGeDc1JDE34Q-wFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184AbaGXPOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2014 11:14:39 -0400
In-Reply-To: <CAK=Wgba3OOgZG_smj5=raE+ZXZ-F0ksn4pcGeDc1JDE34Q-wFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Ohad,

On 07/24/2014 08:45 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, Jul 3, 2014 at 2:00 AM, Suman Anna <s-anna@ti.com> wrote:
>> The number of hwspinlocks are determined based on the value read
>> from the IP block's SYSSTATUS register. However, the module may
>> not be enabled and clocked, and the read may result in a bus error.
>>
>> This particular issue is seen rather easily on AM33XX, since the
>> module wakeup is software controlled, and it is disabled out of
>> reset. Make sure the module is enabled and clocked before reading
>> the SYSSTATUS register.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> ...
>> +       /*
>> +        * runtime PM will make sure the clock of this module is
>> +        * enabled again iff at least one lock is requested
>> +        */
>> +       ret = pm_runtime_put_sync(&pdev->dev);
> 
> Is there a specific reason for using the put_sync variant here? If
> not, let's just use the regular put().

There was no particular reason, you can change it.

> 
> Let me know, and I can do the change while applying these two patches.

Sure, thanks.

regards
Suman
