From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC 0/8] TI TILER-DMM driver
Date: Sat, 24 Jul 2010 13:12:53 +0200
Message-ID: <201007241312.53551.hverkuil@xs4all.nl>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr18.xs4all.nl ([194.109.24.38]:3709 "EHLO
	smtp-vbr18.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab0GXLXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 07:23:32 -0400
In-Reply-To: <1279927348-21750-1-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <rmk@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi David,

On Saturday 24 July 2010 01:22:20 David Sin wrote:
> TILER is a hardware block made by Texas Instruments.  Its purpose is to 
> organize video/image memory in a 2-dimensional fashion to limit memory 
> bandwidth and facilitate 0 effort rotation and mirroring.  The TILER 
> driver facilitates allocating, freeing, as well as mapping 2D blocks (areas) 
> in the TILER container(s).  It also facilitates rotating and mirroring 
> the allocated blocks or its rectangular subsections.

Since this driver is part of the media/video subsystem you should cross-post
it to the linux-media mailinglist as well.

The main question that I have is how this driver is to be used in practice.
How does it fit into the bigger video4linux picture? Is this something that
is mainly used from other v4l or fb drivers? Or is it controlled by userspace?

Regards,

	Hans

> 
> List of pending items in proposed order:
> 
> * Add area packing support (multiple blocks can reside in the same band/area)
>   to optimize area use
> * Add group-ID support (to specify which blocks can reside together in the
>   same area)
> * Add multiple search directions to TCM-SiTA
> * Add 1D block support (including adding 1D search algo to TCM-SiTA)
> * Optimize mutex handling (don.t hold mutex during memory
>   allocation/mapping/cache flushing)
> * Add block reference counting, support for sharing blocks
> * Move all kernel-API-s to tiler-iface.c
> * Support orphaned block support (in preparation for process cleanup support)
> * Change block identification from physical address to key-ID pair
>   (in preparation for user space support, and process security)
> * Add support for process security (blocks from separate processes never
>   reside in the same band)
> * Support file interface (ioctl and mmap)
> * Support for buffers (ordered list of blocks that are mapped to userspace
>   together, such as YUV420sp)
> * Support 1D user buffer mapping into TILER container
> * Support for block pre-reservation (to further optimize area use)
> 
> David Sin (1):
>   TILER-DMM: DMM-PAT driver for TI TILER
> 
> Lajos Molnar (6):
>   TILER-DMM: Container manager interface and utility definitons
>   TILER-DMM: TILER Memory Manager interface and implementation
>   TILER-DMM: TILER interface file and documentation
>   TILER-DMM: Geometry and view manipulation functions.
>   TILER-DMM: Main TILER driver implementation.
>   TILER-DMM: Linking TILER driver into the Linux kernel build
> 
> Ravi Ramachandra (1):
>   TILER-DMM: Sample TCM implementation: Simple TILER Allocator
> 
>  Documentation/arm/TILER                   |  144 +++++++++
>  arch/arm/mach-omap2/include/mach/dmm.h    |  128 ++++++++
>  arch/arm/mach-omap2/include/mach/tiler.h  |  201 +++++++++++++
>  drivers/media/Kconfig                     |    6 +
>  drivers/media/Makefile                    |    2 +
>  drivers/media/video/tiler/Kconfig         |   65 ++++
>  drivers/media/video/tiler/Makefile        |    7 +
>  drivers/media/video/tiler/_tiler.h        |   51 ++++
>  drivers/media/video/tiler/dmm.c           |  200 +++++++++++++
>  drivers/media/video/tiler/tcm.h           |  209 +++++++++++++
>  drivers/media/video/tiler/tcm/Makefile    |    1 +
>  drivers/media/video/tiler/tcm/_tcm-sita.h |   64 ++++
>  drivers/media/video/tiler/tcm/tcm-sita.c  |  459 +++++++++++++++++++++++++++++
>  drivers/media/video/tiler/tcm/tcm-sita.h  |   37 +++
>  drivers/media/video/tiler/tcm/tcm-utils.h |   54 ++++
>  drivers/media/video/tiler/tiler-geom.c    |  360 ++++++++++++++++++++++
>  drivers/media/video/tiler/tiler-iface.c   |  106 +++++++
>  drivers/media/video/tiler/tiler-main.c    |  426 ++++++++++++++++++++++++++
>  drivers/media/video/tiler/tmm-pat.c       |  274 +++++++++++++++++
>  drivers/media/video/tiler/tmm.h           |  109 +++++++
>  20 files changed, 2903 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/arm/TILER
>  create mode 100644 arch/arm/mach-omap2/include/mach/dmm.h
>  create mode 100644 arch/arm/mach-omap2/include/mach/tiler.h
>  create mode 100644 drivers/media/video/tiler/Kconfig
>  create mode 100644 drivers/media/video/tiler/Makefile
>  create mode 100644 drivers/media/video/tiler/_tiler.h
>  create mode 100644 drivers/media/video/tiler/dmm.c
>  create mode 100644 drivers/media/video/tiler/tcm.h
>  create mode 100644 drivers/media/video/tiler/tcm/Makefile
>  create mode 100644 drivers/media/video/tiler/tcm/_tcm-sita.h
>  create mode 100644 drivers/media/video/tiler/tcm/tcm-sita.c
>  create mode 100644 drivers/media/video/tiler/tcm/tcm-sita.h
>  create mode 100644 drivers/media/video/tiler/tcm/tcm-utils.h
>  create mode 100644 drivers/media/video/tiler/tiler-geom.c
>  create mode 100644 drivers/media/video/tiler/tiler-iface.c
>  create mode 100644 drivers/media/video/tiler/tiler-main.c
>  create mode 100644 drivers/media/video/tiler/tmm-pat.c
>  create mode 100644 drivers/media/video/tiler/tmm.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG, part of Cisco
