From: Stefan Roese <stefan.roese@gmail.com>
Subject: Re: AM335x board with disabled RTC crashes
Date: Thu, 21 Nov 2013 05:28:56 +0100
Message-ID: <528D8C08.1020201@gmail.com>
References: <528CC4CB.4000609@gmail.com> <528CC5C3.2010905@ti.com> <528CDAF6.7070905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:12794 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab3KUE27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 23:28:59 -0500
In-Reply-To: <528CDAF6.7070905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 11/20/2013 04:53 PM, Nishanth Menon wrote:
> Paul, Tony, Rajendra,
> 
> On 11/20/2013 08:22 AM, Nishanth Menon wrote:
>> On 11/20/2013 08:18 AM, Stefan Roese wrote:
>>> Hi!
>>>
>>> I'm currently working on a custom AM335x based board, where the SoC
>>> RTC is disabled. As described in this page in the "RTC feature disabled"
>>> column:
>>>
>>> http://processors.wiki.ti.com/index.php/AM335x_Schematic_Checklist#RTC
>>>
>>> On this board the registers of the RTC are not accessible. But the OMAP
>>> hwmod code tries to read the sysc register unconditionally from the RTC.
>>> And this leads to this crash (using v3.12):
>>>
>>> ...
>>> [    0.179491] CPU: Testing write buffer coherency: ok
>>> [    0.187702] Setting up static identity map for 0xc04dfa90 - 0xc04dfb00
>>> [    0.204665] devtmpfs: initialized
>>> [    0.219513] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
>>> [    0.237462] *** _update_sysc_cache (263): name=emif
>>> [    0.246247] omap_hwmod: debugss: _wait_target_disable failed
>>> [    0.252290] *** _update_sysc_cache (263): name=uart1
>>> [    0.257668] *** _update_sysc_cache (263): name=rtc
>>> [    0.262885] Unhandled fault: external abort on non-linefetch (0x1028) at 0xf9e3e078
>>> [    0.270893] Internal error: : 1028 [#1] ARM
>>> [    0.275302] Modules linked in:
>>> [    0.278572] CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0-dirty #21
>>> [    0.285222] task: c7047340 ti: c7048000 task.ti: c7048000
>>> [    0.290909] PC is at _update_sysc_cache+0x44/0xb0
>>> [    0.295861] LR is at _update_sysc_cache+0x1c/0xb0
>>> ...
>>>
>>> Disabling the RTC in the DT doesn't help (of course). So what's the
>>> recommended way to disable this hwmod access to the RTC registers?
>>
>>
>> http://www.spinics.net/lists/linux-omap/msg98207.html
>> might help you - we had thought it might get queued for 3.12, but it
>> was queued for 3.13 instead..

Unfortunately this patch doesn't fix the crash for me (yet). With this
patch applied and the RTC DT node completely removed from am33xx.dtsi it
works. But only disabling it (via status = "disabled" in the board dts
file) doesn't work.

I'll dig a bit deeper today...

Thanks,
Stefan

