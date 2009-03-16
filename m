From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Mon, 16 Mar 2009 16:44:46 +0200
Message-ID: <49BE65DE.90205@nokia.com>
References: <200903110518.34945.david-b@pacbell.net> <200903110524.16644.david-b@pacbell.net> <49B8CE89.2000608@nokia.com> <200903120222.02972.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19592 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZCPOpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 10:45:18 -0400
In-Reply-To: <200903120222.02972.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

ext David Brownell wrote:
> On Thursday 12 March 2009, Adrian Hunter wrote:
>>> +               }
>>>         } else {
>>> -               ret = twl_mmc_set_voltage(c, 0);
>>> +               if (c->vcc_aux)
>>> +                       ret = regulator_enable(c->vcc_aux);
>> Sorry for slow reply.  Shouldn't that be regulator_disable() ?
> 
> Indeed it should be.  In fact I think this probably explains
> the failure I saw the other day, trying to go from 3.3V on one
> chip down to 1.8V, where it failed (reasons unknown so far)
> but the cleanup left vcc_aux active.  Got patch?  :)
> 
> I meant this one to be a patch/RFC ... so you could see how I
> thought those issues should be addressed, vs the less general
> patches you sent the other day.  Actually merging this one
> runs into that annoying regulator framework isssue on most
> systems.
> 
> - Dave
> 
> 
> 


I have another problem:


arch/arm/mach-omap2/built-in.o: In function `twl_mmc23_set_power':
/home/ahunter/git/lo-on-rover/arch/arm/mach-omap2/mmc-twl4030.c:282: undefined reference to `mmc_regulator_set_ocr'
/home/ahunter/git/lo-on-rover/arch/arm/mach-omap2/mmc-twl4030.c:293: undefined reference to `mmc_regulator_set_ocr'
arch/arm/mach-omap2/built-in.o: In function `twl_mmc1_set_power':
/home/ahunter/git/lo-on-rover/arch/arm/mach-omap2/mmc-twl4030.c:219: undefined reference to `mmc_regulator_set_ocr'
/home/ahunter/git/lo-on-rover/arch/arm/mach-omap2/mmc-twl4030.c:235: undefined reference to `mmc_regulator_set_ocr'
arch/arm/mach-omap2/built-in.o: In function `twl_mmc_late_init':
/home/ahunter/git/lo-on-rover/arch/arm/mach-omap2/mmc-twl4030.c:128: undefined reference to `mmc_regulator_get_ocrmask'
make: *** [.tmp_vmlinux1] Error 1


The linker is not happy with built-in code trying to call functions in a module directly.

