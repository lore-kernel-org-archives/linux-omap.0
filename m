From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri, 4 Feb 2011 11:02:48 +0000
Message-ID: <AANLkTi=sPeQPfcGzrLSB=9-V805y6pnU4gA5QgqMSwWe@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<36192288611a2912eca9abc99a4353ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61082 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1BDLCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 06:02:50 -0500
Received: by ewy5 with SMTP id 5so1169124ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 03:02:49 -0800 (PST)
In-Reply-To: <36192288611a2912eca9abc99a4353ff@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Fri, Feb 4, 2011 at 10:45 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Dave,
>> -----Original Message-----
>> From: Dave Martin [mailto:dave.martin@linaro.org]
>> Sent: Thursday, February 03, 2011 11:33 PM
>> To: linux-arm-kernel@lists.infradead.org
>> Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
>> linux-omap@vger.kernel.org; Nicolas Pitre
>> Subject: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
>>
>> This set of patches, along with some other patches under
>> discussion on alkml, should enable omap3 and omap4 kernels to be
>> built with CONFIG_THUMB2_KERNEL.
>>
>> This patch set builds on recent cleanup done by the omap
>> maintainers.
>>
>> It is also more aggressive than my last post: all affected
>> low-level code is now built in Thumb-2. =A0At least some of this
>> code definitely works, but whether the Secure firmware can talk
>> to Thumb-2 code properly is unproven:
>> in particular, I could use some help/advice from the omap
>> community for validating that the low-level power management
>> interactions actually work with this patch set.
>>
>> I've done simple "does it boot?" testing by building a single
>> kernel with CONFIG_SMP_ON_UP and CONFIG_THUMB2_KERNEL enabled
>> which works on Beagle xM A2 and Panda A1.
>
> I have boot tested this series on OMAP3430 and OMAP4430. Also
> tested the RETENTION and OFF mode in suspend on OMAP3.

Which tree did you use to test this?  It didn't seem to work for me --
sometimes the system wouldn't suspend, complaining about USB suspend
errors; and other times I couldn't bring it out of suspend (by poking
a USB input device).

I might be doing something wrong...

> I couldn't test the DVFS because it isn't in mainline yet
> but the changes doesn't looks to break anything.
>
> So if you like, you can add
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>

Thanks, that's great.

If there some other tree with DVFS working which I could try?  Even if
these patches don't apply, I may be able to test whether the changes
should work.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
