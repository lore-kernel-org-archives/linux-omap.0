From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP: Palm Tungsten|T defconfig
Date: Thu, 16 Nov 2006 03:48:49 +0200
Message-ID: <20061116014849.GP21064@atomide.com>
References: <200611120037.58048.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RASg3xLB4tUQ4RcS"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611120037.58048.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061112 01:48]:
> Hi,
>=20
> I hope this time it'll be all ok ;-) (including formating)
>=20
> This adds defconfig for Palm Tungsten|T.

Thanks, pushing your four patches, but had to still do formatting
for tabs and trailing whitespace, see below.. You may want to check
your editor settings :)

Regards,

Tony

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=errors

Tabifying non-tabbed line: "+       .name               = "write8k","
Tabifying non-tabbed line: "+       .offset             = 0,"
Tabifying non-tabbed line: "+       .size               = SZ_8K,"
Tabifying non-tabbed line: "+       .mask_flags         = 0,"
Tabifying non-tabbed line: "+       .name               = "PalmOS-BootLoader(ro)","
Tabifying non-tabbed line: "+       .offset             = SZ_8K,"
Tabifying non-tabbed line: "+       .size               = 7*SZ_8K,"
Tabifying non-tabbed line: "+       .mask_flags         = MTD_WRITEABLE,"
Tabifying non-tabbed line: "+       .name               = "u-boot","
Tabifying non-tabbed line: "+       .offset             = MTDPART_OFS_APPEND,"
Tabifying non-tabbed line: "+       .size               = 8*SZ_8K,"
Tabifying non-tabbed line: "+       .mask_flags         = 0,"
Tabifying non-tabbed line: "+       .name               = "PalmOS-FS(ro)","
Tabifying non-tabbed line: "+       .offset             = MTDPART_OFS_APPEND,"
Tabifying non-tabbed line: "+       .size               = 7*SZ_1M + 4*SZ_64K - 16*SZ_8K,"
Tabifying non-tabbed line: "+       .mask_flags         = MTD_WRITEABLE,"
Tabifying non-tabbed line: "+       .name               = "u-boot(rez)","
Tabifying non-tabbed line: "+       .offset             = MTDPART_OFS_APPEND,"
Tabifying non-tabbed line: "+       .size               = SZ_128K,"
Tabifying non-tabbed line: "+       .mask_flags         = 0"
Tabifying non-tabbed line: "+       .name               = "empty","
Tabifying non-tabbed line: "+       .offset             = MTDPART_OFS_APPEND,"
Tabifying non-tabbed line: "+       .size               = MTDPART_SIZ_FULL,"
Tabifying non-tabbed line: "+       .mask_flags         = 0"
Removing trailing whitespace: "+static struct omap_mcbsp_reg_cfg mcbsp_regs = { "
Tabifying non-tabbed line: "+                     RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),"
Tabifying non-tabbed line: "+                     RWDLEN1(OMAP_MCBSP_WORD_16),"
Tabifying non-tabbed line: "+                     XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,"
Tabifying non-tabbed line: "+                     XWDLEN1(OMAP_MCBSP_WORD_16),"
Tabifying non-tabbed line: "+                     FPER(DEFAULT_BITPERSAMPLE * 2 - 1),"
Removing trailing whitespace: "+        .get_default_samplerate = NULL, // aic23_get_default_samplerate,        "
Removing trailing whitespace: "+                                                        "
Tabifying non-tabbed line: "+       .start      = INT_UART3,"
Tabifying non-tabbed line: "+       .end        = INT_UART3,"
Tabifying non-tabbed line: "+       .flags      = IORESOURCE_IRQ,"
Removing trailing whitespace: "+                                                                                                               "
Removing trailing whitespace: "+                                                                                                               "
Removing trailing whitespace: "+        "
Removing trailing whitespace: "+        "
Tabifying non-tabbed line: "+       /* MicroWire (bus 2) CS0 has an ads7846e */"
Tabifying non-tabbed line: "+       .modalias           = "ads7846","
Tabifying non-tabbed line: "+       .platform_data      = &palmtt_ts_info,"
Tabifying non-tabbed line: "+       .irq                = OMAP_GPIO_IRQ(6),"
Tabifying non-tabbed line: "+       .max_speed_hz       = 120000        /* max sample rate at 3V */"
Tabifying non-tabbed line: "+                               * 26        /* command + data + overhead */,"
Tabifying non-tabbed line: "+       .bus_num            = 2,"
Tabifying non-tabbed line: "+       .chip_select        = 0,"
Removing trailing whitespace: "+        "
Tabifying non-tabbed line: "+        { OMAP_TAG_UART,   &palmtt_uart_config     },"
Removing trailing whitespace: "+                                                                                                "
Tabifying non-tabbed line: "+        if (mode)"
Tabifying non-tabbed line: "+       omap_writew(0x8000, OMAP_WDT_TIMER_MODE);"
Tabifying non-tabbed line: "+        else {"
Tabifying non-tabbed line: "+            omap_writew(0x00f5, OMAP_WDT_TIMER_MODE);"
Tabifying non-tabbed line: "+       omap_writew(0x00f5, OMAP_WDT_TIMER_MODE);"
Tabifying non-tabbed line: "+            omap_writew(0x00a0, OMAP_WDT_TIMER_MODE);"
Tabifying non-tabbed line: "+       omap_writew(0x00a0, OMAP_WDT_TIMER_MODE);"
Tabifying non-tabbed line: "+        }"
Tabifying non-tabbed line: "+        omap_mpu_wdt_mode(0);"
Tabifying non-tabbed line: "+        omap_board_config_size = ARRAY_SIZE(palmtt_config);"
Tabifying non-tabbed line: "+        spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));"
Removing trailing whitespace: "+                                "
Tabifying non-tabbed line: "+                        struct omapfb_device *fbdev)"
Tabifying non-tabbed line: "+   .name           = "palmtt","
Tabifying non-tabbed line: "+   .config         = OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |"
Tabifying non-tabbed line: "+                     OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |"
Tabifying non-tabbed line: "+    OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |"

