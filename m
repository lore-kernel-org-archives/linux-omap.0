From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 5/5] ARM: OMAP4: hwmod data: ipu and dsp to use parent
 clocks instead of leaf clocks
Date: Fri, 23 Nov 2012 01:05:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211230104220.3517@utopia.booyaka.com>
References: <1353373552-16039-1-git-send-email-omar.luna@linaro.org> <1353373552-16039-6-git-send-email-omar.luna@linaro.org> <20121121185202.GC18567@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121121185202.GC18567@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, Joerg Roedel <joro@8bytes.org>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Ido Yariv <ido@wizery.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Wed, 21 Nov 2012, Tony Lindgren wrote:

> * Omar Ramirez Luna <omar.luna@linaro.org> [121119 17:08]:
> > This prevents hwmod _enable_clocks...omap2_dflt_clk_enable path
> > from enabling modulemode inside CLKCTRL using its clk->enable_reg
> > field. Instead is left to _omap4_enable_module though soc_ops, as
> > the one in charge of this setting.
> > 
> > According to comments received[1] for related patches the idea is
> > to get rid of leaf clocks in future. So remove these two while at it.
> > 
> > [1] http://lkml.org/lkml/2012/8/20/226
> 
> This one should be queued by Paul, or at least acked by him.

This will need to be updated to apply after the recent CCF conversion 
patches.  Otherwise,

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
