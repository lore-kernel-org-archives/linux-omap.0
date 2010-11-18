From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] OMAP3: clean up ASM idle code
Date: Thu, 18 Nov 2010 19:19:09 +0100
Message-ID: <AANLkTimBFpOJ4R0S-NGdm25C2X07KZXkrhvuZonD_N+V@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
	<1290091906-32539-3-git-send-email-j-pihet@ti.com>
	<20101118174118.GD9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52618 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759980Ab0KRSTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 13:19:10 -0500
Received: by vws13 with SMTP id 13so1880240vws.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 10:19:09 -0800 (PST)
In-Reply-To: <20101118174118.GD9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>

On Thu, Nov 18, 2010 at 6:41 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Jean Pihet <jean.pihet@newoldbits.com> [101118 06:43]:
>> From: Vishwanath BS <vishwanath.bs@ti.com>
>>
>> Clean up of the ASM code:
>> - reworked and simplified the execution paths, for better
>> =A0 =A0readability and to avoid duplication of code,
>> - reworked the comments for better readability,
>> - reworked the code formating and alignment,
>> - added comments for the i443 errata workarounds,
>> - replaced the cache flush code by a call to the kernel
>> =A0 =A0common code for ARMv7 (v7_flush_kern_cache_all), which is
>> =A0 =A0better maintained and so more mature,
>> - clean up of non used symbols.
>
> This should be broken into several patches.
>
> The first patch should be to use v7_flush_kern_cache_all
> instead of the buggy older copy of that in sleep34xx.S.
Agree

>
> After that, any readability and formatting patches should
> contain no functional changes.

Will rework and repost once something goes out of the on-going discussi=
ons.

>
> Regards,
>
> Tony
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
