From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: Re: [PATCH 4/7 V2] mfd: TWL6030: OMAP4: Registering the TWL6030-usb device
Date: Fri, 10 Dec 2010 17:06:45 +0530
Message-ID: <AANLkTik7cJSDJULHu2=NjhhLS_Q9rW=n6mvLwRhF_caS@mail.gmail.com>
References: <1291964690-7152-1-git-send-email-hemahk@ti.com>
	<20101210103059.GC6027@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40550 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755211Ab0LJLgq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 06:36:46 -0500
In-Reply-To: <20101210103059.GC6027@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>

On Fri, Dec 10, 2010 at 4:00 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Dec 10, 2010 at 12:34:50PM +0530, Hema HK wrote:
>>
>> Registering the twl6030-usb transceiver device as a child to twl6030=
 core.
>> Removed the NOP transceiver init call from board file.
>>
>> Populated twl4030_usb_data platform data structure with the function
>> pointers for OMAP4430 internal PHY operation to be used by twl630-us=
b
>> driver.
>>
>>
>
> one blank line only.
OK. I will fix it
>
>> Index: usb/include/linux/i2c/twl.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- usb.orig/include/linux/i2c/twl.h
>> +++ usb/include/linux/i2c/twl.h
>> @@ -593,6 +593,13 @@ enum twl4030_usb_mode {
>>
>> struct twl4030_usb_data {
>> =A0 =A0 =A0 =A0enum twl4030_usb_mode =A0 usb_mode;
>> +
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*phy_init)(struct device =
*dev);
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*phy_exit)(struct device =
*dev);
>> + =A0 =A0 =A0 /* Power on/off the PHY */
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*phy_power)(struct device=
 *dev, int iD, int on);
>> + =A0 =A0 =A0 /* enable/disable =A0phy clocks */
>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*phy_set_clock)(struct de=
vice *dev, int on);
>> };
>
> This hunk should come either before or together with patch:
>
Agree this patch should be before 4th patch.

> usb: otg: Adding twl6030-usb transceiver driver for
>
>> struct twl4030_ins {
>> Index: usb/arch/arm/mach-omap2/board-omap4panda.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- usb.orig/arch/arm/mach-omap2/board-omap4panda.c
>> +++ usb/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -137,6 +137,13 @@ static struct omap_musb_board_data musb_
>> =A0 =A0 =A0 =A0.power =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 100,
>> };
>>
>> +static struct twl4030_usb_data omap4_usbphy_data =3D {
>> + =A0 =A0 =A0 .phy_init =A0 =A0 =A0 =3D omap4430_phy_init,
>> + =A0 =A0 =A0 .phy_exit =A0 =A0 =A0 =3D omap4430_phy_exit,
>> + =A0 =A0 =A0 .phy_power =A0 =A0 =A0=3D omap4430_phy_power,
>> + =A0 =A0 =A0 .phy_set_clock =A0=3D omap4430_phy_set_clk,
>> +};
>> +
>> static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
>> @@ -345,6 +352,7 @@ static struct twl4030_platform_data omap
>> =A0 =A0 =A0 =A0.vaux1 =A0 =A0 =A0 =A0 =A0=3D &omap4_panda_vaux1,
>> =A0 =A0 =A0 =A0.vaux2 =A0 =A0 =A0 =A0 =A0=3D &omap4_panda_vaux2,
>> =A0 =A0 =A0 =A0.vaux3 =A0 =A0 =A0 =A0 =A0=3D &omap4_panda_vaux3,
>> + =A0 =A0 =A0 .usb =A0 =A0 =A0 =A0 =A0 =A0=3D &omap4_usbphy_data,
>> };
>>
>> static struct i2c_board_info __initdata omap4_panda_i2c_boardinfo[] =
=3D {
>
> This hunk should come before adding the Kconfig entries for twl6030-u=
sb.
Agree. I will correct it submit in sometime.

Regards,
Hema
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
