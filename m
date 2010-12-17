From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc
 handling
Date: Fri, 17 Dec 2010 17:28:43 +0100
Message-ID: <4D0B8FBB.5000906@ti.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>	<AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com> <AANLkTinPpj5Po4yPjc8hG1Kjs2wM3b62-hRGMY+U_UjN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48583 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab0LQQ27 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 11:28:59 -0500
In-Reply-To: <AANLkTinPpj5Po4yPjc8hG1Kjs2wM3b62-hRGMY+U_UjN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Omar,

On 12/16/2010 3:11 PM, Ramirez Luna, Omar wrote:
> Hi,
>
> On Thu, Dec 16, 2010 at 2:28 AM, Varadarajan, Charulatha<charu@ti.com>  wrote:
>> On Thu, Dec 16, 2010 at 12:17, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>>> Use runtime pm APIs to enable/disable mailbox clocks and
>>> to configure SYSC register.
>>>
>>> Based on the patch sent by Felipe Contreras:
>>> https://patchwork.kernel.org/patch/101662/
>>>
>>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/mailbox.c |   27 +++++----------------------
>>>   1 files changed, 5 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>>> index 40ddeca..f5f72ba 100644
>>> --- a/arch/arm/mach-omap2/mailbox.c
>>> +++ b/arch/arm/mach-omap2/mailbox.c
>>> @@ -14,6 +14,7 @@
>>>   #include<linux/err.h>
>>>   #include<linux/platform_device.h>
>>>   #include<linux/io.h>
>>> +#include<linux/pm_runtime.h>
>>>   #include<plat/mailbox.h>
>>>   #include<mach/irqs.h>
>>>
>>> @@ -34,12 +35,8 @@
>>>   #define MAILBOX_IRQ_NOTFULL(m)         (1<<  (2 * (m) + 1))
>>>
>>>   /* SYSCONFIG: register bit definition */
>>> -#define AUTOIDLE       (1<<  0)
>>>   #define SOFTRESET      (1<<  1)
>>> -#define SMARTIDLE      (2<<  3)
>>>   #define OMAP4_SOFTRESET        (1<<  0)
>>> -#define OMAP4_NOIDLE   (1<<  2)
>>> -#define OMAP4_SMARTIDLE        (2<<  2)
>>>
>>>   /* SYSSTATUS: register bit definition */
>>>   #define RESETDONE      (1<<  0)
>>
>> Is this still required?
>
> Yes, mailbox uses the softreset every time it is requested (and that
> it has no current users at the time), it does it before configuring
> sysc, as opossed to what this patch does (where clk is enabled, sysc
> configured, and then softreset), but no harm was seen with this
> sequence.
>
> AFAIK, enabling/disabling hwmod handles prm reset but not softreset
> bit, that's why I left it there.

In fact both are handled now. hardreset is managed for IVA, DSP and IPU, 
and softreset for most the other IPs.
The only slight difference, is that softreset for the moment is just 
done once at setup time. The idea being that we do not know the state 
the bootloader configured IP, so we reset it by default.

I thought I did it for every enable from disable state, but in fact this 
is not the case, because AFAIK there is not use-case for that yet.

Why do you have to softreset the mailbox? That sounds like some old HW 
bugs from the past that we solve using the softreset.

Could you elaborate on that use case? If there is a need, I'd rather 
update the hwmod core than letting you playing directly with the 
sysconfig. At least we can expose the API we did for that purpose but 
didn't merge due to the lack of any strong need.

Regards,
Benoit
