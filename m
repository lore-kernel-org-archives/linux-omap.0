From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Convert tlv320aic3x to a new-style
 i2c driver
Date: Mon, 1 Sep 2008 15:20:38 +0300
Message-ID: <20080901152038.5987df8d.jarkko.nikula@nokia.com>
References: <20080901112131.08cdbb59@hyperion.delvare>
	<20080901143114.e98543a1.jarkko.nikula@nokia.com>
	<20080901113508.GC2722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080901113508.GC2722@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: ext Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org, Vladimir Barinov <vbarinov@ru.mvista.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 1 Sep 2008 12:35:09 +0100
"ext Mark Brown" <broonie@sirena.org.uk> wrote:

> On Mon, Sep 01, 2008 at 02:31:14PM +0300, Jarkko Nikula wrote:
> > "ext Jean Delvare" <khali@linux-fr.org> wrote:
> 
> > Thanks. In N810 it's connected into second i2c bus so this makes it
> > working
> 
> >  +	.i2c_bus = 2,
> 
> Should that be 1?  Normally the buses are numbered from zero...
>
Good question. By some historical reason we are registering busses
starting from number one in OMAP and short hack below (in linux-omap
tree) trying to register them starting from zero didn't work out.

But yeah, that's another issue in linux-omap and Jean's patch is
working on N810 if changing this i2c_bus to 2.


Jarkko

--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -691,15 +691,15 @@ void __init nokia_n800_common_init(void)
 				ARRAY_SIZE(n810_spi_board_info));
 	}
 	omap_serial_init();
-	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
+	omap_register_i2c_bus(0, 400, n800_i2c_board_info_1,
 			      ARRAY_SIZE(n800_i2c_board_info_1));
-	omap_register_i2c_bus(2, 400, n8x0_i2c_board_info_2,
+	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_2,
 			      ARRAY_SIZE(n800_i2c_board_info_2));
 	if (machine_is_nokia_n800())
-		i2c_register_board_info(2, n800_i2c_board_info_2,
+		i2c_register_board_info(1, n800_i2c_board_info_2,
 			ARRAY_SIZE(n800_i2c_board_info_2));
 	if (machine_is_nokia_n810())
-		i2c_register_board_info(2, n810_i2c_board_info_2,
+		i2c_register_board_info(1, n810_i2c_board_info_2,
 			ARRAY_SIZE(n810_i2c_board_info_2));
 		
 	mipid_dev_init();
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 89a6ab0..83ef7cf 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -134,7 +134,7 @@ int __init omap_register_i2c_bus(int bus_id, u32
clkrate, else if (cpu_is_omap34xx())
 		ports = 3;
 
-	BUG_ON(bus_id < 1 || bus_id > ports);
+//	BUG_ON(bus_id < 1 || bus_id > ports);
 
 	if (info) {
 		err = i2c_register_board_info(bus_id, info, len);
@@ -142,10 +142,10 @@ int __init omap_register_i2c_bus(int bus_id, u32
clkrate, return err;
 	}
 
-	pdev = &omap_i2c_devices[bus_id - 1];
+	pdev = &omap_i2c_devices[bus_id /*- 1*/];
 	*(u32 *)pdev->dev.platform_data = clkrate;
 
-	if (bus_id == 1) {
+	if (bus_id == /*1*/0) {
 		res = pdev->resource;
 		if (cpu_class_is_omap1()) {
 			base = OMAP1_I2C_BASE;
@@ -159,6 +159,6 @@ int __init omap_register_i2c_bus(int bus_id, u32
clkrate, res[1].start = irq;
 	}
 
-	omap_i2c_mux_pins(bus_id - 1);
+	omap_i2c_mux_pins(bus_id /*- 1*/);
 	return platform_device_register(pdev);
 }
