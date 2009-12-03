From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: u-boot for omap3
Date: Thu, 03 Dec 2009 12:17:56 -0700
Message-ID: <4B180EE4.1040407@mlbassoc.com>
References: <54B31811B83D744D90BF0289EB447D46099619D840@MAIL-MB1.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:60811 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbZLCTRy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 14:17:54 -0500
In-Reply-To: <54B31811B83D744D90BF0289EB447D46099619D840@MAIL-MB1.oerlikon.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>
Cc: "'Pandita, Vikram'" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom <Tom.Rix@windriver.com>

On 12/03/2009 11:57 AM, Weng, Wending wrote:
> Hi,
>
>          In the u-boot for omap3evm I use, cleanup_before_linux(in cpu/omap3/cpu.c or cpu/arm_cortexa8/cpu.c) turns off L2 cache by mistake, it should not. This causes serious performance problem for me.
>
>          The following line "#ifndef CONFIG_L2_OFF" should be "#ifdef CONFIG_L2_OFF".
> #ifndef CONFIG_L2_OFF
>          /* turn off L2 cache */
>          l2cache_disable();
>          /* invalidate L2 cache also */
>          v7_flush_dcache_all(get_device_type());
> #endif

Are you sure?  The version I have re-enables the L2 cache just a
few lines below that:

==================================================================
#ifndef CONFIG_L2_OFF
	/* turn off L2 cache */
	l2_cache_disable();
	/* invalidate L2 cache also */
	v7_flush_dcache_all(get_device_type());
#endif
	i = 0;
	/* mem barrier to sync up things */
	asm("mcr p15, 0, %0, c7, c10, 4": :"r"(i));

#ifndef CONFIG_L2_OFF
	l2_cache_enable();
#endif
==================================================================

n.b. I'm using git://git.denx.de/u-boot.git


>> -----Original Message-----
>> From: Pandita, Vikram [mailto:vikram.pandita@ti.com]
>> Sent: December 3, 2009 1:40 PM
>> To: Weng, Wending; linux-omap@vger.kernel.org; Tom
>> Subject: RE: u-boot for omap3
>
>
>
>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Weng,
>>> Wending
>>> Sent: Thursday, December 03, 2009 12:32 PM
>>> To: linux-omap@vger.kernel.org
>>> Subject: u-boot for omap3
>>>
>>> Hi all,
>>>
>>>         Anybody knows who takes care of u-boot for omap3, I wish to fix a L2 cahe related bug if
>
>> Tom Rix is the Arm u-boot maintainer.
>> Omap3 falls as one of the silicon he maintains.
>
>> In reality, there are always internal/forked versions of the upstream that get used.
>> Like for zoom boards I maintain it at dev.omapzoom.org /bootloader/*
>
>
>>> it's
>>> not done yet.
>>>
>>> Regards
>>> Wending
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
