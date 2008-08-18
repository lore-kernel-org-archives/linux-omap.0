From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
 linux-omap
Date: Mon, 18 Aug 2008 13:43:35 +0300 (EEST)
Message-ID: <20080818.134335.188405437.Hiroshi.DOYU@nokia.com>
References: <EBA93F3E4CB46947A4C5275F6308CF3E03434E08@dlee15.ent.ti.com>
	<94a0d4530808160257r77341fafn5f2b8404a8510203@mail.gmail.com>
	<20080818075624.GB12243@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20776 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762058AbYHRTA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 15:00:28 -0400
In-Reply-To: <20080818075624.GB12243@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: felipe.contreras@gmail.com, vpasam@ti.com, r-woodruff2@ti.com, linux-omap@vger.kernel.org, soni.trilok@gmail.com, h-kanigeri2@ti.com, x00omar@ti.com, grgupta@ti.com, felipe.contreras@nokia.com, siarhei.siamashka@nokia.com

Hi,

"mmu" and "mailbox" still have some dependency on dspgateway. They
also should be cleaned up as being independent on specific
implementation, ideally to be shared by any bridge implementations.

	       Hiroshi DOYU

From: "ext Tony Lindgren" <tony@atomide.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Mon, 18 Aug 2008 10:56:24 +0300

> Hi,
> 
> * Felipe Contreras <felipe.contreras@gmail.com> [080816 12:58]:
> > Hi Vijay,
> > 
> > On Sat, Aug 16, 2008 at 12:59 AM, Pasam, Vijay <vpasam@ti.com> wrote:
> > >> I'm not familiar with checkpatch, but I guess the purpose is
> > >> not to highlight functional issues.
> > >>
> > >> However, there are functional issues, but it makes sense to
> > >> cleanup the code first: there's no point in analyzing code
> > >> that is never used.
> > >
> > > There are about 9 errors with the latest set of patches. These are all
> > > false positives - not really errors. Majority of warnings also fall
> > > under this category.
> > 
> > I'm not talking about issues returned by checkpatch, but issues
> > visible to the human observer.
> 
> And the two pieces of code that need to be fixed for Linux ASAP
> for DSP are:
> 
> - External device MMU hardware
> - Mailbox handling
> 
> This code needs to be shared for dsp[bios|bridge|gateway|link].
> And it can be also used for any other devices and coprocessors
> needing MMU handling.
> 
> So far the sanest solution seems to be in:
> 
> arch/arm/*omap*/mmu.[ch]
> arch/arm/*omap*/mailbox.[ch]
> 
> Is there any reason why this code cannot be used for dspbridge?
> 
> BTW, the MMU code needs to be fixed so that the code
> shared with ioremap() is moved to ioremap(). Basically we
> need to enhance ioremap() in a way where it can support external
> MMU hardware. Otherwise the maintenance will be a nightmare.
> 
> This was pointed out by Russell King a while back when we tried
> to get the MMU code integrated to the mainline kernel.
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
