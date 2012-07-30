From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on vacation)
Date: Mon, 30 Jul 2012 13:56:05 +0530
Message-ID: <CAM=Q2cuF6S9T369DFhGF8LoYaPMF=f1x9mjX1Se9S9qZ3WfiPg@mail.gmail.com>
References: <20120725141222.GA6939@n2100.arm.linux.org.uk>
	<20120727134231.GA5934@n2100.arm.linux.org.uk>
	<CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
	<20120727165049.GB7405@n2100.arm.linux.org.uk>
	<CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
	<CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
	<CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34504 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2G3I0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 04:26:06 -0400
Received: by gglu4 with SMTP id u4so4514020ggl.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 01:26:05 -0700 (PDT)
In-Reply-To: <CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>

On Mon, Jul 30, 2012 at 1:10 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
[...]
>>>>
>>>> Why?  The DMA driver itself is optional.
>>> That was Tony's point too. Unfortunately MMC and SPI driver don't work
>>> today without DMA. Some works needs to be done to support polling
>>> mode and am bit skeptical if it is really worth it. Same case be with other
>>> SDMA supported drivers mostly.
>>>
>> Russell, Tony,
>>   Can I request to include the DMA & MMC changes into this merge window ?
>> We have many cleanups and new patches waiting to be queued up for next (3.7)
>> merge window, and it'd be easier if they are implemented on top of the
>> DMA changes,
>> so that it gets tested together, and don't create merge conflicts.
>>   I am looking into implementing polling mode, which might take some time.
>
> Thanks Venkat. For the SPI driver as well I heard from Shubro (in cc) that
> he is looking into polling mode.

I had a patch in case of errors falling back to poll mode

http://www.spinics.net/lists/linux-omap/msg74417.html

>
> IMHO, we should merge the OMAP DMA engine support which is now sufficiently
> tested and has been in linux-next for some time. Polling mode and ASOC
> related issues can be then debugged directly on mainline.
> For the time being, the SOC patch which Tony merged in linux-omap
> master can be included along with rest of the OMAP DMA engine patches
> to have working kernel.
>
> Regards
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
