From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] OMAP1: AMS_DELTA: add modem support
Date: Mon, 6 Jul 2009 10:59:22 +0200
Message-ID: <200907061059.24378.jkrzyszt@tis.icnet.pl>
References: <200907051601.49194.jkrzyszt@tis.icnet.pl> <FCCFB4CDC6E5564B9182F639FC35608702F5568724@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F5568724@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Jonathan McDowell <noodles@earth.li>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Monday 06 July 2009 06:49:34 Pandita, Vikram napisa=C5=82(a):
> Janusz/Alan
>
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Janusz Krzys=
ztofik
>
> +static int __init ams_delta_modem_init(void)
>
> >+{
> >+	omap_cfg_reg(M14_1510_GPIO2);
> >+	ams_delta_modem_ports[0].irq =3D gpio_to_irq(2);
> >+	set_irq_type(gpio_to_irq(2), IRQ_TYPE_EDGE_RISING);
>
> There is a recent change on specifying irqflags as example:
> http://patchwork.kernel.org/patch/31888/
>
> There is a dependency for Alan Cox to push this patch first though:
> http://patchwork.kernel.org/patch/31884/
>
> Reference:
> http://lkml.indiana.edu/hypermail/linux/kernel/0906.2/02827.html

I can change and resubmit as v3, then Tony will choose which one applie=
s, OK?

Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
