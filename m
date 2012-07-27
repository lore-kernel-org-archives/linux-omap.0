From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: rmk back but still recovering (was Re: Reminder - rmk still on
	vacation)
Date: Fri, 27 Jul 2012 17:50:49 +0100
Message-ID: <20120727165049.GB7405@n2100.arm.linux.org.uk>
References: <20120725141222.GA6939@n2100.arm.linux.org.uk> <20120727134231.GA5934@n2100.arm.linux.org.uk> <CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50607 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2G0QwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 12:52:09 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Jul 27, 2012 at 06:08:13PM +0200, Shilimkar, Santosh wrote:
> On Fri, Jul 27, 2012 at 3:42 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Jul 25, 2012 at 03:12:22PM +0100, Russell King - ARM Linux wrote:
> >> Just a quick reminder that I'm still on holiday, and at this point there
> >> are over 2500 messages from the mailing lists which are sitting unread
> >> since I left the UK.  As I mentioned before I left the UK, it is my
> >> intention *not* to go back and read all those outstanding messages -
> >> there's too many of them to do that.
> >>
> >> So, if you want me to react to any email message you've sent, you'd
> >> *better* send it again next week unless I've already responded.
> >>
> >> Meanwhile, I see v3.5 has been released; I have a couple of things I
> >> need to do with my tree before I can push the changes, and I'll
> >> probably see about sorting those out over the weekend.  I also see
> >> that 14 new patches have landed in the patch system.
> >>
> >> However, the timing of my holiday vs the merge window means that I
> >> can't take anything new, unless they're fixes, so don't be surprised
> >> if some stuff gets missed this merge window.
> >
> > Right.  I'm not fully recovered from the jet lag (I'm still rather tired
> > - I hate travelling back from the North American continent because it
> > takes days to recover.)
> >
> > I have now archived off *all* email sent to me during July - which means
> > that I will *NOT* be responding to anything sent during the last 17 days.
> > If anyone has sent me anything important, it *MUST* be resent now.
> >
> > I am aware of an issue concerning the OMAP DMA patches.  I'm not sure
> > exactly what is required there, so I've dropped them from my planned pull
> > request in the interests of getting everything else I have to Linus.  I
> > may plan to send a pull request this evening.
> >
> Well the only pending discussion was enabling the CONFIG option for
> DMA at driver level SOC config level. Not sure if there was anything else
> on this really.

Why?  The DMA driver itself is optional.
