From: Belisko Marek <marek.belisko@gmail.com>
Subject: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Wed, 20 Jun 2018 18:37:06 +0200
Message-ID: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello,

I'm trying to fix warning (for omap5 board) produced by recent change
to avoid using IRQ_TYPE_NONE like:
[    1.818666] WARNING: CPU: 1 PID: 778 at
drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
[    1.828839] Modules linked in:

I did look to other commit which did update and without deep knowledge
I just simply do this small change:
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
b/arch/arm/boot/dts/omap5-board-common.dtsi
index 218892b..ab2df8c 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -393,7 +393,7 @@

        palmas: palmas@48 {
                compatible = "ti,palmas";
-               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
+               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
                reg = <0x48>;
                interrupt-controller;
                #interrupt-cells = <2>;

and it looks board boots fine. Only issue is that gpadc driver is not
working (at least not getting interrupts at all ADC fails with
timeout). I did look to gpadc driver and driver is not using
interrupts defined in dts but request interrupt directly from palmas
mfd module. Any ideas what needs to be changed to have gpadc again
working with mentioned patch?

I tried to use also IRQ_TYPE_LOW but in this case board cannot mount
rootfs so I was thinking this is not way to go.

Thanks for any hints.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
