From: "Weng, Wending" <WWeng@rheinmetall.ca>
Subject: RE: u-boot for omap3
Date: Thu, 3 Dec 2009 14:43:57 -0500
Message-ID: <54B31811B83D744D90BF0289EB447D46099619D841@MAIL-MB1.oerlikon.ca>
References: <4B180EE4.1040407@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.rheinmetall.ca ([207.61.105.111]:39053 "EHLO
	MAIL-ET.oerlikon.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756064AbZLCTnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 14:43:53 -0500
In-Reply-To: <4B180EE4.1040407@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Gary Thomas' <gary@mlbassoc.com>
Cc: "'Pandita, Vikram'" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom <Tom.Rix@windriver.com>

Hi,

        You are right, I checked u-boot from BSP 2.1.1.7 and BSP 2.1.3.11. Is there any reason to do thing in this way?
I use the u-boot from BSP 1.0.0.

Regards
Wending

>-----Original Message-----
>From: Gary Thomas [mailto:gary@mlbassoc.com]
>Sent: December 3, 2009 2:18 PM
>To: Weng, Wending
>Cc: 'Pandita, Vikram'; linux-omap@vger.kernel.org; Tom
>Subject: Re: u-boot for omap3
>
>
>>On 12/03/2009 11:57 AM, Weng, Wending wrote:
>> Hi,
>>
>>          In the u-boot for omap3evm I use, cleanup_before_linux(in cpu/omap3/cpu.c or cpu/arm_cortexa8/cpu.c) turns off L2 >> cache by mistake, it should not. This causes serious performance problem for me.
>>
>>          The following line "#ifndef CONFIG_L2_OFF" should be "#ifdef CONFIG_L2_OFF".
>> #ifndef CONFIG_L2_OFF
>>          /* turn off L2 cache */
>>          l2cache_disable();
>>          /* invalidate L2 cache also */
>>          v7_flush_dcache_all(get_device_type());
>> #endif

>Are you sure?  The version I have re-enables the L2 cache just a
>few lines below that:

