From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on vacation)
Date: Mon, 30 Jul 2012 19:17:55 +0200
Message-ID: <CABxcv=kOg0bQ_4BO+tkEq5tNhoR64GyHt7erOKcPk_U8GJE-Pw@mail.gmail.com>
References: <20120727165049.GB7405@n2100.arm.linux.org.uk>
	<CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
	<CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
	<CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com>
	<20120730143323.GE7405@n2100.arm.linux.org.uk>
	<CAMQu2gyxODJb2Kc_AtYPrhwoOvEwQNLkYHvbk3e=UPdgvxdWng@mail.gmail.com>
	<20120730144443.GG7405@n2100.arm.linux.org.uk>
	<CANfBPZ9H9D-HGu2YT5hp-OXPqY4M6BZcH2qhUfHO203RokZ0Aw@mail.gmail.com>
	<CABxcv=msMZ7ufh2ROeEry1eY7HbXU8GRB5RkZx1x6asAx3CZ=w@mail.gmail.com>
	<20120730152541.GI7405@n2100.arm.linux.org.uk>
	<20120730170252.GB11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36389 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab2G3RR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 13:17:56 -0400
Received: by gglu4 with SMTP id u4so5059607ggl.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 10:17:55 -0700 (PDT)
In-Reply-To: <20120730170252.GB11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "S, Venkatraman" <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 30, 2012 at 7:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120730 08:31]:
>> On Mon, Jul 30, 2012 at 05:19:06PM +0200, Javier Martinez Canillas wrote:
>> > >
>> > > I think Santosh meant this patch..
>> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=55936cdfaaf11ac352b56bc58e42d6661e65ee13
>> >
>> > That is the patch that fixes the DMA issue with the OMAP MMC and OMAP
>> > MMC HS drivers when OMAP_DMA option is not set, since they still don't
>> > support poll mode without DMA.
>> >
>> > Russell, are you going to take the patch from Tony's linux-omap/master
>> > tree or do I have to add the patch to the patch system also?
>>
>> It'd be better to have it via the patch system, because pulling it out
>> of a URL isn't an easy task.
>
> Javier, can you please submit it to Russell's patch tracking system?
> Please just replace my Signed-off-by with my Acked-by for that patch.
>
> Regards,
>
> Tony

Hi Tony,

I just submitted the patch [1] to Russell's patch system before
reading this email so I left your Signed-off-by instead of Acked-by,
hope this won't be an issue.

Best regards,
Javier

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7481/1
