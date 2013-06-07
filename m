From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Fri, 7 Jun 2013 11:37:48 -0700
Message-ID: <20130607183748.GF3331@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com>
 <20130607175005.GB3331@atomide.com>
 <51B22303.2000002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63777 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755813Ab3FGShx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 14:37:53 -0400
Content-Disposition: inline
In-Reply-To: <51B22303.2000002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130607 11:20]:
> On Friday 07 June 2013 01:50 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [130607 09:35]:
> >> * Paul Walmsley <paul@pwsan.com> [130607 05:38]:
> >>> On Fri, 7 Jun 2013, Sricharan R wrote:
> >>>
> >>>> - The IO resource information like dma request lines, irq number and
> >>>>   ocp address space can be populated via dt blob. So such data is stripped
> >>>>   from OMAP4 SOC hwmod data file.
> >>>>
> >>>> - The devices which are still missing the device tree bindings,
> >>>>   address space entries are not removed yet. When such devices add
> >>>>   the dt bindings, respective address space data can be deleted.
> >>>>
> >>>> - Also other unnecessary hwmods like firewalls are removed as a part of this.
> >>>>   Since emif was getting registered only because of this firewalls links,
> >>>>   the mpu->emif direct link is added now.
> >>>>
> >>>> The above update, results in reduction of about ~1650 lines of code.
> >>>>
> >>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> >>>
> >>> Acked-by: Paul Walmsley <paul@pwsan.com>
> >>>
> >>> Can't test this one since I don't have an OMAP4 DT config set up in the testbed
> >>> yet.  Maybe will add that to the testbed after the v3.10 release.
> >>
> >> OK thanks, applying into omap-for-v3.11/cleanup.
> > 
> > I had to undo the following parts to avoid regressions on omap4sdp.
> > Can you please follow up on fixing the related issues so the fixup
> > won't be needed?
> > 
> > Seems to work now the same way as earlier for both omap4sdp and blaze
> > es, except for DSS, which seems to be a separate issue as posted by
> > Tomi. Pushed out now to omap-for-v3.11/cleanup.
> > 
> Thats strange. You shouldn't need those fixes since that data is
> expected to be coming from DT.
> 
> Sricharan, Can you please try out the patch against Tony's
> V3.11/clean-up branch and see whats missing there.

Looking at the diff output with and without, it seems to be that the
DMA channels won't get configured.

Regards,

Tony
