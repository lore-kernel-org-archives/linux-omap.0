From: "Sin, David" <davidsin@ti.com>
Subject: RE: [RFC 0/8] TI TILER-DMM driver
Date: Wed, 28 Jul 2010 14:15:11 -0500
Message-ID: <513FF747EED39B4AADBB4D6C9D9F9F7903D64D7A92@dlee02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <201007241312.53551.hverkuil@xs4all.nl>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D64D76D5@dlee02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044EE51DF1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56576 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0G1TP2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 15:15:28 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EE51DF1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Hiremath, Vaibhav 
> Sent: Wednesday, July 28, 2010 12:31 PM
> To: Sin, David; Hans Verkuil
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Russell King; 
> Kanigeri, Hari; Ohad Ben-Cohen; Shilimkar, Santosh; 
> linux-arm-kernel@lists.infradead.org
> Subject: RE: [RFC 0/8] TI TILER-DMM driver
> 
> > -----Original Message-----
> > From: Sin, David
> > Sent: Wednesday, July 28, 2010 8:53 PM
> > To: Hans Verkuil
> > Cc: linux-omap@vger.kernel.org; Tony Lindgren; Russell 
> King; Kanigeri, Hari;
> > Ohad Ben-Cohen; Hiremath, Vaibhav; Shilimkar, Santosh; linux-arm-
> > kernel@lists.infradead.org
> > Subject: RE: [RFC 0/8] TI TILER-DMM driver
> > 
> > > -----Original Message-----
> > > From: Hans Verkuil [mailto:hverkuil@xs4all.nl]
> > > Sent: Saturday, July 24, 2010 6:13 AM
> > > To: Sin, David
> > > Cc: linux-arm-kernel@lists.arm.linux.org.uk;
> > > linux-omap@vger.kernel.org; Tony Lindgren; Russell King;
> > > Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; 
> Shilimkar, Santosh
> > > Subject: Re: [RFC 0/8] TI TILER-DMM driver
> > >
> > > Hi David,
> > >
> <snip>
> 
> > > The main question that I have is how this driver is to be
> > > used in practice.
> > > How does it fit into the bigger video4linux picture? Is this
> > > something that
> > > is mainly used from other v4l or fb drivers? Or is it
> > > controlled by userspace?
> > 
> > [dhs] I missed this one -- my apologies.  As I stated to 
> Vaibhav, any device
> > can use TILER memory, but there is a big advantage, 
> performance-wise, for 2-
> > Dimensional macro block based buffers.  This HW is intended 
> for image/video
> > hardware accelerators (e.g. OMAP4 IVA-HD).  Plus there's 
> the added advantage
> > of doing zero-copy flips and rotations for the OMAP display 
> and image sub-
> > systems.
> > 
> > In this RFC, there are only kernel APIs to allocate TILER memory.
> > Eventually, we would like to provide a way to obtain TILER 
> memory to the
> > user space.
> > 
> [Hiremath, Vaibhav] Don't you think, user has to mmap memory 
> (irrespective of whether it is tiles view or not) to userland 
> in both the cases, Fbdev and V4L2 (MMAP mode)?
> 
> Am I missing something here?
> 
> Thanks,
> Vaibhav
> 

[dhs] You're right; this is needed.  However, I first wanted to get some feedback for allocating 2-D memory just from kernel space.  

