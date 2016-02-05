From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Thu, 4 Feb 2016 22:10:21 -0800
Message-ID: <20160205061021.GS19432@atomide.com>
References: <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
 <20160108075913.GN11364@pali> <569052FE.1040008@gmail.com>
 <20160121091437.GT7192@pali> <56B077D4.3030902@gmail.com>
 <20160202233911.GB19432@atomide.com>
 <20160203000045.GE19432@atomide.com> <56B1A654.1060905@gmail.com>
 <56B22FC3.3050900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56B22FC3.3050900@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160203 08:51]:
> - flashed maemo rootfs
> 
> sudo flasher-3.5 -f -F RX-51_2009SE_20.2010.36-2_PR_COMBINED_MR0_ARM.bin
> --flash-only=rootfs -R
> 
> - booted to maemo and powered the device off
> 
> sudo flasher-3.5 -k zImage  -l -b"init=/sbin/preinit ubi.mtd=rootfs
> root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw
> mtdoops.mtddev=log  omapfb_vram=7M omapfb.mode=lcd:848x480-16
> nokia-modem.pm=0"

This seems to fix things here for legacy booting and booting the
maemo zImage after dts image. Care to give it a try?

Basically onenand after reset is in wrong state, have not looked
up the bits yet. Will post a better patch when I get a chance
over next few days.

Regards,

Tony

8< -----------
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -104,6 +104,7 @@ static void set_onenand_cfg(void __iomem *onenand_base)
 	u32 reg;
 
 	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg = 0x06c0;
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
 		ONENAND_SYS_CFG1_BL_16;
@@ -289,6 +290,7 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 		}
 	}
 
+	onenand_async.sync_write = true;
 	omap2_onenand_calc_async_timings(&t);
 
 	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
