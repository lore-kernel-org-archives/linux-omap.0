From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [OMAPZOOM][PATCH 4/6] Add support for Sony imx046 to OMAP3430
 SDP	board.
Date: Fri, 30 Jan 2009 09:20:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA7901FD@dbde02.ent.ti.com>
References: <200901291853.45415.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200901291853.45415.dcurran@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "Curran, Dominic" <dcurran@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>
Cc: "greg.hofer@hp.com" <greg.hofer@hp.com>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: video4linux-list-bounces@redhat.com [mailto:video4linux-list-
> bounces@redhat.com] On Behalf Of Curran, Dominic
> Sent: Friday, January 30, 2009 6:24 AM
> To: linux-omap; video4linux-list@redhat.com
> Cc: greg.hofer@hp.com
> Subject: [OMAPZOOM][PATCH 4/6] Add support for Sony imx046 to
> OMAP3430 SDP board.
>=20
> From: Dominic Curran <dcurran@ti.com>
> Subject: [OMAPZOOM][PATCH 4/6] Add support for Sony imx046 to
> OMAP3430 SDP board.
>=20
> Support for the Sony IMX046 sensor on the OMAP3430 SDP board.
>=20
> Signed-off-by: Greg Hofer <greg.hofer@hp.com>
> Signed-off-by: Dominic Curran <dcurran@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |  197
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>=20
> Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
> +++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
> @@ -45,6 +45,9 @@
>  #include "ti-compat.h"
>=20
>  #ifdef CONFIG_VIDEO_OMAP3
> +#ifndef CONFIG_TWL4030_CORE
> +#error "no power companion board defined!"
> +#endif
[Hiremath, Vaibhav] Do we really required to do this?

>  #include <media/v4l2-int-device.h>
>  #include <../drivers/media/video/omap34xxcam.h>
>  #include <../drivers/media/video/isp/ispreg.h>
> @@ -52,9 +55,11 @@
>  #define FPGA_SPR_GPIO1_3v3	(0x1 << 14)
>  #define FPGA_GPIO6_DIR_CTRL	(0x1 << 6)
>  static void __iomem *fpga_map_addr;
> +
>  #if defined(CONFIG_VIDEO_MT9P012) ||
> defined(CONFIG_VIDEO_MT9P012_MODULE)
>  #include <../drivers/media/video/mt9p012.h>
>  #endif
> +
>  #if defined(CONFIG_VIDEO_OV3640) ||
> defined(CONFIG_VIDEO_OV3640_MODULE)
>  #include <../drivers/media/video/ov3640.h>
>  #include <../drivers/media/video/isp/ispcsi2.h>
> @@ -71,6 +76,22 @@ static	struct omap34xxcam_hw_config *hwc
>  #define OV3640_CSI2_PHY_TCLK_MISS	1
>  #define OV3640_CSI2_PHY_TCLK_SETTLE	14
>  #endif
> +
> +#if defined(CONFIG_VIDEO_IMX046) ||
> defined(CONFIG_VIDEO_IMX046_MODULE)
> +#include <../drivers/media/video/imx046.h>
> +#include <../drivers/media/video/isp/ispcsi2.h>
> +#define IMX046_CSI2_CLOCK_POLARITY	0	/* +/- pin order */
> +#define IMX046_CSI2_DATA0_POLARITY	0	/* +/- pin order */
> +#define IMX046_CSI2_DATA1_POLARITY	0	/* +/- pin order */
> +#define IMX046_CSI2_CLOCK_LANE		1	 /* Clock lane
> position: 1 */
> +#define IMX046_CSI2_DATA0_LANE		2	 /* Data0 lane
> position: 2 */
> +#define IMX046_CSI2_DATA1_LANE		3	 /* Data1 lane
> position: 3 */
> +#define IMX046_CSI2_PHY_THS_TERM	2
> +#define IMX046_CSI2_PHY_THS_SETTLE	23
> +#define IMX046_CSI2_PHY_TCLK_TERM	0
> +#define IMX046_CSI2_PHY_TCLK_MISS	1
> +#define IMX046_CSI2_PHY_TCLK_SETTLE	14
> +#endif
>  #endif
>=20
>  #ifdef CONFIG_VIDEO_DW9710
> @@ -926,6 +947,176 @@ static struct ov3640_platform_data sdp34
>=20
>  #endif
>=20
> +
> +#if defined(CONFIG_VIDEO_IMX046) ||
> defined(CONFIG_VIDEO_IMX046_MODULE)
> +
> +static struct omap34xxcam_sensor_config imx046_hwc =3D {
> +	.sensor_isp =3D 0,
> +	.xclk =3D OMAP34XXCAM_XCLK_B,
> +	.capture_mem =3D PAGE_ALIGN(3280 * 2464 * 2) * 2,
> +};
> +
[Hiremath, Vaibhav] You may want to align the structure, same comment I h=
ad also received from Tony on MMDC support patch.