> > >
> > > Regards,
> > >
> > > 	Hans
> > >
> > > >
> > > > List of pending items in proposed order:
> > > >
> > > > * Add area packing support (multiple blocks can reside in
> > > the same band/area)
> > > >   to optimize area use
> > > > * Add group-ID support (to specify which blocks can reside
> > > together in the
> > > >   same area)
> > > > * Add multiple search directions to TCM-SiTA
> > > > * Add 1D block support (including adding 1D search algo 
> to TCM-SiTA)
> > > > * Optimize mutex handling (don.t hold mutex during memory
> > > >   allocation/mapping/cache flushing)
> > > > * Add block reference counting, support for sharing blocks
> > > > * Move all kernel-API-s to tiler-iface.c
> > > > * Support orphaned block support (in preparation for
> > > process cleanup support)
> > > > * Change block identification from physical address to 
> key-ID pair
> > > >   (in preparation for user space support, and process security)
> > > > * Add support for process security (blocks from separate
> > > processes never
> > > >   reside in the same band)
> > > > * Support file interface (ioctl and mmap)
> > > > * Support for buffers (ordered list of blocks that are
> > > mapped to userspace
> > > >   together, such as YUV420sp)
> > > > * Support 1D user buffer mapping into TILER container
> > > > * Support for block pre-reservation (to further 
> optimize area use)
> > > >
> > > > David Sin (1):
> > > >   TILER-DMM: DMM-PAT driver for TI TILER
> > > >
> > > > Lajos Molnar (6):
> > > >   TILER-DMM: Container manager interface and utility definitons
> > > >   TILER-DMM: TILER Memory Manager interface and implementation
> > > >   TILER-DMM: TILER interface file and documentation
> > > >   TILER-DMM: Geometry and view manipulation functions.
> > > >   TILER-DMM: Main TILER driver implementation.
> > > >   TILER-DMM: Linking TILER driver into the Linux kernel build
> > > >
> > > > Ravi Ramachandra (1):
> > > >   TILER-DMM: Sample TCM implementation: Simple TILER Allocator
> > > >
> > > >  Documentation/arm/TILER                   |  144 +++++++++
> > > >  arch/arm/mach-omap2/include/mach/dmm.h    |  128 ++++++++
> > > >  arch/arm/mach-omap2/include/mach/tiler.h  |  201 +++++++++++++
> > > >  drivers/media/Kconfig                     |    6 +
> > > >  drivers/media/Makefile                    |    2 +
> > > >  drivers/media/video/tiler/Kconfig         |   65 ++++
> > > >  drivers/media/video/tiler/Makefile        |    7 +
> > > >  drivers/media/video/tiler/_tiler.h        |   51 ++++
> > > >  drivers/media/video/tiler/dmm.c           |  200 +++++++++++++
> > > >  drivers/media/video/tiler/tcm.h           |  209 +++++++++++++
> > > >  drivers/media/video/tiler/tcm/Makefile    |    1 +
> > > >  drivers/media/video/tiler/tcm/_tcm-sita.h |   64 ++++
> > > >  drivers/media/video/tiler/tcm/tcm-sita.c  |  459
> > > +++++++++++++++++++++++++++++
> > > >  drivers/media/video/tiler/tcm/tcm-sita.h  |   37 +++
> > > >  drivers/media/video/tiler/tcm/tcm-utils.h |   54 ++++
> > > >  drivers/media/video/tiler/tiler-geom.c    |  360
> > > ++++++++++++++++++++++
> > > >  drivers/media/video/tiler/tiler-iface.c   |  106 +++++++
> > > >  drivers/media/video/tiler/tiler-main.c    |  426
> > > ++++++++++++++++++++++++++
> > > >  drivers/media/video/tiler/tmm-pat.c       |  274 
> +++++++++++++++++
> > > >  drivers/media/video/tiler/tmm.h           |  109 +++++++
> > > >  20 files changed, 2903 insertions(+), 0 deletions(-)
> > > >  create mode 100644 Documentation/arm/TILER
> > > >  create mode 100644 arch/arm/mach-omap2/include/mach/dmm.h
> > > >  create mode 100644 arch/arm/mach-omap2/include/mach/tiler.h
> > > >  create mode 100644 drivers/media/video/tiler/Kconfig
> > > >  create mode 100644 drivers/media/video/tiler/Makefile
> > > >  create mode 100644 drivers/media/video/tiler/_tiler.h
> > > >  create mode 100644 drivers/media/video/tiler/dmm.c
> > > >  create mode 100644 drivers/media/video/tiler/tcm.h
> > > >  create mode 100644 drivers/media/video/tiler/tcm/Makefile
> > > >  create mode 100644 drivers/media/video/tiler/tcm/_tcm-sita.h
> > > >  create mode 100644 drivers/media/video/tiler/tcm/tcm-sita.c
> > > >  create mode 100644 drivers/media/video/tiler/tcm/tcm-sita.h
> > > >  create mode 100644 drivers/media/video/tiler/tcm/tcm-utils.h
> > > >  create mode 100644 drivers/media/video/tiler/tiler-geom.c
> > > >  create mode 100644 drivers/media/video/tiler/tiler-iface.c
> > > >  create mode 100644 drivers/media/video/tiler/tiler-main.c
> > > >  create mode 100644 drivers/media/video/tiler/tmm-pat.c
> > > >  create mode 100644 drivers/media/video/tiler/tmm.h
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-omap" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> > > >
> > > >
> > >
> > > --
> > > Hans Verkuil - video4linux developer - sponsored by TANDBERG,
> > > part of Cisco
> > >
> 