From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/7 V2] mfd: TWL6030: OMAP4: Registering the
 TWL6030-usb device
Date: Fri, 10 Dec 2010 12:30:59 +0200
Message-ID: <20101210103059.GC6027@legolas.emea.dhcp.ti.com>
References: <1291964690-7152-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291964690-7152-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 10, 2010 at 12:34:50PM +0530, Hema HK wrote:
>Registering the twl6030-usb transceiver device as a child to twl6030 core.
>Removed the NOP transceiver init call from board file.
>
>Populated twl4030_usb_data platform data structure with the function
>pointers for OMAP4430 internal PHY operation to be used by twl630-usb driver.
>
>

one blank line only.

>Index: usb/include/linux/i2c/twl.h
>===================================================================
>--- usb.orig/include/linux/i2c/twl.h
>+++ usb/include/linux/i2c/twl.h
>@@ -593,6 +593,13 @@ enum twl4030_usb_mode {
>
> struct twl4030_usb_data {
> 	enum twl4030_usb_mode	usb_mode;
>+
>+	int		(*phy_init)(struct device *dev);
>+	int		(*phy_exit)(struct device *dev);
>+	/* Power on/off the PHY */
>+	int		(*phy_power)(struct device *dev, int iD, int on);
>+	/* enable/disable  phy clocks */
>+	int		(*phy_set_clock)(struct device *dev, int on);
> };

This hunk should come either before or together with patch:

usb: otg: Adding twl6030-usb transceiver driver for

> struct twl4030_ins {
>Index: usb/arch/arm/mach-omap2/board-omap4panda.c
>===================================================================
>--- usb.orig/arch/arm/mach-omap2/board-omap4panda.c
>+++ usb/arch/arm/mach-omap2/board-omap4panda.c
>@@ -137,6 +137,13 @@ static struct omap_musb_board_data musb_
> 	.power			= 100,
> };
>
>+static struct twl4030_usb_data omap4_usbphy_data = {
>+	.phy_init	= omap4430_phy_init,
>+	.phy_exit	= omap4430_phy_exit,
>+	.phy_power	= omap4430_phy_power,
>+	.phy_set_clock	= omap4430_phy_set_clk,
>+};
>+
> static struct omap2_hsmmc_info mmc[] = {
> 	{
> 		.mmc		= 1,
>@@ -345,6 +352,7 @@ static struct twl4030_platform_data omap
> 	.vaux1		= &omap4_panda_vaux1,
> 	.vaux2		= &omap4_panda_vaux2,
> 	.vaux3		= &omap4_panda_vaux3,
>+	.usb		= &omap4_usbphy_data,
> };
>
> static struct i2c_board_info __initdata omap4_panda_i2c_boardinfo[] = {

This hunk should come before adding the Kconfig entries for twl6030-usb.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
