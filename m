From: "Alberto J. Perez" <aperez@disca.upv.es>
Subject: Re: Linux omap blocked on boot
Date: Wed, 07 Oct 2009 20:13:53 +0200
Message-ID: <4ACCDA61.8020504@disca.upv.es>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>	<87ljjnl2ma.fsf@deeprootsystems.com> <4ACCB4EA.1020904@disca.upv.es> <8763arktoa.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from marfik.cc.upv.es ([158.42.249.21]:45708 "EHLO marfik.cc.upv.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756579AbZJGSOa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Oct 2009 14:14:30 -0400
In-Reply-To: <8763arktoa.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, gadiyar@ti.com

Following your instructions I get the pm kernel working!

Thanks a lot Kevin & Anand.

Alberto.

Kevin Hilman wrote:
> "Alberto J. Perez" <aperez@disca.upv.es> writes:
>
>   
>> Hi all!
>>
>> I'm recompiling the linux-omap-2.6/origin/pm branch and every time I
>> get the boot process stalled after kernel image decompression.
>>
>> - With the linux-omap-2.6/origin/2.6.30 branch I have no problems.
>> - I've tried with 2008q3-72 & 2009q1-203 arm compilers.
>>
>> I attach the .config I used.
>>
>>     
>
> It looks like you are trying this for Overo, right.  
>
> So we're on the same page, please pull the current PM branch as I
> pushed a new one yesterday.  Then, use omap3_pm_defconfig with the
> only change being to change the debug UART from UART1 to UART3.  This
> is how I test on Overo and booting works fine.
>
> Kevin
>
>   

