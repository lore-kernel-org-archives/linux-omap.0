From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2] OMAP2+: disable idle early in the suspend sequence
Date: Thu, 9 Dec 2010 18:41:50 +0100
Message-ID: <AANLkTi=U5H6OO+mLHkCev+0F7aFiTGCvRn3bHh34yB=R@mail.gmail.com>
References: <1291799364-23154-1-git-send-email-jean.pihet@newoldbits.com>
	<87ei9rg98d.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44424 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab0LIRlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:41:52 -0500
Received: by vws16 with SMTP id 16so1782002vws.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 09:41:51 -0800 (PST)
In-Reply-To: <87ei9rg98d.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Kevin,

On Thu, Dec 9, 2010 at 12:01 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Some bad interaction between the idle and the suspend paths has been
>> noticed: the idle code is called during the suspend enter and exit
>> sequences. This could cause corruption or lock-up of resources.
>>
>> The solution is to move the calls to disable_hlt at the very beginni=
ng
>> of the suspend sequence (ex. in omap3_pm_begin instead of
>> omap3_pm_prepare), and the call to enable_hlt at the very end of
>> the suspend sequence (ex. in omap3_pm_end instead of omap3_pm_finish=
).
>
> In an earlier version, I thought we agreed to just remove the empty
> prepare/finish calls. =A0Can you do that?
>
> Also, can you base this on top of my recently posted patch:
>
> [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire during su=
spend
>
> since it touches some of the same code for pm24xx.c

Ok sent as '[PATCH v3] OMAP2+: disable idle early in the suspend sequen=
ce'

Thanks,
Jean

>
> Thanks,
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
