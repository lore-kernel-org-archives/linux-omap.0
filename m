From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 11 Mar 2011 17:18:12 +0100
Message-ID: <4D7A4B44.2030801@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>	 <1299764643.2017.177.camel@deskari>  <4D78E3F5.2090600@openelec.tv>	 <1299827578.2567.1.camel@deskari>  <4D79E0A0.9040900@openelec.tv> <1299849774.2479.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail01.solnet.ch ([212.101.4.135]:64684 "EHLO mail01.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab1CKQSO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 11:18:14 -0500
In-Reply-To: <1299849774.2479.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 11.03.2011 14:22, schrieb Tomi Valkeinen:
> On Fri, 2011-03-11 at 02:43 -0600, Stephan Raue wrote:
>> Am 11.03.2011 08:12, schrieb Tomi Valkeinen:
>>> On Thu, 2011-03-10 at 08:45 -0600, Stephan Raue wrote:
>>>> Hi,
>>>>
>>>> if i try this patch series the boot stops after (seeing via serial console):
>>>>
>>>>      Starting kernel ...
>>>>
>>>>      Uncompressing Linux... done, booting the kernel.
>>>>
>>>> without this patch series i can see the boot to th OS. I am using this
>>>> patches on top of
>>>>
>>>>      http://gitorious.org/linux-omap-dss2/linux/commits/master
>>>>
>>>> Do i anything wrong or do i use a wrong git repo (the patches apply
>>>> cleanly)? Her my kernel config: http://fpaste.org/9Esw/
>>> Hmm, I cannot even compile the kernel with that config:
>>>
>>>     CC      arch/arm/mach-omap2/io.o
>>> In file included from arch/arm/mm/init.c:27:0:
>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h:104:3: error: implicit declaration of function 'release_pages'
>>> In file included from arch/arm/mm/init.c:27:0:
>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
>>> /home/tomba/work/linux/arch/arm/include/asm/tlb.h:168:3: error: implicit declaration of function 'page_cache_release'
>>> make[1]: *** [arch/arm/mm/init.o] Error 1
>>> make: *** [arch/arm/mm] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>
>>>    Tomi
>>>
>> please enable swap support or try:
>> http://ftp.arm.linux.org.uk/git/?p=linux-2.6-arm.git;a=commit;h=97594b0f35c0708cb9551c070b9693a52ec24ebf
>> which is fixed in 2.6.38-rc8
> Ok. So you didn't have just my master branch and the HDMI patch set? I
> see that the config you gave is for rc8, and mine is rc7, so I guess you
> also merged rc8 into your tree?
>
>   Tomi
>
yes, you are right, i have tested this with different kernel configs and 
both rc7 and rc8 with the same results.

Stephan