> +static int imx046_sensor_set_prv_data(void *priv)
> +{
> +	struct omap34xxcam_hw_config *hwc =3D priv;
> +
> +	hwc->u.sensor.xclk =3D imx046_hwc.xclk;
> +	hwc->u.sensor.sensor_isp =3D imx046_hwc.sensor_isp;
> +	hwc->dev_index =3D 2;
> +	hwc->dev_minor =3D 5;
> +	hwc->dev_type =3D OMAP34XXCAM_SLAVE_SENSOR;
> +	hwc->interface_type =3D ISP_CSIA;
> +
> +	hwc->csi2.hw_csi2.lanes.clock.polarity =3D
> IMX046_CSI2_CLOCK_POLARITY;
> +	hwc->csi2.hw_csi2.lanes.clock.position =3D
> IMX046_CSI2_CLOCK_LANE;
> +	hwc->csi2.hw_csi2.lanes.data[0].polarity =3D
> IMX046_CSI2_DATA0_POLARITY;
> +	hwc->csi2.hw_csi2.lanes.data[0].position =3D
> IMX046_CSI2_DATA0_LANE;
> +	hwc->csi2.hw_csi2.lanes.data[1].polarity =3D
> IMX046_CSI2_DATA1_POLARITY;
> +	hwc->csi2.hw_csi2.lanes.data[1].position =3D
> IMX046_CSI2_DATA1_LANE;
> +	hwc->csi2.hw_csi2.phy.ths_term =3D IMX046_CSI2_PHY_THS_TERM;
> +	hwc->csi2.hw_csi2.phy.ths_settle =3D IMX046_CSI2_PHY_THS_SETTLE;
> +	hwc->csi2.hw_csi2.phy.tclk_term =3D IMX046_CSI2_PHY_TCLK_TERM;
> +	hwc->csi2.hw_csi2.phy.tclk_miss =3D IMX046_CSI2_PHY_TCLK_MISS;
> +	hwc->csi2.hw_csi2.phy.tclk_settle =3D
> IMX046_CSI2_PHY_TCLK_SETTLE;
> +	return 0;
> +}
> +
> +static struct isp_interface_config imx046_if_config =3D {
> +	.ccdc_par_ser =3D ISP_CSIA,
> +	.dataline_shift =3D 0x0,
> +	.hsvs_syncdetect =3D ISPCTRL_SYNC_DETECT_VSRISE,
> +	.vdint0_timing =3D 0x0,
> +	.vdint1_timing =3D 0x0,
> +	.strobe =3D 0x0,
> +	.prestrobe =3D 0x0,
> +	.shutter =3D 0x0,
> +	.prev_sph =3D 2,
> +	.prev_slv =3D 0,
> +	.wenlog =3D ISPCCDC_CFG_WENLOG_OR,
> +	.dcsub =3D IMX046_BLACK_LEVEL_AVG,
> +	.u.csi.crc =3D 0x0,
> +	.u.csi.mode =3D 0x0,
> +	.u.csi.edge =3D 0x0,
> +	.u.csi.signalling =3D 0x0,
> +	.u.csi.strobe_clock_inv =3D 0x0,
> +	.u.csi.vs_edge =3D 0x0,
> +	.u.csi.channel =3D 0x0,
> +	.u.csi.vpclk =3D 0x2,
> +	.u.csi.data_start =3D 0x0,
> +	.u.csi.data_size =3D 0x0,
> +	.u.csi.format =3D V4L2_PIX_FMT_SGRBG10,
> +};
> +
[Hiremath, Vaibhav] Same here.
> +
> +static int imx046_sensor_power_set(enum v4l2_power power)
> +{
> +	struct isp_csi2_lanes_cfg lanecfg;
> +	struct isp_csi2_phy_cfg phyconfig;
> +	static enum v4l2_power previous_power =3D V4L2_POWER_OFF;
> +	int err =3D 0;
> +
> +	switch (power) {
> +	case V4L2_POWER_ON:
> +		/* Power Up Sequence */
> +		printk(KERN_DEBUG "imx046_sensor_power_set(ON)\n");
> +		if (previous_power =3D=3D V4L2_POWER_OFF)
> +			isp_csi2_reset();
> +
> +		lanecfg.clk.pol =3D IMX046_CSI2_CLOCK_POLARITY;
> +		lanecfg.clk.pos =3D IMX046_CSI2_CLOCK_LANE;
> +		lanecfg.data[0].pol =3D IMX046_CSI2_DATA0_POLARITY;
> +		lanecfg.data[0].pos =3D IMX046_CSI2_DATA0_LANE;
> +		lanecfg.data[1].pol =3D IMX046_CSI2_DATA1_POLARITY;
> +		lanecfg.data[1].pos =3D IMX046_CSI2_DATA1_LANE;
> +		lanecfg.data[2].pol =3D 0;
> +		lanecfg.data[2].pos =3D 0;
> +		lanecfg.data[3].pol =3D 0;
> +		lanecfg.data[3].pos =3D 0;
> +		isp_csi2_complexio_lanes_config(&lanecfg);
> +		isp_csi2_complexio_lanes_update(true);
> +
> +		isp_csi2_ctrl_config_ecc_enable(true);
> +
> +		phyconfig.ths_term =3D IMX046_CSI2_PHY_THS_TERM;
> +		phyconfig.ths_settle =3D IMX046_CSI2_PHY_THS_SETTLE;
> +		phyconfig.tclk_term =3D IMX046_CSI2_PHY_TCLK_TERM;
> +		phyconfig.tclk_miss =3D IMX046_CSI2_PHY_TCLK_MISS;
> +		phyconfig.tclk_settle =3D IMX046_CSI2_PHY_TCLK_SETTLE;
> +		isp_csi2_phy_config(&phyconfig);
> +		isp_csi2_phy_update(true);
> +
> +		isp_configure_interface(&imx046_if_config);
> +
> +		if (previous_power =3D=3D V4L2_POWER_OFF) {
> +			/* Request and configure gpio pins */
> +			if (omap_request_gpio(IMX046_RESET_GPIO) !=3D 0)
> +				return -EIO;
> +
> +			/* nRESET is active LOW. set HIGH to release reset
> */
> +			omap_set_gpio_dataout(IMX046_RESET_GPIO, 1);
> +
> +			/* set to output mode */
> +			omap_set_gpio_direction(IMX046_RESET_GPIO,
> +				GPIO_DIR_OUTPUT);
> +
> +			/* turn on analog power */
> +			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +					VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
> +			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +					VAUX_DEV_GRP_P1,
> TWL4030_VAUX2_DEV_GRP);
> +
> +			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +					VAUX_1_8_V, TWL4030_VAUX4_DEDICATED);
> +			twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +					VAUX_DEV_GRP_P1,
> TWL4030_VAUX4_DEV_GRP);
> +			udelay(100);
> +
> +			/* have to put sensor to reset to guarantee
> detection */
> +			omap_set_gpio_dataout(IMX046_RESET_GPIO, 0);
> +			udelay(1500);
> +
> +			/* nRESET is active LOW. set HIGH to release reset
> */
> +			omap_set_gpio_dataout(IMX046_RESET_GPIO, 1);
> +			udelay(300);
> +		}
> +		break;
> +	case V4L2_POWER_OFF:
> +		printk(KERN_DEBUG "imx046_sensor_power_set(OFF)\n");
> +		/* Power Down Sequence */
> +		isp_csi2_complexio_power(ISP_CSI2_POWER_OFF);
> +
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +				VAUX_DEV_GRP_NONE, TWL4030_VAUX4_DEV_GRP);
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
> +		omap_free_gpio(IMX046_RESET_GPIO);
> +		break;
> +	case V4L2_POWER_STANDBY:
> +		printk(KERN_DEBUG "imx046_sensor_power_set(STANDBY)\n");
> +		/*TODO*/
> +		break;
> +	}
> +
> +	/* Save powerstate to know what was before calling POWER_ON.
> */
> +	previous_power =3D power;
> +	return err;
> +}
> +
> +static struct imx046_platform_data sdp3430_imx046_platform_data =3D {
> +	.power_set            =3D imx046_sensor_power_set,
> +	.priv_data_set        =3D imx046_sensor_set_prv_data,
> +	.default_regs         =3D NULL,
> +	.set_xclk             =3D isp_set_xclk,
> +	.cfg_interface_bridge =3D isp_configure_interface_bridge,
> +	.csi2_lane_count      =3D isp_csi2_complexio_lanes_count,
> +	.csi2_cfg_vp_out_ctrl =3D isp_csi2_ctrl_config_vp_out_ctrl,
> +	.csi2_ctrl_update     =3D isp_csi2_ctrl_update,
> +	.csi2_cfg_virtual_id  =3D isp_csi2_ctx_config_virtual_id,
> +	.csi2_ctx_update      =3D isp_csi2_ctx_update,
> +	.csi2_calc_phy_cfg0   =3D isp_csi2_calc_phy_cfg0,
> +};
> +#endif
> +
>  static struct platform_device sdp3430_lcd_device =3D {
>  	.name		=3D "sdp2430_lcd",
>  	.id		=3D -1,
> @@ -1063,6 +1254,12 @@ static struct i2c_board_info __initdata
>  		.platform_data =3D &sdp3430_ov3640_platform_data,
>  	},
>  #endif
> +#if defined(CONFIG_VIDEO_IMX046) ||
> defined(CONFIG_VIDEO_IMX046_MODULE)
> +	{
> +		I2C_BOARD_INFO("imx046", IMX046_I2C_ADDR),
> +		.platform_data =3D &sdp3430_imx046_platform_data,
> +	},
> +#endif
>  };
>=20
>  static int __init omap3430_i2c_init(void)
>=20
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-
> request@redhat.com?subject=3Dunsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
