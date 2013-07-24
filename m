From: Will Deacon <will.deacon@arm.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Wed, 24 Jul 2013 15:20:59 +0100
Message-ID: <20130724142059.GJ11072@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
 <20130722184325.GA21614@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
 <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33913 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371Ab3GXOVh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jul 2013 10:21:37 -0400
Content-Disposition: inline
In-Reply-To: <51EFE1DD.8070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 24, 2013 at 03:17:01PM +0100, Santosh Shilimkar wrote:
> On Wednesday 24 July 2013 09:56 AM, Will Deacon wrote:
> > On Tue, Jul 23, 2013 at 10:05:17AM +0100, Rajendra Nayak wrote:
> >> On Tuesday 23 July 2013 12:37 PM, Paul Walmsley wrote:
> >>> Hi Rajendra,
> >>>
> >>> On Tue, 23 Jul 2013, Rajendra Nayak wrote:
> >>>
> >>>> On Tuesday 23 July 2013 01:37 AM, Paul Walmsley wrote:
> >>>>> On Mon, 22 Jul 2013, Russell King - ARM Linux wrote:
> >>>>>
> >>>>>> Bear in mind that I'm almost at the point of not boot-testing anything
> >>>>>> I sent to Linus because of the uselessness of the SDP4430 board now
> >>>>>> that it's DT only - the only platform which boot-tests anything I send
> >>>>>> is the 3430LDP board now.  If people care about that, maybe they can
> >>>>>> assist with sorting out the issues I've raised on these lists about
> >>>>>> the SDP4430 - and why the SDP4430 build remains disabled in my build
> >>>>>> and boot system.
> >>>>>
> >>>>> I understand completely...
> >>>>>
> >>>>>> Looking at the boot log, it just stops after uboot hands over control.
> >>>>>> With the lack of output from the decompressor, it's not possible to
> >>>>>> tell whether it's a decompressor problem or a kernel problem.
> >>>>>>
> >>>>>> I think you need to turn on the LL_DEBUG option, select the appropriate
> >>>>>> output option, and also get the decompressor to use the kernel's debug
> >>>>>> io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).
> >>>>>
> >>>>> OK, will dig deeper here at the next opportunity.
> >>>>
> >>>> Paul, I can take a look at the 4430sdp issue. Are you also seeing this also on
> >>>> 2430sdp as the subject says, or was that a typo?
> >>>
> >>> Thanks for the offer.  The issue that I'm seeing is on the 2430SDP in my 
> >>> testbed.
> >>>
> >>> I don't have a 4430SDP, so you might consider touching base with rmk for 
> >>> that one.
> >>
> >> So I tried commit 'fb2af00' on the 4430SDP and it did boot fine, though I see
> >> the below errors. (I am using the mainline bootloaders which do not lock any
> >> additional DPLLs like USB)
> > 
> > Any update on this? If it's an issue introduced by architectural changes,
> > I'd really like to bisect it down but I don't have a board.
> > 
> From the other thread, RMK did manage to get the board booting finally
> (uImage related issues, low level debug problem) but with DT only supported
> build, the audio and DSS was not at same state as before(non-DT build).
> And then Tony pointed the issues to Peter and Tomy to address it further.
> 
> Russell,
> Is above right or I am missing something ?

I thought that was the 4430 from before the merge window. Ths issue here is
the 2430 running mainline, as reported by Paul

Will
