From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAPZOOM]  OMAP : DMA: Spurious interrupt fix
Date: Mon, 12 Jan 2009 14:40:49 +0200
Message-ID: <20090112124048.GD9373@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB029392DE99@dbde02.ent.ti.com> <20090108151120.GQ27566@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB029830F705@dbde02.ent.ti.com> <20090109112817.GG2536@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB029830F81F@dbde02.ent.ti.com> <20090109125709.GP2536@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB029830F859@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51200 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZALMkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 07:40:52 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB029830F859@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090109 15:22]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Friday, January 09, 2009 6:27 PM
> > To: Shilimkar, Santosh
> > Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] [OMAPZOOM] OMAP : DMA: Spurious interrupt fix
> > 
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090109 14:52]:
> > > > -----Original Message-----
> > > > From: Tony Lindgren [mailto:tony@atomide.com] 
> > > > Sent: Friday, January 09, 2009 4:58 PM
> > > > To: Shilimkar, Santosh
> > > > Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH] [OMAPZOOM] OMAP : DMA: Spurious interrupt fix
> > > > 
> > > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090109 12:51]:
> > > > > 
> > > > > Tony,
> > > > > Regarding your proposal of doing the no. of channel 
> > > > reservation during runtime has one problem. 
> > > > > 
> > > > > The whole idea was not to restrict users from using all 32 
> > > > channels and hence the config option. For OMAP secure chips, 
> > > > few security drivers which will execute in secure contex 
> > > > needs dedicated DMA channels and kernel dma library can't be 
> > > > used in that case. So in such cases, required DMA channels 
> > > > can be reserved using this config option. For GP devices all 
> > > > 32 channels can be used currently. 
> > > > > 
> > > > > If it can done in better way, please suggest.
> > > > 
> > > > Well how about passing the configuration for the DMA channels
> > > > from board-*.c file then?
> > > This is certainly a good option if the setting is fixed for 
> > a particular board type. With this how do we ensure user 
> > configurability. Lets say on a particular board, two 
> > users/customers wants to use separate configurations for DMA 
> > channels because of the needs what mentioned earlier. Then 
> > again we need some kind of comfit option.
> > >    Another clean way to achieve this is through 'bootargs'. 
> > But this might be too much of a design for this requirement.
> > 
> > Hmm, well how about starting with all of them, and allow
> > limiting the active DMA number via /sys? I guess we could
> > just set some of the DMA channels inactive that way.
> > 
> > Or maybe allow setting indvidual DMA channels inactive
> > via /sys?
> 
> This won't be a good option because of few limitations.
> - dma library init will configure the entire register set for all the channels. So through /sys disable , you have to mask all of this registers with appropriate mask depending on the no of channels deactivated. This is almost like doing another DMA init.
> - Secondly the security driver is active even before the dma library is initialed and hence it won't get the required reservation of channels which is bottleneck.
> - If both, dma library and security driver configure the DMA channels then, you end up in a problem because the way OMAP DMA hardware is.  Just a brief - "In
> contrast to the SDMA.DMA4_CSRi registers, the SDMA.DMA4_IRQSTATUS_Lj registers are updated regardless of the corresponding bits in the SDMA.DMA4_IRQENABLE_Lj registers". For more details, you can refer the DMA section in TRM. 
> Because of above, this is not seems to be an option. 

How about set up a cmdline option for omap dma for masking the
available channels?

Regards,

Tony
