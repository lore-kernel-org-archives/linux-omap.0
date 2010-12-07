From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work withCONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 12:59:32 +0100
Message-ID: <AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
	<AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56393 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0LGL7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 06:59:33 -0500
Received: by qyk12 with SMTP id 12so15748706qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 03:59:33 -0800 (PST)
In-Reply-To: <AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

On Tue, Dec 7, 2010 at 11:16 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Tue, Dec 7, 2010 at 6:31 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Dave,
>>> -----Original Message-----
>>> From: linaro-dev-bounces@lists.linaro.org [mailto:linaro-dev-
>>> bounces@lists.linaro.org] On Behalf Of Dave Martin
>>> Sent: Monday, December 06, 2010 11:06 PM
>>> To: linux-arm-kernel@lists.infradead.org
>>> Cc: Tony Lindgren; Dave Martin; linux-omap@vger.kernel.org; linaro-
>>> dev@lists.linaro.org
>>> Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to
>> work
>>> withCONFIG_THUMB2_KERNEL
>>>
>
> [...]
>
>>
>> No need to mention but this patch changes lot of things around
>> power management code. You said " Tested on: omap3 (Beagle xM A2)"
>>
>> What did you test ? Is it just boot test ? For sure just boot
>> test is not enough for this patch and needs to test the PM.
>
> That's a fair point--- yes, I've only tested boot / reboot / shutdown so far.
>
The ASM idle code is being reworked right now, which means the T2
support will need to be reworked on top of the patches. Cf. [1] and
[2].

> If you have any thoughts about how to exercise the power management
> functionality more completely, I'd be happy to have a go...
Cf. [3] for more details on how to exercise the PM on the target. This
wiki page is slightly outdated but the idea is still the same. Note
that only cpuidle is currently supported correctly on l-o master.

[1] http://marc.info/?l=linux-omap&m=129139584919242&w=2
[2] http://marc.info/?l=linux-omap&m=129172034809447&w=2
[3] http://elinux.org/OMAP_Power_Management

>
> Cheers
> ---Dave

Thanks,
Jean

>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
