From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Mon, 8 Nov 2010 08:45:38 -0800
Message-ID: <20101108164538.GJ9264@atomide.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
 <20101107220213.GB21070@kroah.com>
 <AANLkTin=reP=SJvo19=bPjYY2Owxa7a9EPKk-Jui97B4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62570 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab0KHQpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 11:45:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin=reP=SJvo19=bPjYY2Owxa7a9EPKk-Jui97B4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

* Felipe Contreras <felipe.contreras@gmail.com> [101107 14:38]:
> On Mon, Nov 8, 2010 at 12:02 AM, Greg KH <greg@kroah.com> wrote:
> > On Sun, Nov 07, 2010 at 11:43:24PM +0200, Felipe Contreras wrote:
> >> Paul already sent these, but I did some minor modifications, mostly to minimize
> >> the amount of changes.
> >>
> >> Also, I'm re-sending my memblock patch so that the driver can actually be
> >> compiled.
> >>
> >> With these, and reverting the iommu patches[1], the driver should be working. I
> >> don't see a more straight-forward way to achieve that.
> >
> > I can't take these through the staging tree unless I get an ack from the
> > omap maintainers.
> >
> > And as you are adding new infrastructure to the core kernel, this really
> > needed to be there before .37-rc1, I don't think it's acceptable to
> > merge this late in the development cycle.
> 
> Isn't that up to omap maintainers to decide?

Thanks for putting together all these patches, that already helps
people working on it a great deal.

However, these patches are in the no-no category for -rc cycle, they're
in the "fixes for features that never worked in the first place"
category. Linus will not take it and I don't want to take it. We just
have to follow the standard Linux development cycle.
 
> Anyway, there's an alternative that doesn't require omap to ack:
> 
> --- a/drivers/staging/tidspbridge/core/tiomap3430.c
> +++ b/drivers/staging/tidspbridge/core/tiomap3430.c
> @@ -23,7 +23,6 @@
>  #include <dspbridge/host_os.h>
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
> -#include <plat/control.h>
> 
>  /*  ----------------------------------- DSP/BIOS Bridge */
>  #include <dspbridge/dbdefs.h>
> @@ -74,6 +73,18 @@
>  #define PAGES_II_LVL_TABLE   512
>  #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
> 
> +/*
> + * This is a totally ugly layer violation, but needed until
> + * omap_ctrl_set_dsp_boot*() are provided.
> + */
> +#define OMAP3_IVA2_BOOTMOD_IDLE 1
> +#define OMAP2_CONTROL_GENERAL 0x270
> +#define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0x0190)
> +#define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x0194)
> +
> +#define OMAP343X_CTRL_REGADDR(reg) \
> +       OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> +
>  /* Forward Declarations: */
>  static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt);
>  static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,

If this makes the dspbridge usable, that sounds like the way to go
for the -rc cycle.

But I don't think this the only patch needed then?

Regards,

Tony
