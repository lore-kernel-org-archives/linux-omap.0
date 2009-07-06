From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2] OMAP1: AMS_DELTA: add modem support
Date: Mon, 6 Jul 2009 10:19:34 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5568724@dbde02.ent.ti.com>
References: <200907051601.49194.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <200907051601.49194.jkrzyszt@tis.icnet.pl>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Jonathan McDowell <noodles@earth.li>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Janusz/Alan 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Janusz
>Krzysztofik
>
+static int __init ams_delta_modem_init(void)
>+{
>+	omap_cfg_reg(M14_1510_GPIO2);
>+	ams_delta_modem_ports[0].irq = gpio_to_irq(2);
>+	set_irq_type(gpio_to_irq(2), IRQ_TYPE_EDGE_RISING);

There is a recent change on specifying irqflags as example:
http://patchwork.kernel.org/patch/31888/

There is a dependency for Alan Cox to push this patch first though:
http://patchwork.kernel.org/patch/31884/

Reference:
http://lkml.indiana.edu/hypermail/linux/kernel/0906.2/02827.html


>+
>+	ams_delta_latch2_write(
>+		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC,
>+		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC);
>+
>+	return platform_device_register(&ams_delta_modem_device);
>+}
>+arch_initcall(ams_delta_modem_init);
>+
> static void __init ams_delta_map_io(void)
> {
> 	omap1_map_common_io();
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

