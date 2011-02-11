From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
Date: Fri, 11 Feb 2011 13:49:03 +0000
Message-ID: <AANLkTi=0ikmWaVSoerb71ZK=_fBETO54nTvYu-hGAPBR@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-6-git-send-email-dave.martin@linaro.org>
	<87d3mzh6vq.fsf@ti.com>
	<87ei7fe8mk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37002 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab1BKNvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 08:51:12 -0500
Received: by eye27 with SMTP id 27so1323126eye.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 05:51:10 -0800 (PST)
In-Reply-To: <87ei7fe8mk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Fri, Feb 11, 2011 at 12:07 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> Dave Martin <dave.martin@linaro.org> writes:
>>
>>> =A0* Use BSYM() to get the correct Thumb branch address
>>> =A0 =A0for adr <Rd>, <label>
>>>
>>> =A0* Fix an out-of-range ADR when building for ARM
>>>
>>> =A0* Correctly call es3_sdrc_fix as Thumb when copied to SRAM.
>>>
>>> =A0* Remove deprecated/undefined PC-relative stores
>>>
>>> =A0* Add the required ENDPROC() directive for each ENTRY().
>>>
>>> =A0* .align before data words
>>>
>>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>>
>> I'm attempting to test this series with OMAP PM, but some changes he=
re
>> don't compile for me.
>>
>> My toolchain is: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50)
>>
>> First, I merged your arm/omap-thumb2+merged branch with my pm branch
>> from git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-oma=
p-pm.git
>
> Sorry for the confusion, this patch should've been in reply to your v=
4
> version, since I merged with your 'arm/omap-thumb2+merged' branch fro=
m
> today.

If you are able to test off mode with CONFIG_THUMB2_KERNEL enabled,
that would be great.

I have some evidence that the resume path may be working in Thumb-2,
but I think I'm being bitten by erratum i583 (I have to disable the
workaround to even attempt to test off mode on Beagle xM)

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
