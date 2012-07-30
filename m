From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on vacation)
Date: Mon, 30 Jul 2012 11:21:36 +0530
Message-ID: <CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
References: <20120725141222.GA6939@n2100.arm.linux.org.uk> <20120727134231.GA5934@n2100.arm.linux.org.uk>
 <CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
 <20120727165049.GB7405@n2100.arm.linux.org.uk> <CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:48899 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289Ab2G3Fv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 01:51:58 -0400
Received: by ghrr14 with SMTP id r14so4333143ghr.4
        for <linux-omap@vger.kernel.org>; Sun, 29 Jul 2012 22:51:57 -0700 (PDT)
In-Reply-To: <CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sat, Jul 28, 2012 at 1:40 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Jul 27, 2012 at 6:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Jul 27, 2012 at 06:08:13PM +0200, Shilimkar, Santosh wrote:
>>> On Fri, Jul 27, 2012 at 3:42 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>> > On Wed, Jul 25, 2012 at 03:12:22PM +0100, Russell King - ARM Linux wrote:
>>> >> Just a quick reminder that I'm still on holiday, and at this point there
>>> >> are over 2500 messages from the mailing lists which are sitting unread
>>> >> since I left the UK.  As I mentioned before I left the UK, it is my
>>> >> intention *not* to go back and read all those outstanding messages -
>>> >> there's too many of them to do that.
>>> >>
>>> >> So, if you want me to react to any email message you've sent, you'd
>>> >> *better* send it again next week unless I've already responded.
>>> >>
>>> >> Meanwhile, I see v3.5 has been released; I have a couple of things I
>>> >> need to do with my tree before I can push the changes, and I'll
>>> >> probably see about sorting those out over the weekend.  I also see
>>> >> that 14 new patches have landed in the patch system.
>>> >>
>>> >> However, the timing of my holiday vs the merge window means that I
>>> >> can't take anything new, unless they're fixes, so don't be surprised
>>> >> if some stuff gets missed this merge window.
>>> >
>>> > Right.  I'm not fully recovered from the jet lag (I'm still rather tired
>>> > - I hate travelling back from the North American continent because it
>>> > takes days to recover.)
>>> >
>>> > I have now archived off *all* email sent to me during July - which means
>>> > that I will *NOT* be responding to anything sent during the last 17 days.
>>> > If anyone has sent me anything important, it *MUST* be resent now.
>>> >
>>> > I am aware of an issue concerning the OMAP DMA patches.  I'm not sure
>>> > exactly what is required there, so I've dropped them from my planned pull
>>> > request in the interests of getting everything else I have to Linus.  I
>>> > may plan to send a pull request this evening.
>>> >
>>> Well the only pending discussion was enabling the CONFIG option for
>>> DMA at driver level SOC config level. Not sure if there was anything else
>>> on this really.
>>
>> Why?  The DMA driver itself is optional.
> That was Tony's point too. Unfortunately MMC and SPI driver don't work
> today without DMA. Some works needs to be done to support polling
> mode and am bit skeptical if it is really worth it. Same case be with other
> SDMA supported drivers mostly.
>
Russell, Tony,
  Can I request to include the DMA & MMC changes into this merge window ?
We have many cleanups and new patches waiting to be queued up for next (3.7)
merge window, and it'd be easier if they are implemented on top of the
DMA changes,
so that it gets tested together, and don't create merge conflicts.
  I am looking into implementing polling mode, which might take some time.
Regards,
Venkat
