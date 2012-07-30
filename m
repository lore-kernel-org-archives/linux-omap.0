From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on vacation)
Date: Mon, 30 Jul 2012 16:37:09 +0200
Message-ID: <CAMQu2gyxODJb2Kc_AtYPrhwoOvEwQNLkYHvbk3e=UPdgvxdWng@mail.gmail.com>
References: <20120725141222.GA6939@n2100.arm.linux.org.uk> <20120727134231.GA5934@n2100.arm.linux.org.uk>
 <CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
 <20120727165049.GB7405@n2100.arm.linux.org.uk> <CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
 <CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
 <CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com> <20120730143323.GE7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42202 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516Ab2G3Ohc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 10:37:32 -0400
Received: by ggnp1 with SMTP id p1so5912595ggn.18
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 07:37:30 -0700 (PDT)
In-Reply-To: <20120730143323.GE7405@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>

On Mon, Jul 30, 2012 at 4:33 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 30, 2012 at 09:40:27AM +0200, Shilimkar, Santosh wrote:
>> On Mon, Jul 30, 2012 at 7:51 AM, S, Venkatraman <svenkatr@ti.com> wrote:
>> > On Sat, Jul 28, 2012 at 1:40 PM, Shilimkar, Santosh
>> > <santosh.shilimkar@ti.com> wrote:
>> >> On Fri, Jul 27, 2012 at 6:50 PM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >>> On Fri, Jul 27, 2012 at 06:08:13PM +0200, Shilimkar, Santosh wrote:
>> >>>> On Fri, Jul 27, 2012 at 3:42 PM, Russell King - ARM Linux
>> >>>> <linux@arm.linux.org.uk> wrote:
>> >>>> > On Wed, Jul 25, 2012 at 03:12:22PM +0100, Russell King - ARM Linux wrote:
>> >>>> >> Just a quick reminder that I'm still on holiday, and at this point there
>> >>>> >> are over 2500 messages from the mailing lists which are sitting unread
>> >>>> >> since I left the UK.  As I mentioned before I left the UK, it is my
>> >>>> >> intention *not* to go back and read all those outstanding messages -
>> >>>> >> there's too many of them to do that.
>> >>>> >>
>> >>>> >> So, if you want me to react to any email message you've sent, you'd
>> >>>> >> *better* send it again next week unless I've already responded.
>> >>>> >>
>> >>>> >> Meanwhile, I see v3.5 has been released; I have a couple of things I
>> >>>> >> need to do with my tree before I can push the changes, and I'll
>> >>>> >> probably see about sorting those out over the weekend.  I also see
>> >>>> >> that 14 new patches have landed in the patch system.
>> >>>> >>
>> >>>> >> However, the timing of my holiday vs the merge window means that I
>> >>>> >> can't take anything new, unless they're fixes, so don't be surprised
>> >>>> >> if some stuff gets missed this merge window.
>> >>>> >
>> >>>> > Right.  I'm not fully recovered from the jet lag (I'm still rather tired
>> >>>> > - I hate travelling back from the North American continent because it
>> >>>> > takes days to recover.)
>> >>>> >
>> >>>> > I have now archived off *all* email sent to me during July - which means
>> >>>> > that I will *NOT* be responding to anything sent during the last 17 days.
>> >>>> > If anyone has sent me anything important, it *MUST* be resent now.
>> >>>> >
>> >>>> > I am aware of an issue concerning the OMAP DMA patches.  I'm not sure
>> >>>> > exactly what is required there, so I've dropped them from my planned pull
>> >>>> > request in the interests of getting everything else I have to Linus.  I
>> >>>> > may plan to send a pull request this evening.
>> >>>> >
>> >>>> Well the only pending discussion was enabling the CONFIG option for
>> >>>> DMA at driver level SOC config level. Not sure if there was anything else
>> >>>> on this really.
>> >>>
>> >>> Why?  The DMA driver itself is optional.
>> >> That was Tony's point too. Unfortunately MMC and SPI driver don't work
>> >> today without DMA. Some works needs to be done to support polling
>> >> mode and am bit skeptical if it is really worth it. Same case be with other
>> >> SDMA supported drivers mostly.
>> >>
>> > Russell, Tony,
>> >   Can I request to include the DMA & MMC changes into this merge window ?
>> > We have many cleanups and new patches waiting to be queued up for next (3.7)
>> > merge window, and it'd be easier if they are implemented on top of the
>> > DMA changes,
>> > so that it gets tested together, and don't create merge conflicts.
>> >   I am looking into implementing polling mode, which might take some time.
>>
>> Thanks Venkat. For the SPI driver as well I heard from Shubro (in cc) that
>> he is looking into polling mode.
>>
>> IMHO, we should merge the OMAP DMA engine support which is now sufficiently
>> tested and has been in linux-next for some time. Polling mode and ASOC
>> related issues can be then debugged directly on mainline.
>> For the time being, the SOC patch which Tony merged in linux-omap
>> master can be included along with rest of the OMAP DMA engine patches
>> to have working kernel.
>
> So I take that as you wanting exactly what is in linux-next merged without
> any further changes?

Just one patch[1] on top of that so that default omap2plus_defconfig
keeps working.

Regards
Santosh

[1] https://patchwork.kernel.org/patch/1220141/