Tabifying non-tabbed line: "+                     OMAP_LCDC_HSVS_OPPOSITE,"
Tabifying non-tabbed line: "+    OMAP_LCDC_HSVS_OPPOSITE,"
Tabifying non-tabbed line: "+   .bpp            = 16,"
Tabifying non-tabbed line: "+   .x_res          = 320,"
Tabifying non-tabbed line: "+   .y_res          = 320,"
Tabifying non-tabbed line: "+   .hsw            = 4,"
Tabifying non-tabbed line: "+   .hfp            = 8,"
Tabifying non-tabbed line: "+   .hbp            = 28,"
Tabifying non-tabbed line: "+   .vsw            = 1,"
Tabifying non-tabbed line: "+   .vfp            = 8,"
Tabifying non-tabbed line: "+   .vbp            = 7,"
Tabifying non-tabbed line: "+   .pcd            = 0,"
Tabifying non-tabbed line: "+   .init           = palmtt_panel_init,"
Tabifying non-tabbed line: "+   .enable         = palmtt_panel_enable,"
Tabifying non-tabbed line: "+   .probe          = palmtt_panel_probe,"
Tabifying non-tabbed line: "+   .remove         = palmtt_panel_remove,"
Tabifying non-tabbed line: "+   .resume         = palmtt_panel_resume,"
Tabifying non-tabbed line: "+   .driver         = {"
Tabifying non-tabbed line: "+           .name   = "lcd_palmtt","
Tabifying non-tabbed line: "+           .owner  = THIS_MODULE,"

Tabifying non-tabbed line: "+   .spcr2          = FREE | FRST | GRST | XRST | XINTM(3),"
Tabifying non-tabbed line: "+   .spcr1          = RINTM(3) | RRST,"
Tabifying non-tabbed line: "+   .rcr2           = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |"
Tabifying non-tabbed line: "+                     RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),"
Tabifying non-tabbed line: "+    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),"
Tabifying non-tabbed line: "+   .rcr1           = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),"
Tabifying non-tabbed line: "+   .xcr2           = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |"
Tabifying non-tabbed line: "+                     XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,"
Tabifying non-tabbed line: "+    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,"
Tabifying non-tabbed line: "+   .xcr1           = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),"
Tabifying non-tabbed line: "+   .srgr1          = FWID(DEFAULT_BITPERSAMPLE - 1),"
Tabifying non-tabbed line: "+   .srgr2          = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),"
Tabifying non-tabbed line: "+   .pcr0           = CLKXP | CLKRP,        /* mcbsp: slave */"
Tabifying non-tabbed line: "+    {"
Tabifying non-tabbed line: "+   .irq            = OMAP_GPIO_IRQ(PALMZ71_PENIRQ_GPIO),"
Tabifying non-tabbed line: "+                     * 26          /* command + data + overhead */,"
Tabifying non-tabbed line: "+    * 26           /* command + data + overhead */,"
Tabifying non-tabbed line: "+    }"
Tabifying non-tabbed line: "+               palmz71_powercable, SA_SAMPLE_RANDOM, "palmz71-cable", 0))"
Tabifying non-tabbed line: "+     palmz71_powercable, SA_SAMPLE_RANDOM, "palmz71-cable", 0))"
Tabifying non-tabbed line: "+                   printk(KERN_ERR"
Tabifying non-tabbed line: "+                           "IRQ request for power cable failed!\n");"

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--RASg3xLB4tUQ4RcS--
