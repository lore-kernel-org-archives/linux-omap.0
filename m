From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 17 Apr 2013 15:42:39 +0200
Message-ID: <CAAwP0s2DsJAWuXWvPAkzCT0T0AG_OvMEw2sADW6LqSi1Ofd_Zw@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
 <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
 <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org>
 <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org>
 <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org>
 <516DDB4D.9020500@ti.com> <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com>
 <516E022F.5050708@ti.com> <CAAwP0s2M2pnSydyDvh_rejFO=w8bCo4WE5PkxrYuk0HQDixc-Q@mail.gmail.com>
 <516EA2B1.3070201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48255 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966099Ab3DQNm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 09:42:59 -0400
Received: by mail-ie0-f181.google.com with SMTP id as1so1904832iec.12
        for <linux-omap@vger.kernel.org>; Wed, 17 Apr 2013 06:42:59 -0700 (PDT)
In-Reply-To: <516EA2B1.3070201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 17, 2013 at 3:25 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 04/17/2013 02:55 AM, Javier Martinez Canillas wrote:
>
> ...
>
>> There are so many patches flying around in this thread that I missed it :-)
>>
>> Sorry about that...
>
> No problem.
>
>>> I was trying to see if we could find a common solution that everyone
>>> could use as it seems that ideally we should all be requesting the gpio.
>>>
>>> Cheers
>>> Jon
>>>
>>> [1] http://marc.info/?l=linux-arm-kernel&m=136606204823845&w=1
>>
>> btw, I shared the latest patch with only build testing it, but today I
>> gave a try and I found a problem with this approach. The .xlate
>> function is being called twice for each GPIO-IRQ so the first time
>> gpio_request_one() succeeds but the second time it fails returning
>> -EBUSY.
>
> I tried it and I did not see that. I don't see the below warning either.
>

weird, I wonder what's different here.

I'll try tonight to test using another branch based on your
omap-daily-testing branch.

>> This raises a warning on drivers/of/platform.c
>> (WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq)):
>>
>>     0.285308] ------------[ cut here ]------------
>> [    0.285369] WARNING: at drivers/of/platform.c:171
>> of_device_alloc+0x154/0x168()
>> [    0.285430] Modules linked in:
>> [    0.285491] [<c001a944>] (unwind_backtrace+0x0/0xf0) from
>> [<c0041edc>] (warn_slowpath_common+0x4c/0x68)
>> [    0.285552] [<c0041edc>] (warn_slowpath_common+0x4c/0x68) from
>> [<c0041f14>] (warn_slowpath_null+0x1c/0x24)
>> [    0.285614] [<c0041f14>] (warn_slowpath_null+0x1c/0x24) from
>> [<c041ac3c>] (of_device_alloc+0x154/0x168)
>> [    0.285675] [<c041ac3c>] (of_device_alloc+0x154/0x168) from
>> [<c041ac84>] (of_platform_device_create_pdata+0x34/0x80)
>> [    0.285736] [<c041ac84>]
>> (of_platform_device_create_pdata+0x34/0x80) from [<c0027364>]
>> (gpmc_probe_generic_child+0x180/0x240)
>> [    0.285827] [<c0027364>] (gpmc_probe_generic_child+0x180/0x240)
>> from [<c00278d8>] (gpmc_probe+0x4b4/0x614)
>> [    0.285888] [<c00278d8>] (gpmc_probe+0x4b4/0x614) from [<c0325514>]
>> (platform_drv_probe+0x18/0x1c)
>> [    0.285949] [<c0325514>] (platform_drv_probe+0x18/0x1c) from
>> [<c0324354>] (driver_probe_device+0x108/0x21c)
>
> Any chance you have still have some additional code in your dts to
> request the gpio? I recall you made some hacks to make this work before.
>

Yes, but I remove all those hacks from my DT and gpmc driver. Is the
first thing I thought and I already doble checked that.

>> I probably won't have time to dig further on this until later this
>> week but I wanted to share with you in case you know why is being
>> calling twice and if you thought about a solution.
>
> Care to post your dts file?
>

I'm using the following patch to add smsc ethernet support to my board
+ adding 'ranges = <5 0 0x2c000000 0x1000000>;' to the gpmc device
node on omap3.dtsi:

>From 4fe26a40229e6e97c2ab3b80865c9f24e8ff3424 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Wed, 27 Feb 2013 02:59:29 +0100
Subject: [PATCH 2/2] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support

The IGEPv2 board has an SMSC LAN9221i ethernet chip connected to
the OMAP3 processor though the General-Purpose Memory Controller.

This patch adds a device node for the ethernet chip as a GPMC child
and all its requirements (regulators, GPIO and pin muxs).

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi    |    6 ++++
 arch/arm/boot/dts/omap3-igep0020.dts |   52 ++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi
b/arch/arm/boot/dts/omap3-igep.dtsi
index f8fe3b7..d5cd504 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -62,6 +62,12 @@
 			0x126 0x0100	/* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
 		>;
 	};
+
+	smsc911x_pins: pinmux_smsc911x_pins {
+		pinctrl-single,pins = <
+                        0x1a2 0x0104    /* mcspi1_cs2.gpio_176 INPUT | MODE4 */
+		>;
+	};
 };

 &i2c1 {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
b/arch/arm/boot/dts/omap3-igep0020.dts
index e2b9849..32a59df 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -40,6 +40,18 @@
 			gpios = <&twl_gpio 19 1>;
 		};
 	};
+
+	vddvario: regulator-vddvario {
+		  compatible = "regulator-fixed";
+		  regulator-name = "vddvario";
+		  regulator-always-on;
+	};
+
+	vdd33a: regulator-vdd33a {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
 };

 &i2c3 {
@@ -54,3 +66,43 @@
 		reg = <0x50>;
 	};
 };
+
+&gpmc {
+	ethernet@5,0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&smsc911x_pins>;
+		compatible = "smsc,lan9221", "smsc,lan9115";
+		reg = <5 0 0xff>;
+		bank-width = <2>;
+
+		gpmc,mux-add-data;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <186>;
+		gpmc,cs-wr-off-ns = <186>;
+		gpmc,adv-on-ns = <12>;
+		gpmc,adv-rd-off-ns = <48>;
+		gpmc,adv-wr-off-ns = <48>;
+		gpmc,oe-on-ns = <54>;
+		gpmc,oe-off-ns = <168>;
+		gpmc,we-on-ns = <54>;
+		gpmc,we-off-ns = <168>;
+		gpmc,rd-cycle-ns = <186>;
+		gpmc,wr-cycle-ns = <186>;
+		gpmc,access-ns = <114>;
+		gpmc,page-burst-access-ns = <6>;
+		gpmc,bus-turnaround-ns = <12>;
+		gpmc,cycle2cycle-delay-ns = <18>;
+		gpmc,wr-data-mux-bus-ns = <90>;
+		gpmc,wr-access-ns = <186>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <16 8>;
+		vmmc-supply = <&vddvario>;
+		vmmc_aux-supply = <&vdd33a>;
+		reg-io-width = <4>;
+
+		smsc,save-mac-address;
+	};
+};
-- 
1.7.7.6

>> It works if I don't check the return gpio_request_one() (or better if
>> we don't return on omap_gpio_irq_domain_xlate) but of course is not
>> the right solution.
>
> Yes we need to check the return value.
>

I know, I was just pointing out that the fact that gpio_request_one()
was failing is what propagates the error to drivers/of/platform.c

> Cheers
> Jon

Thanks a lot and best regards,
Javier
