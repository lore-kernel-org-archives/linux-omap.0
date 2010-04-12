From: "Maulik" <x0082077-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] omap: Add I2C bus 1 initialisation
Date: Mon, 12 Apr 2010 11:01:12 +0530
Message-ID: <000001cada01$5e7440e0$808918ac@apr.dhcp.ti.com>
References: <1271046704-10444-1-git-send-email-viral.mehta@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1271046704-10444-1-git-send-email-viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> +static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
> +       {
> +               I2C_BOARD_INFO("isp1301_omap", 0x2D),
> +               .flags = I2C_CLIENT_WAKE,
> +               .irq = OMAP_GPIO_IRQ(78),
> +       },
> +}

Use tabs instead of spaces. 

>  static int __init omap2430_i2c_init(void)
>  {
> -       omap_register_i2c_bus(1, 400, NULL, 0);
> +       omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
> +                       ARRAY_SIZE(sdp2430_i2c1_boardinfo));

Same here.

Maulik

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
