From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on vacation)
Date: Mon, 30 Jul 2012 17:19:06 +0200
Message-ID: <CABxcv=msMZ7ufh2ROeEry1eY7HbXU8GRB5RkZx1x6asAx3CZ=w@mail.gmail.com>
References: <20120725141222.GA6939@n2100.arm.linux.org.uk>
	<20120727134231.GA5934@n2100.arm.linux.org.uk>
	<CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
	<20120727165049.GB7405@n2100.arm.linux.org.uk>
	<CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
	<CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
	<CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com>
	<20120730143323.GE7405@n2100.arm.linux.org.uk>
	<CAMQu2gyxODJb2Kc_AtYPrhwoOvEwQNLkYHvbk3e=UPdgvxdWng@mail.gmail.com>
	<20120730144443.GG7405@n2100.arm.linux.org.uk>
	<CANfBPZ9H9D-HGu2YT5hp-OXPqY4M6BZcH2qhUfHO203RokZ0Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33731 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2G3PTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 11:19:07 -0400
Received: by obbuo13 with SMTP id uo13so9103214obb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 08:19:06 -0700 (PDT)
In-Reply-To: <CANfBPZ9H9D-HGu2YT5hp-OXPqY4M6BZcH2qhUfHO203RokZ0Aw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 30, 2012 at 4:46 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Mon, Jul 30, 2012 at 8:14 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Jul 30, 2012 at 04:37:09PM +0200, Shilimkar, Santosh wrote:
>>> On Mon, Jul 30, 2012 at 4:33 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>> > So I take that as you wanting exactly what is in linux-next merged without
>>> > any further changes?
>>>
>>> Just one patch[1] on top of that so that default omap2plus_defconfig
>>> keeps working.
>>
>> Err, I don't see what that patch does.  Setting ret=-ENXIO at the
>> start of the function, when it's subsequently overwritten by:
>>
>> +       int ret = -ENXIO, irq;
>> ...
>>         ret = omap_hsmmc_gpio_init(pdata);
>> ...
>>         ... dma stuff ...
>>
>> seems absurd.
>
> I think Santosh meant this patch..
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=55936cdfaaf11ac352b56bc58e42d6661e65ee13

That is the patch that fixes the DMA issue with the OMAP MMC and OMAP
MMC HS drivers when OMAP_DMA option is not set, since they still don't
support poll mode without DMA.

Russell, are you going to take the patch from Tony's linux-omap/master
tree or do I have to add the patch to the patch system also?

Thanks a lot and best regards,
Javier
