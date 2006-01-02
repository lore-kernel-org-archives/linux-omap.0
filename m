From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem on mounting a jffs2 rootfs image
Date: Mon, 2 Jan 2006 10:31:08 -0800
Message-ID: <20060102183107.GH6034@atomide.com>
References: <43741c56.6400405c.6f4c.ffff87c0@mx.gmail.com>
	<43743DC9.1090702@de.bosch.com>
	<20051111173755.GC10822@atomide.com>
	<4374F44A.7080807@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4374F44A.7080807@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [051111 11:43]:
> Tony Lindgren wrote:
> >>Do you checked the thread "JFFS2 problem on OSK"
> >>
> >>http://linux.omap.com/pipermail/linux-omap-open-source/2005-July/004717.html
> >>
> >>?
> >
> >I wonder if there's any way to test for the OSK version? Then we could
> >check the timings.
> 
> Are there any OSKs out there which need different *CS3* timings? If not, 
> we only have to check for correct timings, something like:
> 
> --- ./arch/arm/mach-omap/omap1/board-osk.c_orig 2005-11-11 
> 20:22:40.628440008 +0100
> +++ ./arch/arm/mach-omap/omap1/board-osk.c      2005-11-11 
> 20:31:51.056762184 +0100
> @@ -192,8 +192,18 @@ static struct omap_board_config_kernel o
>         { OMAP_TAG_USB,           &osk_usb_config },
>  };
> 
> +#define EMFIS_CS3_VAL (0x30003361)
> +
>  static void __init osk_init(void)
>  {
> +        /* Workaround for wrong CS3 (NOR flash) timing
> +         * There are some U-Boot versions out there which configure
> +         * wrong CS3 memory timings. This mainly leads to CRC
> +         * or similiar errors if you use NOR flash (e.g. with JFFS2)
> +         */
> +        if(omap_readl(EMIFS_CS3_CONFIG) != EMFIS_CS3_VAL)
> +               omap_writel(EMFIS_CS3_VAL, EMIFS_CS3_CONFIG);
> +
>         osk_flash_resource.end = osk_flash_resource.start = 
> omap_cs3_phys();
>         osk_flash_resource.end += SZ_32M - 1;
>         platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));
> 
> 0x30003361 is the value used by spectrum digital. Seems to work. But I 
> don't think it's the fastest possible timing. Anybody with a better CS3 
> timing?

I think we should push this to avoid postings on JFFS2 problems. How
about changing the patch to use the EMIFS_CCS macro instead?

Regards,

Tony
