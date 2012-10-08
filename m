From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: OMAP2+: Round of the carve out memory
 requested to section_size
Date: Mon, 8 Oct 2012 14:05:42 -0700
Message-ID: <20121008210542.GF13011@atomide.com>
References: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
 <CAMQu2gwuQ6uht0iHtPuhFU4B9P+zgNHYazK+BqE-rnBfnhL2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:12622 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750883Ab2JHVFr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:05:47 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gwuQ6uht0iHtPuhFU4B9P+zgNHYazK+BqE-rnBfnhL2cg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120927 23:35]:
> On Wed, Sep 12, 2012 at 12:44 PM, R Sricharan <r.sricharan@ti.com> wrote:
> > memblock_steal tries to reserve physical memory during boot.
> > When the requested size is not aligned on the section size
> > then, the remaining memory available for lowmem becomes
> > unaligned on the section boundary. There is a issue with this,
> > which is discussed in the thread below.
> >
> > https://lkml.org/lkml/2012/6/28/112
> >
> > The final conclusion from the thread seems to
> > be align the memblock_steal calls on the SECTION boundary.
> > The issue comes out when LPAE is enabled, where the
> > section size is 2MB.
> >
> > Boot tested this on OMAP5 evm with and without LPAE.
> >
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> > ---
> >  [V2] Corrected the subject and added one more description line.
> >
> Looks good.
> Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Tony,
> Can you take this into your next "fixes-noncritical" queue please ?

Applying it now into fixes for the -rc cycle.

Regards,

Tony
