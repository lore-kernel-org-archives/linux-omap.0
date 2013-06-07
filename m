From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Fri, 7 Jun 2013 09:29:27 -0700
Message-ID: <20130607162927.GA3331@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34461 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab3FGQ3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 12:29:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

* Paul Walmsley <paul@pwsan.com> [130607 05:38]:
> On Fri, 7 Jun 2013, Sricharan R wrote:
> 
> > - The IO resource information like dma request lines, irq number and
> >   ocp address space can be populated via dt blob. So such data is stripped
> >   from OMAP4 SOC hwmod data file.
> > 
> > - The devices which are still missing the device tree bindings,
> >   address space entries are not removed yet. When such devices add
> >   the dt bindings, respective address space data can be deleted.
> > 
> > - Also other unnecessary hwmods like firewalls are removed as a part of this.
> >   Since emif was getting registered only because of this firewalls links,
> >   the mpu->emif direct link is added now.
> > 
> > The above update, results in reduction of about ~1650 lines of code.
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Can't test this one since I don't have an OMAP4 DT config set up in the testbed
> yet.  Maybe will add that to the testbed after the v3.10 release.

OK thanks, applying into omap-for-v3.11/cleanup.

Regards,

Tony
