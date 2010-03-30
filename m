From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: RE: USB on omap2430
Date: Tue, 30 Mar 2010 00:03:27 -0500
Message-ID: <3bd3371a3ea8aa8fb53b62dbe99169e0@secure211.sgcpanel.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com> <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com> <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com> <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com> <20100329204159.GC31402@nokia.com> <70376CA23424B34D86F1C7DE6B997343023C4E201B@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343023C4E201B-fVvhrSDAkVjuuPCCJ6VnObSn4PsL5ZDKvpI+GvaZM4lBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Cc: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, 30 Mar 2010 10:24:32 +0530, Viral Mehta
> +static struct i2c_board_info __initdata sdp2430_i2c_1_boardinfo[] = {
> +       {
> +               I2C_BOARD_INFO("ex3691", 0x48),
> +/*             .flags = I2C_CLIENT_WAKE,
> +               .irq = INT_24XX_SYS_NIRQ,
> +               .platform_data = &sdp2430_twldata,*/
> +       },
> +       {
> +               I2C_BOARD_INFO("isp1301_omap", 0x2D),
> +       },

you should send only what relates to the isp1301 change :-)

>  static int __init omap2430_i2c_init(void)
> +{
> +       omap_register_i2c_bus(1, 400, sdp2430_i2c_1_boardinfo,
> +                       ARRAY_SIZE(sdp2430_i2c_1_boardinfo));
> +       printk("i2c bus 1 registerd \n");
>         omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
>                         ARRAY_SIZE(sdp2430_i2c_boardinfo));
>         return 0;
> --- ./drivers/usb/otg/isp1301_omap.org.c        2010-03-30
> 10:19:18.446765963 +0530
> +++ ./drivers/usb/otg/isp1301_omap.c    2010-03-30 10:18:50.985767665
+0530
> @@ -1659,7 +1659,8 @@ static int __init isp_init(void)
>         printk("============ init ISP\n");

remove the printks

>         return i2c_add_driver(&isp1301_driver);
>  }
> -module_init(isp_init);
> +//module_init(isp_init);
> +subsys_initcall(isp_init);

this should be one patch of its own.

>  static void __exit isp_exit(void)
>  {
> 
> 
> 
> After adding the above code, isp1301's probe is called but that fails
> before it does otg_set_transceiver()
> And I am debugging further on that path.

ok, cool. When you get that done, please send a cleaned up
diff with your signed-off-by line so it can be integrated.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
