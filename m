From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC v2 0/8] TI DMM-TILER driver
Date: Wed, 1 Dec 2010 12:17:22 +0530
Message-ID: <AANLkTi=39XEC9ie=bAapymAtx6k+ej49N5B1+_gfRhmE@mail.gmail.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291147139-23472-1-git-send-email-davidsin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 1, 2010 at 01:28, David Sin <davidsin@ti.com> wrote:
> Tiling and Isometric Lightweight Engine for Rotation (TILER) driver
>
> Dynamic Memory Manager (DMM) is a hardware block made by Texas Instru=
ments.
> Within the DMM exists at least one TILER hardware component. =A0Its p=
urpose is to
> organize video/image memory in a 2-dimensional fashion to limit memor=
y
> bandwidth and facilitate 0 effort rotation and mirroring. =A0The TILE=
R driver
> facilitates allocating, freeing, as well as mapping 2D blocks (areas)=
 in the
> TILER container(s). =A0It also facilitates rotating and mirroring the=
 allocated
> blocks or its rectangular subsections.
>
> TERMINOLOGY
>
> "slot"
>
> The basic TILER driver operates on blocks of slots. =A0A slot is the =
granularity
> of the TILER hardware device. =A0For all current uses it is 4K, but c=
ould also be
> 16 or 64K. =A0The DMM-TILER TRM refers to this as "page" but we want =
to separate
> this concept from the MMU pages.
>
> "page"
>
> The granularity of the MMU, used by the kernel. =A0This is 4K.
>
> "block"
>
> The TILER hardware component supports 1D and 2D blocks. =A0A 2D block=
 is a
> rectangular arrangement of slots with arbitrary width and height in a=
 2D
> container. =A0A 1D block is a linear arrangement of slots with arbitr=
ary length
> =A0in a 1D container. =A0This TILER driver only supports 2D blocks.
>
> "container"
>
> The TILER driver supports an arbitrary TILER container size. =A0Howev=
er, for
> all current implementations it is 256 by 128 slots. =A0The container =
currently can
> only be used as a 2D container.
>
> "reserved area"
>
> Each block resides within a reserved area in the container. =A0This a=
rea may
> be larger than the actual set of slots that a block occupies. =A0The =
reason for
> this is to protect access from one block into another. =A0Since TILER=
 container is
