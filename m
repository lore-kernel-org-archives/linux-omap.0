From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] RFC: OMAP Synchronous Serial Interface (SSI)
	driver (take II)
Date: Fri, 3 Oct 2008 13:34:39 +0300
Message-ID: <20081003103437.GG25482@atomide.com>
References: <1221575400.6315.227.camel@groo.research.nokia.com> <1223029515.32631.148.camel@groo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65304 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYJCKbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 06:31:42 -0400
Content-Disposition: inline
In-Reply-To: <1223029515.32631.148.camel@groo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-omap@vger.kernel.org

* Carlos Chinea <carlos.chinea@nokia.com> [081003 13:26]:
> Hi guys !
> 
> A couple of weeks ago, I sent a set of patches for comments.
> I am sending a new set of those patches with debug statements removed and a bug fix.
> 
> The new patch set is based on linux-omap 2.6.27-rc7
> 
> Any comments will be appreciated.

You should send this to LKML, and cc linux-omap to get proper review
of these patches.

Tony

> 
> Br,
> Carlos
> 
>  Documentation/arm/OMAP/ssi/board-ssi.c.example     |  216 ++++++++
>  Documentation/arm/OMAP/ssi/ssi                     |  232 +++++++++
>  arch/arm/plat-omap/include/mach/ssi/ssi_gdd_reg.h  |  145 ++++++
>  .../plat-omap/include/mach/ssi/ssi_reg_common.h    |   73 +++
>  arch/arm/plat-omap/include/mach/ssi/ssi_ssr_reg.h  |   56 +++
>  arch/arm/plat-omap/include/mach/ssi/ssi_sst_reg.h  |   65 +++
>  arch/arm/plat-omap/include/mach/ssi/ssi_sys_reg.h  |  107 ++++
>  drivers/misc/Kconfig                               |    2 +
>  drivers/misc/Makefile                              |    1 +
>  drivers/misc/ssi/Kconfig                           |   11 +
>  drivers/misc/ssi/Makefile                          |    7 +
>  drivers/misc/ssi/ssi_driver.c                      |  513 ++++++++++++++++++++
>  drivers/misc/ssi/ssi_driver.h                      |  211 ++++++++
>  drivers/misc/ssi/ssi_driver_bus.c                  |  192 ++++++++
>  drivers/misc/ssi/ssi_driver_dma.c                  |  406 ++++++++++++++++
>  drivers/misc/ssi/ssi_driver_if.c                   |  335 +++++++++++++
>  drivers/misc/ssi/ssi_driver_int.c                  |  232 +++++++++
>  include/linux/ssi_driver_if.h                      |  137 ++++++
>  18 files changed, 2941 insertions(+), 0 deletions(-)
> 
> 
> On Tue, 2008-09-16 at 17:30 +0300, ext Carlos Chinea wrote:
> > Hi guys !
> > 
> > I'm working on adding support for Nokia HSPA modems to OMAP.
> > 
> > Please consider integrating the following patch set into the
> > linux-omap tree. The patch set implements a generic device driver
> > for the OMAP Synchronous Serial Interface. 
> > 
> > The Synchronous Serial Interface (SSI) is a high speed communication
> > interface that is used for connecting OMAP to a cellular modem engine.
> > 
> > The patch set is based on linux-omap 2.6.27-rc6.
> > 
> > Any comments will be appreciated.
> > 
> > Br,
> > Carlos
> > 
> >  Documentation/arm/OMAP/ssi/board-ssi.c.example       |  216 +++++++
> >  Documentation/arm/OMAP/ssi/ssi                       |  233 +++++++
> >  arch/arm/plat-omap/include/mach/ssi/ssi_gdd_reg.h    |  145 ++++
> >  arch/arm/plat-omap/include/mach/ssi/ssi_reg_common.h |   73 ++
> >  arch/arm/plat-omap/include/mach/ssi/ssi_ssr_reg.h    |   56 +
> >  arch/arm/plat-omap/include/mach/ssi/ssi_sst_reg.h    |   65 ++
> >  arch/arm/plat-omap/include/mach/ssi/ssi_sys_reg.h    |  108 +++
> >  drivers/misc/Kconfig                                 |    2 
> >  drivers/misc/Makefile                                |    2 
> >  drivers/misc/ssi/Kconfig                             |   20 
> >  drivers/misc/ssi/Makefile                            |   11 
> >  drivers/misc/ssi/ssi_driver.c                        |  572 +++++++++++++++++++
> >  drivers/misc/ssi/ssi_driver.h                        |  228 +++++++
> >  drivers/misc/ssi/ssi_driver_bus.c                    |  218 +++++++
> >  drivers/misc/ssi/ssi_driver_dma.c                    |  461 +++++++++++++++
> >  drivers/misc/ssi/ssi_driver_if.c                     |  374 ++++++++++++
> >  drivers/misc/ssi/ssi_driver_int.c                    |  296 +++++++++
> >  include/linux/ssi_driver_if.h                        |  138 ++++
> >  18 files changed, 3213 insertions(+), 5 deletions(-)
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
