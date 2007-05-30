From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [RFC] io.c for OMAP3430
Date: Wed, 30 May 2007 12:17:08 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701062B73@dlee13.ent.ti.com>
References: <20070530134148.GD28353@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070530134148.GD28353@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

>Well I was thinking we'd have different structs:

Is this fine?

#ifdef CONFIG_ARCH_OMAP24XX
static struct map_desc omap24xx_io_desc[] __initdata =3D {
	{
		.virtual	=3D L3_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(L3_24XX_PHYS),
		.length		=3D L3_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_24XX_PHYS),
		.length		=3D L4_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
};

#ifdef CONFIG_ARCH_OMAP242X
static struct map_desc omap242x_io_desc[] __initdata =3D {
	{
		.virtual	=3D DSP_MEM_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
		.length		=3D DSP_MEM_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D DSP_IPI_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
		.length		=3D DSP_IPI_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D DSP_MMU_24XX_VIRT,
		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
		.length		=3D DSP_MMU_24XX_SIZE,
		.type		=3D MT_DEVICE
	},
};

static struct map_desc omap243x_io_desc[] =3D {};
#endif

#ifdef CONFIG_ARCH_OMAP2430
static struct map_desc omap242x_io_desc[] =3D {};

static struct map_desc omap243x_io_desc[] __initdata =3D {
	{
		.virtual	=3D L4_WK_243X_VIRT,
		.pfn		=3D __phys_to_pfn(L4_WK_243X_PHYS),
		.length		=3D L4_WK_243X_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP243X_GPMC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP243X_GPMC_PHYS),
		.length		=3D OMAP243X_GPMC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP243X_SDRC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP243X_SDRC_PHYS),
		.length		=3D OMAP243X_SDRC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP243X_SMS_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP243X_SMS_PHYS),
		.length		=3D OMAP243X_SMS_SIZE,
		.type		=3D MT_DEVICE
	},
};
#endif

static struct map_desc omap34xx_io_desc[] =3D {};
#endif

#ifdef	CONFIG_ARCH_OMAP34XX
static struct map_desc omap24xx_io_desc[] =3D {};
static struct map_desc omap242x_io_desc[] =3D {};
static struct map_desc omap243x_io_desc[] =3D {};

static struct map_desc omap34xx_io_desc[] __initdata =3D {
	{
		.virtual	=3D L3_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L3_34XX_PHYS),
		.length		=3D L3_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_34XX_PHYS),
		.length		=3D L4_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_WK_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_WK_34XX_PHYS),
		.length		=3D L4_WK_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP34XX_GPMC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP34XX_GPMC_PHYS),
		.length		=3D OMAP34XX_GPMC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP343X_SMS_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP343X_SMS_PHYS),
		.length		=3D OMAP343X_SMS_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D OMAP343X_SDRC_VIRT,
		.pfn		=3D __phys_to_pfn(OMAP343X_SDRC_PHYS),
		.length		=3D OMAP343X_SDRC_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_PER_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_PER_34XX_PHYS),
		.length		=3D L4_PER_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
	{
		.virtual	=3D L4_EMU_34XX_VIRT,
		.pfn		=3D __phys_to_pfn(L4_EMU_34XX_PHYS),
		.length		=3D L4_EMU_34XX_SIZE,
		.type		=3D MT_DEVICE
	},
};
#endif

void __init omap2_map_common_io(void)
{
	if (cpu_is_omap24xx()) {
		iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
		if (cpu_is_omap242x()) {
			iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
		} else if (cpu_is_omap243x()) {
			iotable_init(omap243x_io_desc, ARRAY_SIZE(omap243x_io_desc));
		}
	} else if (cpu_is_omap34xx()) {
		iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
	}
...
..
.

}

If I don't add dummy arrays for other platforms then compilation will =
break and we will end up adding more ifdefs in common_io() function.

Regards,
Khasim
