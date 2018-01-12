From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v6 00/14] OMAP2+ OneNAND driver update
Date: Fri, 12 Jan 2018 15:03:15 +0100
Message-ID: <20180112150315.54214fab@bbrezillon>
References: <20180112131105.GA13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180112131105.GA13810@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Fri, 12 Jan 2018 14:11:05 +0100
Ladislav Michl <ladis@linux-mips.org> wrote:

> this patch serie updates OMAP2+ OneNAND driver to the present times, making
> it fully DT configurable, using libgpio and dmaengine apis.
> 
> Please note that unlike previous driver version, which basically ignored
> DT specified timings, this one relies on it, so it is important to get
> it right in your DT (dumping it from previous kernel version).
> 
> In case synchronous timings is requested, it is okay to specify timings
> for the slowest chip ever used for you board as it is evetually optimized
> after chip probe.
> 
> Original driver used DMA only if user specified INT gpio in platform
> data, now DMA is used unconditionally and PIO mode is used as fallback.
> 
> In case anyone wants to give it a try, few DT related changes are needed:
> - onenand node needs 'ti,omap2-onenand' compatible (for mailine boards this is
>   done in patch 2)
> - to use INT pin, int-gpios needs to be specified.

Roger, Tony, are you happy with this version? If this is the case, I'll
queue all patches to my nand/next branch (after merging Roger's
immutable branch in).

> 
> Most notable changes from v3:
> - added dmaengine patches by Peter Ujfalusi
> - added dt bindings documentation
> - added cleanup patches
> - DMA enabled by default
> 
> Most notable changes from v4:
> - collected tags
> - used INT pin name properly
> - hopefully all comments taken into account
> 
> Most notable changes from v5:
> - as this serie is expected to be merged via single tree patches 13 and 14
>   were squashed together not to break bisecting.
> - patch 16 was dropped.
> 
> This patchset depends on an immutable commit:
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/rogerq/linux.git for-v4.16/gpmc-omap-immutable
> 
> for you to fetch changes up to c18a7ac3398d0cef29749f9568666db8321aa4c9:
> 
>   memory: omap-gpmc: Make 'bank-width' property optional (2017-12-01 15:37:49 +0200)
> 
> 
> Ladislav Michl (12):
>   dt-bindings: mtd: gpmc-onenand: Update properties description
>   ARM: dts: OMAP2+: Add compatible property to onenand node
>   ARM: dts: omap3-igep: Update onenand node timings
>   mtd: onenand: omap2: Remove regulator support
>   mtd: onenand: omap2: Remove skip initial unlocking support
>   mtd: onenand: omap2: Remove partitioning support from platform data
>   mtd: onenand: omap2: Account waiting time as waiting on IO
>   mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA implementation
>   mtd: onenand: omap2: Do not make delay for GPIO OMAP3 specific
>   mtd: onenand: omap2: Decouple DMA enabling from INT pin availability
>   mtd: onenand: omap2: Configure driver from DT
>   ARM: OMAP2+: Remove gpmc-onenand
> 
> Peter Ujfalusi (2):
>   mtd: onenand: omap2: Simplify the DMA setup for various paths
>   mtd: onenand: omap2: Convert to use dmaengine for memcpy
> 
>  .../devicetree/bindings/mtd/gpmc-onenand.txt       |   6 +-
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   1 +
>  arch/arm/boot/dts/omap3-igep.dtsi                  |  30 +-
>  arch/arm/boot/dts/omap3-n900.dts                   |   1 +
>  arch/arm/boot/dts/omap3-n950-n9.dtsi               |   1 +
>  arch/arm/boot/dts/omap3430-sdp.dts                 |   1 +
>  arch/arm/mach-omap2/Makefile                       |   3 -
>  arch/arm/mach-omap2/gpmc-onenand.c                 | 409 ---------------
>  drivers/memory/omap-gpmc.c                         | 158 ++++--
>  drivers/mtd/onenand/Kconfig                        |   4 +-
>  drivers/mtd/onenand/omap2.c                        | 576 ++++++++-------------
>  include/linux/omap-gpmc.h                          |  28 +
>  include/linux/platform_data/mtd-onenand-omap2.h    |  34 --
>  13 files changed, 386 insertions(+), 866 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.c
>  delete mode 100644 include/linux/platform_data/mtd-onenand-omap2.h
> 


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
