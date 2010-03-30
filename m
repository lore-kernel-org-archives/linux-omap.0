From: Viral Mehta <Viral.Mehta@lntinfotech.com>
Subject: RE: USB on omap2430
Date: Tue, 30 Mar 2010 10:24:32 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B997343023C4E201B@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
 <20100329204159.GC31402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail192.messagelabs.com ([216.82.241.243]:42349 "EHLO
	mail192.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab0C3Eyw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 00:54:52 -0400
In-Reply-To: <20100329204159.GC31402@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> >It is not able to get "otg_get_transceiver()" since transceiver was
> never set.
> >OMAP2430 uses ISP1301 (grepped from SDP manual).
> >It is on I2C1 bus and address 0x2D if I read the manual correctly.
>
> isp1301 ?? there's a driver for that on drivers/usb/otg/isp1301_omap.c
>
> enable that and check if it works. You should add something like the
> following to your board file:
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-
> omap2/board-2430sdp.c
> index 01d113f..910234d 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -172,6 +172,11 @@ static struct i2c_board_info __initdata
> sdp2430_i2c_boardinfo[] = {
>               .irq = INT_24XX_SYS_NIRQ,
>               .platform_data = &sdp2430_twldata,
>       },
> +     {
> +             I2C_BOARD_INFO("isp1301-omap", 0x2d),
> +             .flags = I2C_CLIENT_WAKE,
> +             .irq = /* irq line here */,
> +     },
>   };
>

Yes, that's true.....
Here is a tested diff.

--- arch/arm/mach-omap2/board-2430sdp.org.c     2010-03-30 10:16:30.889813408 +0530
+++ arch/arm/mach-omap2/board-2430sdp.c 2010-03-26 16:13:56.043470674 +0530
@@ -174,7 +174,25 @@ static struct i2c_board_info __initdata
        },
 };

+static struct i2c_board_info __initdata sdp2430_i2c_1_boardinfo[] = {
+       {
+               I2C_BOARD_INFO("ex3691", 0x48),
+/*             .flags = I2C_CLIENT_WAKE,
+               .irq = INT_24XX_SYS_NIRQ,
+               .platform_data = &sdp2430_twldata,*/
+       },
+       {
+               I2C_BOARD_INFO("isp1301_omap", 0x2D),
+       },
+
+};
+
+
 static int __init omap2430_i2c_init(void)
+{
+       omap_register_i2c_bus(1, 400, sdp2430_i2c_1_boardinfo,
+                       ARRAY_SIZE(sdp2430_i2c_1_boardinfo));
+       printk("i2c bus 1 registerd \n");
        omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
                        ARRAY_SIZE(sdp2430_i2c_boardinfo));
        return 0;
--- ./drivers/usb/otg/isp1301_omap.org.c        2010-03-30 10:19:18.446765963 +0530
+++ ./drivers/usb/otg/isp1301_omap.c    2010-03-30 10:18:50.985767665 +0530
@@ -1659,7 +1659,8 @@ static int __init isp_init(void)
        printk("============ init ISP\n");
        return i2c_add_driver(&isp1301_driver);
 }
-module_init(isp_init);
+//module_init(isp_init);
+subsys_initcall(isp_init);

 static void __exit isp_exit(void)
 {



After adding the above code, isp1301's probe is called but that fails before it does otg_set_transceiver()
And I am debugging further on that path.

>   static int __init omap2430_i2c_init(void)
>
> I didn't even compile tested... you will probably need the schematics
> to
> figure out to which i2c bus isp1301 is connected.
>
> --
> balbi
>

Ps, and please bare with me for few things. The mail-server will again append that notice but should be ignored.
The whole problem is I don't have control over few things. I have to use outlook express only and things like that.
Probably will shift to my gmail address but till then I don't know but pardon me.

> ______________________________________________________________________

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
