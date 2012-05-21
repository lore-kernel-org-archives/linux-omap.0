From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 06/19] ARM: OMAP4: PM: Add SAR backup support towards
 device OFF
Date: Mon, 21 May 2012 12:07:38 +0300
Message-ID: <1337591258.28274.2.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-7-git-send-email-t-kristo@ti.com> <87aa177my3.fsf@ti.com>
	 <CAMQu2gznJ0q-Eqevh9dWn+vw69to91kfFG6hYDvTbGj3zwT0FQ@mail.gmail.com>
	 <87aa1621yv.fsf@ti.com>
	 <CAMQu2gwgfsxZ67OeDMK4_Z0phPxuiSMA9oiJ63cz1nPiOBA+jg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33733 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab2EUJHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 05:07:44 -0400
In-Reply-To: <CAMQu2gwgfsxZ67OeDMK4_Z0phPxuiSMA9oiJ63cz1nPiOBA+jg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Fri, 2012-05-18 at 11:23 +0530, Shilimkar, Santosh wrote:
> On Thu, May 17, 2012 at 10:12 PM, Kevin Hilman <khilman@ti.com> wrote:
> > "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> >
> >> On Thu, May 17, 2012 at 4:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> >>> Tero Kristo <t-kristo@ti.com> writes:
> >>>
> >>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>>
> >>>> The SAR RAM is maintained during Device OFF mode.
> >>>
> >>> so why is this patch bothering to save and restore it?
> >>>
> >> SAR RAM is maintained(not powered down) but somebody needs to
> >> feel the contents which will be preserved :-)
> >>
> >>> -ECONFUSED
> >>>
> >>>> The register layout
> >>>> is fixed in SAR ROM. SAR is split into 4 banks with different
> >>>> privilege accesses based on device type
> >>>>
> >>>>  ---------------------------------------------------------------
> >>>>  Access mode          Bank    Address Range
> >>>>  ---------------------------------------------------------------
> >>>>  HS/GP : Public               1       0x4A32_6000 - 0x4A32_6FFF (4kB)
> >>>>  HS/GP : Public               2       0x4A32_7000 - 0x4A32_73FF (1kB)
> >>>>
> >>>>  HS/EMU : Secured
> >>>>  GP : Public          3       0x4A32_8000 - 0x4A32_87FF (2kB)
> >>>>
> >>>>  HS/GP :Secure
> >>>>  write once.          4       0x4A32_9000 - 0x4A32_93FF (1kB)
> >>>>  ---------------------------------------------------------------
> >>>>
> >>>> The save process is done entirely by software and restore is done by
> >>>> hardware using the auto-restore feature. The restore feature is enabled
> >>>> by default and cannot be disabled. The software must save the data
> >>>> to be restored in a dedicated location in SAR RAM.
> >>>
> >>> Some general comments:
> >>>
> >>> - can the cluster PM notifier be used for the save path?
> >>>
> >> Nope. This is for device OFF only case. CPU Cluster state as such
> >> has no dependency.
> >
> > Yeah, I see now.  I like your idea of a device-off notifier chain
> > modeled on the CPU PM notifier chain.
> >
> >>> - This patch adds lots of data that is immediately removed by the next
> >>>  patch.  Probably the two just need to be combined.
> >>>
> >> iormap() hunk from this patch can be completely dropped since
> >> it is getting fixed in next patch. Other infrastructure is maintained.
> >
> > Look again at how much stuff is deleted in the next patch that is added
> > in this patch, and think about how a reviewer is supposed to follow that
> > easily.
> >
> OK. With me. Actually with proposed split of further patch, things can
> be sorted out in different patches quite well.

I'll take a look if I'll merge these patches completely or modify the
contents. In some work version I had, this patch was completely merged
with the next.

> 
> >>> - BUG_ON() should not be used unless there is absolutely no recovery
> >>>  path, since it casues a full kernel panic.   Instead, some error
> >>>  recovery should be added.
> >>>
> >> WARN_ON should suffice.
> >
> > Not really.  Error recovery should be added.
> >
> Agree

Will fix that also.

-Tero

