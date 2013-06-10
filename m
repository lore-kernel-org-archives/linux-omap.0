From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Mon, 10 Jun 2013 07:14:51 -0700
Message-ID: <20130610141451.GE8164@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com>
 <20130607175005.GB3331@atomide.com>
 <51B5ACA6.2010101@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16891 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab3FJOO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 10:14:59 -0400
Content-Disposition: inline
In-Reply-To: <51B5ACA6.2010101@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Cc: Paul Walmsley <paul@pwsan.com>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

* Tomi Valkeinen <tomi.valkeinen@iki.fi> [130610 03:44]:
> On 07/06/13 20:50, Tony Lindgren wrote:
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
> 
> What issue do you refer to?
> 
> DSS does not have DT bindings, and removing DSS from hwmod data will
> break DSS for omap4.

Ah that's right. Care to post a patch reverting the minimal parts that
you need for omap4 against omap-for-v3.11/cleanup?

Regards,

Tony
