From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Tracking N770 breakage
Date: Sat, 23 May 2009 12:11:08 +0100
Message-ID: <20090523121108.14776dli2aeyapkw@lidskialf.net>
References: <20090516140653.10104565olvxrwjk@lidskialf.net>
	<20090517031715.92503qopn0joudhc@lidskialf.net>
	<20090519231500.GM19742@atomide.com>
	<20090520061544.560957looc5zgav4@lidskialf.net>
	<20090520151907.GC8308@atomide.com>
	<20090522184720.10616mt8vpjglk3k@lidskialf.net>
	<20090522193359.17514ptwyl8kdbls@lidskialf.net>
	<20090522231826.12833dwwkvi7rv0g@lidskialf.net>
	<20090523023901.33341jpwcx6nd70g@lidskialf.net>
	<20090523014717.GB9283@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:49212 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZEWLLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 May 2009 07:11:08 -0400
In-Reply-To: <20090523014717.GB9283@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, ladis@linux-mips.org

Quoting Tony Lindgren <tony@atomide.com>:

> * Andrew de Quincey <adq@lidskialf.net> [090522 18:39]:
>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>
>>> Quoting Andrew de Quincey <adq@lidskialf.net>:
>>>
>>>> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>>>>
>>>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>>>
>>>>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090519 22:15]:
>>>>>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>>>>>
>>>>>>>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090516 19:17]:
>>>>>>>>> Argh, my N770 seems to have just died; it has been behaving slightly
>>>>>>>>> oddly and now it simply won't turn on (black screen and no  
>>>>>>>>> sign of life
>>>>>>>>> whatsoever).
>>>>>>>>>
>>>>>>>>> It is well out of warranty and frankly I don't see myself
>>>>>>>>> buying another
>>>>>>>>> one, so this effectively ends my hacking on it :(
>>>>>>>>
>>>>>>>> Bummer :(
>>>>>>>>
>>>>>>>> After a quick try, CONFIG_OMAP_RESET_CLOCKS was the first  
>>>>>>>> stopper, then
>>>>>>>> it could not mount the MMC root.
>>>>>>>
>>>>>>> Ahh excellent, that was why I posted my progress, in case it  
>>>>>>> rang a bell
>>>>>>> with anyone! I think the touchpad driver may be broken as well BTW.
>>>>>>>
>>>>>>>> I think there was a patch posted for the omap1 MMC by
>>>>>>>> Ladislav few months
>>>>>>>> ago that probably fixes it.
>>>>>>>
>>>>>>> Cool - I hope I may be back in the running soon (I was rather annoyed
>>>>>>> when I posted that message!); I've ordered a new battery in case its
>>>>>>> just that. A kind person has also offered me one thats broken in a
>>>>>>> different way that I can probably cobble together with the remains of
>>>>>>> mine if its something more critical that has died.
>>>>>>
>>>>>> Good to hear, let's hope it just needs a new battery.
>>>>>>
>>>>>> See also the n8x0 thread. If we get drivers/cbus to mainline, we
>>>>>> pretty much have everything we need for 770 in mainline too.
>>>>>>
>>>>>> It would be nice to get the drivers/mmc/host/omap.c patch integrated
>>>>>> for 2.6.30 to make omap1 MMC work again. Ladislav, any news on that?
>>>>>
>>>>> OK! My friend has lent me his N770 in the meantime so I can get
>>>>> going again. It seems the board is fried on mine as my battery
>>>>> works perfectly fine in his. gah!
>>>>>
>>>>> Anyway, I have just tried disabling RESET_CLOCKS, but it still
>>>>> doesn't work for me with the very latest linux-omap-2.6.
>>>>>
>>>>> With my HWA patch applied, at least the screen goes black, but I
>>>>> don't see any console output, and the thing doesn't appear as a
>>>>> USB gadget (I'm mounting NFS as root over USB with cdc_ether).
>>>>>
>>>>> I wish the thing had an LED I could turn on! Hmm, I wonder if I
>>>>> could turn off the backlight easily..
>>>>
>>>> Actually, after playing a bit, I discovered I'm getting a boot
>>>> penguin logo ok, but no actual textual console output; weird!
>>>
>>> I feel really silly; the N770's bootloader had "serial-console"
>>> enabled, which meant all the kernel messages were being sent out that
>>> instead of being displayed on the fb. So I can now see WTF is going on!
>>>
>>> Next problem for me: ohci-hcd.c is reporting an initialisation error
>>> in the latest kernels, which is why my NFS-over-USB mount fails. I
>>> can't see any changes in the initialisation *values* used, but there
>>> have obviously been the "kill OMAP_TAG_USB" changes; I'm wondering if
>>> its some initialisation ordering problem.
>>
>> OK got it, it IS a timing problem, due to non-ARM changes in the core
>> kernel (possibly the recent async subsystem startup improvements?).
>>
>> In the middle of the boot with a recent kernel, I see a message
>> "tahvo-usb: no tahvo_otg_dev" coming from
>> drivers/cbus/tahvo-usb.c/omap_otg_init(). This is because the internal
>> field "tahvo_otg_dev" is NULL. In turn, omap_otg_init() is being called
>> by tahvo_usb_become_peripheral() which is called from higher up in the
>> USB stack.
>>
>> However, from the code, what is /meant/ to happen is that the "omap_otg"
>> driver is meant to call omap_otg_probe() (which sets that field) before
>> anything calls drivers/cbus/tahvo-usb.c/omap_otg_init(). However, due to
>> the timing problem, it occurs out of sequence, so it thinks there isn't a
>> transceiver present.
>>
>> tahvo-usb.c looks as though it needs sorting out somehow; it seems to
>> consist of two seperate drivers rammed together, plus it has this timing
>> issue. The tahvo-usb code itself suggests splitting the tahvo-usb driver
>> into an "omap-otg.c" driver, though some thought will be needed to
>> eliminate the timing issue properly.
>>
>
> Hmm, a quick diff with $ git diff omap-2.6.28..master drivers/Makefile
> shows that cbus order has changed in the Makefile, maybe that causes it?

Oooh that'd be horrible! but reverting it doesn't appear fix anything.

Anyway, the breaking changeset doesn't have that change in it... its  
still the ones that I highlighted at the start of this thread.

Doing

git log -p  
eba05254cb561dc27d5664503f91f7c21954e648..0595ee8a05836666b225e6bf003ede0da1e6e329  
drivers/Makefile

Doesn't show any ordering changes in Makefile affecting cbus or platform...

Incidentally, I tried turning on CONFIG_BOOT_PRINTK_DELAY with a  
boot_delay=100. With that, it now DOES probe the omap_otg device in  
tahvo-usb first, but it dies with a NULL pointer dereference. Still  
sounds like an initialisation timing problem here...

