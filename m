From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Tue, 3 Jul 2018 20:31:32 +0200
Message-ID: <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703084516.GT112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tue, Jul 3, 2018 at 10:45 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Belisko Marek <marek.belisko@gmail.com> [180620 09:40]:
> > Hello,
> >
> > I'm trying to fix warning (for omap5 board) produced by recent change
> > to avoid using IRQ_TYPE_NONE like:
> > [    1.818666] WARNING: CPU: 1 PID: 778 at
> > drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
> > [    1.828839] Modules linked in:
> >
> > I did look to other commit which did update and without deep knowledge
> > I just simply do this small change:
> > diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
> > b/arch/arm/boot/dts/omap5-board-common.dtsi
> > index 218892b..ab2df8c 100644
> > --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> > +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> > @@ -393,7 +393,7 @@
> >
> >         palmas: palmas@48 {
> >                 compatible = "ti,palmas";
> > -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
> > +               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
> >                 reg = <0x48>;
> >                 interrupt-controller;
> >                 #interrupt-cells = <2>;
> >
> > and it looks board boots fine. Only issue is that gpadc driver is not
> > working (at least not getting interrupts at all ADC fails with
> > timeout). I did look to gpadc driver and driver is not using
> > interrupts defined in dts but request interrupt directly from palmas
> > mfd module. Any ideas what needs to be changed to have gpadc again
> > working with mentioned patch?
>
> Can you try with IRQF_TRIGGER_HIGH added also to the flags to
> regmap_add_irq_chip() in drivers/mfd/palmas.c?
Nope issue is till present also after this change like:
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
b/arch/arm/boot/dts/omap5-board-common.dtsi
index 218892b..6912769 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -393,7 +393,7 @@

        palmas: palmas@48 {
                compatible = "ti,palmas";
-               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
+               interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N */
                reg = <0x48>;
                interrupt-controller;
                #interrupt-cells = <2>;
@@ -432,9 +432,9 @@

                gpadc: gpadc {
                        compatible = "ti,palmas-gpadc";
-                       interrupts = <18 0
-                                     16 0
-                                     17 0>;
+                       interrupts = <18 IRQ_TYPE_LEVEL_HIGH
+                                     16 IRQ_TYPE_LEVEL_HIGH
+                                     17 IRQ_TYPE_LEVEL_HIGH>;
                        #io-channel-cells = <1>;
                        ti,channel0-current-microamp = <5>;
                        ti,channel3-current-microamp = <10>;
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 663a239..15d23db 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -601,7 +601,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
        regmap_write(palmas->regmap[slave], addr, reg);

        ret = regmap_add_irq_chip(palmas->regmap[slave], palmas->irq,
-                                 IRQF_ONESHOT | pdata->irq_flags, 0,
+                                 IRQF_ONESHOT | IRQF_TRIGGER_HIGH |
pdata->irq_flags, 0,
                                  driver_data->irq_chip, &palmas->irq_data);
        if (ret < 0)
                goto err_i2c;

>
> Regards,
>
> Tony

BR,

marek
