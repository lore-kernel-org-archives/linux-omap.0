From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Mon, 8 Nov 2010 11:16:49 -0800
Message-ID: <20101108191648.GR9264@atomide.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
 <20101107220213.GB21070@kroah.com>
 <AANLkTin=reP=SJvo19=bPjYY2Owxa7a9EPKk-Jui97B4@mail.gmail.com>
 <20101108164538.GJ9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60823 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab0KHTQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 14:16:57 -0500
Content-Disposition: inline
In-Reply-To: <20101108164538.GJ9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

* Tony Lindgren <tony@atomide.com> [101108 08:37]:
> * Felipe Contreras <felipe.contreras@gmail.com> [101107 14:38]:
> 
> Thanks for putting together all these patches, that already helps
> people working on it a great deal.
> 
> However, these patches are in the no-no category for -rc cycle, they're
> in the "fixes for features that never worked in the first place"
> category. Linus will not take it and I don't want to take it. We just
> have to follow the standard Linux development cycle.
>  
> > Anyway, there's an alternative that doesn't require omap to ack:
> > 
> > --- a/drivers/staging/tidspbridge/core/tiomap3430.c
> > +++ b/drivers/staging/tidspbridge/core/tiomap3430.c
> > @@ -23,7 +23,6 @@
> >  #include <dspbridge/host_os.h>
> >  #include <linux/mm.h>
> >  #include <linux/mmzone.h>
> > -#include <plat/control.h>
> > 
> >  /*  ----------------------------------- DSP/BIOS Bridge */
> >  #include <dspbridge/dbdefs.h>
> > @@ -74,6 +73,18 @@
> >  #define PAGES_II_LVL_TABLE   512
> >  #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
> > 
> > +/*
> > + * This is a totally ugly layer violation, but needed until
> > + * omap_ctrl_set_dsp_boot*() are provided.
> > + */
> > +#define OMAP3_IVA2_BOOTMOD_IDLE 1
> > +#define OMAP2_CONTROL_GENERAL 0x270
> > +#define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0x0190)
> > +#define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x0194)
> > +
> > +#define OMAP343X_CTRL_REGADDR(reg) \
> > +       OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> > +
> >  /* Forward Declarations: */
> >  static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt);
> >  static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,
> 
> If this makes the dspbridge usable, that sounds like the way to go
> for the -rc cycle.
> 
> But I don't think this the only patch needed then?

I guess it would be this fix + omap: dsp: remove shm from normal memory +
revert some drivers/staging/tidspbridge patches?

It's still quite a bit of patches for the -rc cycle..

If you want, I can keep merging your branch into linux-omap master
branch for testing while we're waiting for the next merge window. 

Regards,

Tony
