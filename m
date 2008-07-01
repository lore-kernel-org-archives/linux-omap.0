From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Tue, 1 Jul 2008 23:04:43 +0800
Message-ID: <386072610807010804q593d50e8v7b6f4849d27eee7f@mail.gmail.com>
References: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com>
	 <386072610806022132m2d515537wadd23c102aec2bf0@mail.gmail.com>
	 <200806292123.57383.david-b@pacbell.net>
	 <386072610806300453u3e0a1699kcf7084b0a947fba4@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022BF6C991@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.179]:40448 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbYGAPEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 11:04:45 -0400
Received: by el-out-1112.google.com with SMTP id z25so122265ele.1
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2008 08:04:43 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BF6C991@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>

On Tue, Jul 1, 2008 at 8:55 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> <snip>
>
>> Actually, I don't have any detail information about the IP from mentor of Blackfin.
>> I just found the instruction from the Blackfin manual. We need to clear DMA IRQ flag
>> manually on Blackfin, although it is not true on Davinci.
>>
>> >
>> >> > > But when I tried to write large file to the U-DISK
>> >> > > (such as 10Mbyte or 100Mbyte), speed is very slow and mush
>> >> > > slower than PIO mode, IMO.
>> >
>> > I've certainly seen that "little" problem.  I couldn't tell
>> > if the root cause was from Mentor's DMA support or from the
>> > kind of USB-antagonistic DMA engine on DaVinci, but when the
>> > DMA logic has to generate an IRQ for each packet (to get sane
>> > semantics), it's hopeless getting good throughput unless it's
>> > dirt cheap to set up and complete DMA transfers.  (It isn't.)
>> >
>> > As has been seen elsewhere:  when the cost of DMA integration
>> > exceeds the cost to stuff the FIFO by hand, DMA is not a win.
>> > That's an issue with the drivers/dma framework sometimes too,
>> > though in that case the issue is purely software.
>> >
>>
>> I did lots of test to compare the DMA and PIO such as a) dd large file
>> to a USB flash disk, b) use bonnie++ to do performance test.
>> The result is that no throughput improvement on DMA and CPU
>> consumption is the same as PIO.
>>
>> We hope to see the CPU usage of DMA mode is less than PIO mode, but
>> didn't got the expectation.
>
> Approximately how much is the performance you see with PIO mode (given that you also see the same with DMA mode)?
>
I recorded the bonnie++ result in our tracker:
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3786

> Any chance you have dynamic tick suppression enabled (CONFIG_NO_HZ)?
> If so, could you try with nohz=off in your bootargs?
>

Is this helpful? I am afraid that dynamic tick is not fully supported
on Blackfin.
But I will try it.

Thanks
-Bryan
