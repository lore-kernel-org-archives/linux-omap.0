From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: linux-omap-pm troubles on Gumstix Overo
Date: Wed, 07 Apr 2010 09:04:14 -0700
Message-ID: <87hbnnfdvl.fsf@deeprootsystems.com>
References: <4BBBF808.80000@gmail.com> <87tyrnfe8c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:51566 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0DGQET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:04:19 -0400
Received: by pzk31 with SMTP id 31so1237478pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 09:04:19 -0700 (PDT)
In-Reply-To: <87tyrnfe8c.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 07 Apr 2010 08\:56\:35 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Peter Tseng <tsenpet09@gmail.com> writes:
>
[...]
>> make ARCH=arm omap3_pm_defconfig
>> make ARCH=arm -j4 uImage
>> CROSS_COMPILE=/opt/arm-2009q3/bin/arm-none-linux-gnueabi-
>>
>> I get these error messages back.
>>
>> arch/arm/mach-omap2/omap44xx-smc.S: Assembler messages:
>> arch/arm/mach-omap2/omap44xx-smc.S:30: Error: missing expression -- `smc'
>> make[1]: *** [arch/arm/mach-omap2/omap44xx-smc.o] Error 1
>> make: *** [arch/arm/mach-omap2] Error 2
>
> Hmm, this one looks like a compiler specific issue.  I too see this
> when switching to CSL 2009q3, but don't see it with 2009q1 or 2008q3

FYI... Fix for this problem has been posted, but not yet included in
linux-omap (or PM branch):

   https://patchwork.kernel.org/patch/90964/

Kevin