> mmap-ped into user space as individual pages, all slots that are span=
ned by
> that page become visible to the user. =A0The tiler driver allows rest=
ricting the
> granularity of the reserved area (default alignment) as well as the m=
apped
> area (granularity).
>
> Changes made from RFC v1: http://www.spinics.net/lists/linux-omap/msg=
33867.html
>
> Santosh Shilimkar:
> 1) Correct documentation location
> 2) Remove ioremap of RAM
> 3) Implement probe function and hwmod
> 4) Correct commenting style
> 5) Reduce use of barrier instances
>
> Linus Walleij:
> 1) Define TCM acryonym
>
> Russell King:
> 1) Implement probe function
> 2) Fix spelling mistake
> 3) Remove GFP_ATOMIC flag when calling dma_alloc_coherent for PAT arr=
ay mem
> 4) Replace alloc_page and flush range calls with dma_alloc_coherent
>
> Nishanth Menon:
> 1) Address infinite while loop when reading dmm register
>
> Benoit Cousson:
> 1) Fix source file headers
> 2) Correct logical errors in device file
>
> Kevin Hilman:
> 1) Move DMM/TILER source code into driver/misc/tiler until a recommen=
dation
> is made as to where it should go
>
> List of pending items in proposed order:
>
> * Determine driver source code location
> =A0(Currently, resides in drivers/misc/tiler)
> * Add area packing support (multiple blocks can reside in the same ba=
nd/area)
> =A0to optimize area use
> * Add group-ID support (to specify which blocks can reside together i=
n the
> =A0same area)
> * Add multiple search directions to TCM-SiTA
> * Add 1D block support (including adding 1D search algo to TCM-SiTA)
> * Optimize mutex handling (don.t hold mutex during memory
> =A0allocation/mapping/cache flushing)
> * Add block reference counting, support for sharing blocks
> * Move all kernel-API-s to tiler-iface.c
> * Support orphaned block support (in preparation for process cleanup =
support)
> * Change block identification from physical address to key-ID pair
> =A0(in preparation for user space support, and process security)
> * Add support for process security (blocks from separate processes ne=
ver
> =A0reside in the same band)
> * Support file interface (ioctl and mmap)
> * Support for buffers (ordered list of blocks that are mapped to user=
space
> =A0together, such as YUV420sp)
> * Support 1D user buffer mapping into TILER container
> * Support for block pre-reservation (to further optimize area use)
>
> David Sin (1):
> =A0TILER-DMM: DMM-PAT driver for TI TILER
>
> Lajos Molnar (6):
> =A0TILER-DMM: Container manager interface and utility definitons
> =A0TILER-DMM: TILER Memory Manager interface and implementation
> =A0TILER-DMM: TILER interface file and documentation
> =A0TILER-DMM: Geometry and view manipulation functions
> =A0TILER-DMM: Main TILER driver implementation
> =A0TILER-DMM: Linking TILER driver into the Linux kernel build
>
> Ravi Ramachandra (1):
> =A0TILER-DMM: Sample TCM implementation: Simple TILER Allocator (SiTA=
)
>
> =A0Documentation/arm/OMAP/TILER =A0 =A0 =A0 =A0 =A0 =A0 | =A0126 ++++=
+++++
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/dmm-omap44xx.c =A0 =A0 =A0 | =A0 81 ++++++
> =A0arch/arm/mach-omap2/include/mach/dmm.h =A0 | =A0 92 +++++++
> =A0arch/arm/mach-omap2/include/mach/tiler.h | =A0173 ++++++++++++
> =A0drivers/misc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A05 +
> =A0drivers/misc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A0drivers/misc/tiler/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 72 ++=
+++
> =A0drivers/misc/tiler/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 =
+
> =A0drivers/misc/tiler/_tiler.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 48 ++=
++
> =A0drivers/misc/tiler/dmm-main.c =A0 =A0 =A0 =A0 =A0 =A0| =A0187 ++++=
+++++++++
> =A0drivers/misc/tiler/tcm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0171 =
++++++++++++
> =A0drivers/misc/tiler/tcm/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/misc/tiler/tcm/_tcm-sita.h =A0 =A0 =A0 | =A0 61 +++++
> =A0drivers/misc/tiler/tcm/tcm-sita.c =A0 =A0 =A0 =A0| =A0422 ++++++++=
++++++++++++++++++++++
> =A0drivers/misc/tiler/tcm/tcm-sita.h =A0 =A0 =A0 =A0| =A0 28 ++
> =A0drivers/misc/tiler/tcm/tcm-utils.h =A0 =A0 =A0 | =A0 51 ++++
> =A0drivers/misc/tiler/tiler-geom.c =A0 =A0 =A0 =A0 =A0| =A0362 ++++++=
+++++++++++++++++++
> =A0drivers/misc/tiler/tiler-iface.c =A0 =A0 =A0 =A0 | =A0 66 +++++
> =A0drivers/misc/tiler/tiler-main.c =A0 =A0 =A0 =A0 =A0| =A0405 ++++++=
++++++++++++++++++++++
> =A0drivers/misc/tiler/tmm-pat.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0266 ++++=
+++++++++++++++
> =A0drivers/misc/tiler/tmm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0103 =
++++++++
> =A022 files changed, 2729 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/arm/OMAP/TILER
> =A0create mode 100644 arch/arm/mach-omap2/dmm-omap44xx.c
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/dmm.h
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/tiler.h
> =A0create mode 100644 drivers/misc/tiler/Kconfig
> =A0create mode 100644 drivers/misc/tiler/Makefile
> =A0create mode 100644 drivers/misc/tiler/_tiler.h
> =A0create mode 100644 drivers/misc/tiler/dmm-main.c
> =A0create mode 100644 drivers/misc/tiler/tcm.h
> =A0create mode 100644 drivers/misc/tiler/tcm/Makefile
> =A0create mode 100644 drivers/misc/tiler/tcm/_tcm-sita.h
> =A0create mode 100644 drivers/misc/tiler/tcm/tcm-sita.c
> =A0create mode 100644 drivers/misc/tiler/tcm/tcm-sita.h
> =A0create mode 100644 drivers/misc/tiler/tcm/tcm-utils.h
> =A0create mode 100644 drivers/misc/tiler/tiler-geom.c
> =A0create mode 100644 drivers/misc/tiler/tiler-iface.c
> =A0create mode 100644 drivers/misc/tiler/tiler-main.c
> =A0create mode 100644 drivers/misc/tiler/tmm-pat.c
> =A0create mode 100644 drivers/misc/tiler/tmm.h

The dmm driver is making use of omap_hwmod fw. But I could not see a pa=
tch
to add  dmm hwmod data to omap4 hwmod base in this series. Is this patc=
h series
tested?
