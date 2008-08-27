From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: Enabling MUSB support
Date: Wed, 27 Aug 2008 09:53:08 -0400
Message-ID: <1f11a5490808270653o4f31b33m56e01069ae502060@mail.gmail.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5971@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:21896 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239AbYH0NxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 09:53:10 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1360550wxd.4
        for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 06:53:08 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5971@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Aug 27, 2008 at 9:40 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> Greetings,
>>
>> I'm trying to test out the MUSB support on my OMAP-3530 based device
>> with the TWL4030 Phy. I'm using 2.6.22.18 and have tried to enable all
>> different settings related to MUSB and nothing seems to happen. The
>> TWL4030_USB driver builds and loads and claims that a cable is plugged
>> in even when nothing is plugged in.
>>
>> The "musb_hdrc" driver loads up and registers with IRQs 92 and 93. The
>> TWL4030_USB driver registers with IRQ 373. As I plug-in and remove the
>> cable from the USB port, no interrupts are generated and the driver is
>> completely oblivious to what's happening..
>>
>> I'm trying to configure the MUSB driver as a Host-only to start with,
>> I've also tried to set it as OTG with no change.
>>
>> My current ".config" is as follows, could someone point me to any
>> configuration option or anything that I'm missing..
>
> Can you try "echo F > /proc/driver/musb_hdrc" twice?
> Or try building it in gadget mode?
>
> Or use the current kernel (recommended option).
>
> - Anand
>

I tried this command saw no activity, I tried the other commands "C",
"T" also with no effect. My reigster dump looks like:

musb_proc_write 847: R: dump all registers

fadd  pwr   inTx  inRx  inTe  inRe  intU  inUe  fram  indx  tstm  dctl
0000  00e0  0000  0000  ffff  fffe  0000  00f7  0000  000f  0000  0081

dma_ch  cntl    address         count
0000    00000000                00000000
0000    00000000                00000000
0000    00000000                00000000
0000    00000000                00000000
0000    00000000                00000000
0000    00000000                00000000
0000    00000000                00000000
0000    00000000                00000000

~ Ashwin
