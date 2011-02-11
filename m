From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
Date: Thu, 10 Feb 2011 16:07:47 -0800
Message-ID: <87ei7fe8mk.fsf@ti.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-6-git-send-email-dave.martin@linaro.org>
	<87d3mzh6vq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38019 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756844Ab1BKAHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 19:07:51 -0500
Received: by pwi7 with SMTP id 7so531445pwi.31
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 16:07:50 -0800 (PST)
In-Reply-To: <87d3mzh6vq.fsf@ti.com> (Kevin Hilman's message of "Thu, 10 Feb
	2011 14:17:13 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

Kevin Hilman <khilman@ti.com> writes:

> Dave Martin <dave.martin@linaro.org> writes:
>
>>  * Use BSYM() to get the correct Thumb branch address
>>    for adr <Rd>, <label>
>>
>>  * Fix an out-of-range ADR when building for ARM
>>
>>  * Correctly call es3_sdrc_fix as Thumb when copied to SRAM.
>>
>>  * Remove deprecated/undefined PC-relative stores
>>
>>  * Add the required ENDPROC() directive for each ENTRY().
>>
>>  * .align before data words
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>
> I'm attempting to test this series with OMAP PM, but some changes here
> don't compile for me.
>
> My toolchain is: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) 
>
> First, I merged your arm/omap-thumb2+merged branch with my pm branch
> from git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Sorry for the confusion, this patch should've been in reply to your v4
version, since I merged with your 'arm/omap-thumb2+merged' branch from
today.

Kevin
