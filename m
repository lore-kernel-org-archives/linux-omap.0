From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Tue, 28 Sep 2010 12:17:36 -0700
Message-ID: <87tyl9d6en.fsf@deeprootsystems.com>
References: <1285318494-22092-1-git-send-email-silesh@ti.com>
	<87pqw3ji5i.fsf@deeprootsystems.com>
	<AANLkTikWWyfgUOYyXud0D0vpMwAn2xxUKM=dNPoYsCK0@mail.gmail.com>
	<AANLkTimT0bfNjBThHj8bPAZ+ybfV=PFJkj09AUL0M20g@mail.gmail.com>
	<AANLkTi=kajdYN9rbdjH_9q6E5RLuy_oj-4Xsk-X6sFRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52742 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0I1TRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 15:17:38 -0400
Received: by pwi1 with SMTP id 1so8843pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 12:17:38 -0700 (PDT)
In-Reply-To: <AANLkTi=kajdYN9rbdjH_9q6E5RLuy_oj-4Xsk-X6sFRg@mail.gmail.com>
	(Silesh C. V.'s message of "Mon, 27 Sep 2010 14:18:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silesh C V <saileshcv@gmail.com>
Cc: Govindraj <govindraj.ti@gmail.com>, linux-omap@vger.kernel.org

Silesh C V <saileshcv@gmail.com> writes:

> On Mon, Sep 27, 2010 at 1:00 PM, Govindraj <govindraj.ti@gmail.com> w=
rote:
>> On Mon, Sep 27, 2010 at 11:49 AM, Silesh C V <silesh@ti.com> wrote:
>>> On Fri, Sep 24, 2010 at 8:36 PM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> Silesh C V <silesh@ti.com> writes:
>>>>
>>>>> Fix conditional compilation.
>>>>
>>>> What excatly was the compile error? =A0and with which compiler?
>>>
>>> There is no compiler error.But what we need after an #elif is a
>>> conditional expression.
>>> The correct usage is #elif defined(CONFIG_XXX) rather than #elif CO=
NFIG_XXX.
>>>
>>> Further, if the kernel is configured for a non-omap3 arch (eg.OMAP4=
),
>>> you get a compiler warning:
>>> arch/arm/plat-omap/cpu-omap.c:47:7: warning: "CONFIG_ARCH_OMAP3" is=
 not defined
>>> which goes away with this patch.
>>>
>>
>> Silesh,
>>
>> which defconfig are you using with multi omap-build defconfig(omap3_=
defconfig)
>>
>> CONFIG_ARCH_OMAP3 will be enabled. So this compilation error will no=
t occur.
>>
>> ---
>> Regards,
>> Govindraj.R
>>
>>
>
> As I said before there is no compilation error. But what we have to
> check for is whether CONFIG_ARCH_OMAP3 is defined or not.
> Not for the value of CONFIG_ARCH_OMAP3. We have to check for value of
> defined (CONFIG_ARCH_OMAP3). Otherwise compiler searches for the valu=
e
> of the macro and hence the warning(comes with a omap4 config).See how
> #elif + CONFIG_XXX is used elsewhere in kernel.

I see what you're saying now.  The current #elif clause will *always* b=
e
true.

You'll notice that all of this confusion would not have happened if the
original changelog described the problem in detail, showing that that
#elif clause will always be true, and especially not calling it a
compliation fix.

Please re-post with a better changelog and I will incoporate into the
pm-cpufreq sub-branch of the PM branch.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
