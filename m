From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 00/16] OMAP2+ OneNAND driver update
Date: Wed, 15 Nov 2017 10:10:03 +0200
Message-ID: <fd92bdae-faf4-d3b5-9771-37eb8a5ae412@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211206.465pgorrjp3eyix6@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org



On 2017-11-11 23:12, Ladislav Michl wrote:
> Hi there,
> =

> this patch serie updates OMAP2+ OneNAND driver to the present times, maki=
ng
> it fully DT configurable, using libgpio and dmaengine apis.
> =

> Please note that unlike previous driver version, which basically ignored
> DT specified timings, this one relies on it, so it is important to get
> it right in your DT (dumping it from previous kernel version).
> =

> In case synchronous timings is requested, it is okay to specify timings
> for the slowest chip ever used for you board as it is evetually optimized
> after chip probe.
> =

> Original driver used DMA only if user specified r/b gpio in platform
> data, now DMA is used unconditionally and PIO mode is used as fallback.
> =

> In case anyone wants to give it a try, few DT related changes are needed:
> - onenand node needs 'ti,omap2-onenand' compatible (for mailine boards th=
is is
>   done in patch 2)
> - to use R/B pin, rb-gpios needs to be specified (for n900 and n8x0 this =
is
>   done in patch 16, however patch lacks pinmux configuration.
> =

> Most notable changes from previous version:
> - added dmaengine patches by Peter Ujfalusi
> - added dt bindings documentation
> - added cleanup patches
> - DMA enabled by default
> =

> Also note that driver will fail probe OneNAND chip after patch 13 and sta=
rt
> working again after patch 14.

Thanks for the hard work!
to all:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Testing and benchmarking very welcome.
> =

> Depends on "memory: omap-gpmc: Make 'bank-width' property optional"
> https://patchwork.kernel.org/patch/10043259/
> =

> Ladislav Michl (13):
>   dt-bindings: mtd: gpmc-onenand: Update properties description
>   ARM: dts: OMAP2+: Add compatible property to onenand node
>   ARM: dts: omap3-igep: Update onenand node timings
>   mtd: onenand: omap2: Remove regulator support
>   mtd: onenand: omap2: Remove skip initial unlocking support
>   mtd: onenand: omap2: Remove partitioning support from platform data
>   mtd: onenand: omap2: Account waiting time as waiting on IO
>   mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA implementation
>   mtd: onenand: omap2: Do not make delay for GPIO OMAP3 specific
>   memory: omap-gpmc: Refactor OneNAND support
>   mtd: onenand: omap2: Configure driver from DT
>   ARM: OMAP2+: Remove gpmc-onenand
>   ARM: dts: Nokia: Use R/B pin
> =

> Peter Ujfalusi (2):
>   mtd: onenand: omap2: Simplify the DMA setup for various paths
>   mtd: onenand: omap2: Convert to use dmaengine for memcpy
> =

>  .../devicetree/bindings/mtd/gpmc-onenand.txt       |   6 +-
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   5 +-
>  arch/arm/boot/dts/omap3-igep.dtsi                  |  30 +-
>  arch/arm/boot/dts/omap3-n900.dts                   |   2 +
>  arch/arm/boot/dts/omap3-n950-n9.dtsi               |   1 +
>  arch/arm/boot/dts/omap3430-sdp.dts                 |   1 +
>  arch/arm/mach-omap2/Makefile                       |   3 -
>  arch/arm/mach-omap2/gpmc-onenand.c                 | 409 ---------------
>  drivers/memory/omap-gpmc.c                         | 158 ++++--
>  drivers/mtd/onenand/omap2.c                        | 580 ++++++++-------=
------
>  include/linux/omap-gpmc.h                          |  25 +
>  include/linux/platform_data/mtd-onenand-omap2.h    |  34 --
>  12 files changed, 389 insertions(+), 865 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.c
>  delete mode 100644 include/linux/platform_data/mtd-onenand-omap2.h
> =


- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
