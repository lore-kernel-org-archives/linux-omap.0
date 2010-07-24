From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC 0/8] TI TILER-DMM driver
Date: Sat, 24 Jul 2010 13:14:40 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6255358@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55840 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab0GXHpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 03:45:03 -0400
In-Reply-To: <1279927348-21750-1-git-send-email-davidsin@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

David, 
> -----Original Message-----
> From: Sin, David
> Sent: Saturday, July 24, 2010 4:52 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org;
> Tony Lindgren; Russell King
> Cc: Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; Shilimkar, Santosh;
> Sin, David
> Subject: [RFC 0/8] TI TILER-DMM driver
> 
> TILER is a hardware block made by Texas Instruments.  Its purpose is to
> organize video/image memory in a 2-dimensional fashion to limit memory
> bandwidth and facilitate 0 effort rotation and mirroring.  The TILER
> driver facilitates allocating, freeing, as well as mapping 2D blocks
> (areas)
> in the TILER container(s).  It also facilitates rotating and mirroring
> the allocated blocks or its rectangular subsections.
> 
> List of pending items in proposed order:
> 
> * Add area packing support (multiple blocks can reside in the same
> band/area)
>   to optimize area use
> * Add group-ID support (to specify which blocks can reside together in the
>   same area)
> * Add multiple search directions to TCM-SiTA
> * Add 1D block support (including adding 1D search algo to TCM-SiTA)
> * Optimize mutex handling (don.t hold mutex during memory
>   allocation/mapping/cache flushing)
> * Add block reference counting, support for sharing blocks
> * Move all kernel-API-s to tiler-iface.c
> * Support orphaned block support (in preparation for process cleanup
> support)
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
I am just summarizing some of my comments here

1. linux-arm-kernel@lists.arm.linux.org.uk is not operational anymore. The
current list is linux-arm-kernel@lists.infradead.org

2. Thanks for the Documentation patch. Just take care of correct directory for same

3. iormap on RAM will be prohibited. Russell has a patch in the queue so
	we need to look at the alternative.
4. You haven't implemented probe fuction in both of your diver and doing
all work in init itself. You might want to revisit that

5. DMM register info is auto-generated thanks to Benoit. We can use that directly.

6. There are too many header files(8-9) and I think you can re-organise all of them to manage with 3-4

7. Commenting style is not consistent in all patches and does not follow
linux style in few places

8. The DMM driver registration can be done using omap_device framework as
is being done for most of the OMAP4 drivers.

9. Error handling can be improved

10. There is an excessive usage of barriers and may be we can keep 
only the necessary ones.

Thanks for the tiler port.

Regards,
Santosh
