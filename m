From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] i2c: add deprecation warning for class based instantiation
Date: Wed, 19 Jun 2013 21:21:51 +0300
Message-ID: <51C1F6BF.4030200@ti.com>
References: <20130607090623.GC3428@katana> <1370596166-12404-1-git-send-email-wsa@the-dreams.de> <20130619101526.GF2950@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130619101526.GF2950@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On 06/19/2013 01:15 PM, Wolfram Sang wrote:
> On Fri, Jun 07, 2013 at 11:09:26AM +0200, Wolfram Sang wrote:
>> Class based instantiation can cause huge delays when booting. This
>> mechanism was used when it was not possible to describe slaves on I2C
>> busses. We now have other mechanisms, so most embedded I2C will not need
>> classes and it was explicitly not recommended to use them. Add a
>> deprecation warning for drivers who want to disable class based in the
>> near future to gain boot-up time, so users relying on this technique can
>> switch to something better. They really should.
>>
>> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> No reactions on this, pity. Deferring.
>
Sorry, for delayed reply - I've had problems with my e-mail.

I've tested this patch on our TI K3.4 product kernel with additional 
change below:
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index c0330a4..442101d 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -186,7 +186,7 @@ static int __devinit i2c_gpio_probe(struct 
platform_device *pdev)
         adap->owner = THIS_MODULE;
         snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
         adap->algo_data = bit_data;
-       adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+       adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD | 
I2C_CLASS_DEPRECATED;
         adap->dev.parent = &pdev->dev;
         adap->dev.of_node = pdev->dev.of_node;

It works fine, in general - see my minor comment inline.
[    0.662536] omap_i2c omap_i2c.2: bus 2 rev2.4.0 at 400 kHz
[    0.662567]  (null): This adapter will soon drop class based 
instantiation of slaves
                 ^^^^^ invalid adapter device name here
[    0.662567] Please make sure all its I2C devices are instantiated by 
other means.
[    0.662567] Check 'Documentation/i2c/instantiating-devices' for details

Also tested on Linux master - OMAP4 SDP board.

In addition, I've found the following users of *i2c-gpio* (just FYI):
./arch/powerpc/boot/dts/wii.dts:                    compatible = "i2c-gpio";
./arch/mips/alchemy/board-gpr.c:    .name            = "i2c-gpio",
./arch/mips/ath79/mach-pb44.c:    .name        = "i2c-gpio",
./arch/avr32/boards/merisc/setup.c:    .name    = "i2c-gpio",
./arch/avr32/boards/atngw100/setup.c:    .name        = "i2c-gpio",
./arch/avr32/boards/hammerhead/setup.c:    .name        = "i2c-gpio",
./arch/avr32/boards/mimc200/setup.c:    .name        = "i2c-gpio",
./arch/blackfin/mach-bf533/boards/blackstamp.c:    .name        = 
"i2c-gpio",
./arch/blackfin/mach-bf533/boards/ezkit.c:    .name        = "i2c-gpio",
./arch/blackfin/mach-bf533/boards/stamp.c:    .name        = "i2c-gpio",
./arch/blackfin/mach-bf561/boards/ezkit.c:    .name        = "i2c-gpio",
./arch/arm/mach-ep93xx/core.c:    .name        = "i2c-gpio",
./arch/arm/mach-shmobile/board-armadillo800eva.c:    .name = "i2c-gpio",
./arch/arm/mach-pxa/viper.c:    .name        = "i2c-gpio",
./arch/arm/mach-pxa/viper.c:    tpm_device = 
platform_device_alloc("i2c-gpio", 2);
./arch/arm/mach-pxa/palmz72.c:    .name        = "i2c-gpio",
./arch/arm/boot/dts/at91sam9g45.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/at91sam9263.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/at91sam9x5.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/at91sam9x5.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/at91sam9x5.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi:    i2c-gpio@0 {
./arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:        compatible = 
"i2c-gpio";
./arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:        compatible = 
"i2c-gpio";
./arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:        compatible = 
"i2c-gpio";
./arch/arm/boot/dts/at91sam9260.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/at91rm9200.dtsi:        compatible = "i2c-gpio";
./arch/arm/boot/dts/at91sam9n12.dtsi:        compatible = "i2c-gpio";
./arch/arm/mach-ks8695/board-acs5k.c:    .name        = "i2c-gpio",
./arch/arm/mach-s5pv210/mach-goni.c:    .name        = "i2c-gpio",
./arch/arm/mach-s5pv210/mach-goni.c:    .name        = "i2c-gpio",
./arch/arm/mach-s5pv210/mach-aquila.c:    .name        = "i2c-gpio",
./arch/arm/mach-s5pv210/mach-aquila.c:    .name        = "i2c-gpio",
./arch/arm/mach-sa1100/simpad.c:    .name = "i2c-gpio",
./arch/arm/mach-exynos/mach-universal_c210.c:    .name        = "i2c-gpio",
./arch/arm/mach-exynos/mach-nuri.c:    .name            = "i2c-gpio",
./arch/arm/mach-at91/at91sam9263_devices.c:    .name            = 
"i2c-gpio",
./arch/arm/mach-at91/at91sam9261_devices.c:    .name            = 
"i2c-gpio",
./arch/arm/mach-at91/at91sam9g45_devices.c:    .name            = 
"i2c-gpio",
./arch/arm/mach-at91/at91sam9g45_devices.c:    .name            = 
"i2c-gpio",
./arch/arm/mach-at91/at91rm9200_devices.c:    .name            = "i2c-gpio",
./arch/arm/mach-at91/at91sam9260_devices.c:    .name            = 
"i2c-gpio",
./arch/arm/mach-at91/at91sam9rl_devices.c:    .name            = "i2c-gpio",
./arch/arm/mach-imx/mach-cpuimx51sd.c:    .name            = "i2c-gpio",
./arch/arm/mach-ixp4xx/nslu2-setup.c:    .name            = "i2c-gpio",
./arch/arm/mach-ixp4xx/nas100d-setup.c:    .name            = "i2c-gpio",
./arch/arm/mach-ixp4xx/goramo_mlr.c:    .name        = "i2c-gpio",
./arch/arm/mach-ixp4xx/ixdp425-setup.c:    .name        = "i2c-gpio",
./arch/arm/mach-ixp4xx/fsg-setup.c:    .name            = "i2c-gpio",
./arch/arm/mach-ixp4xx/dsmg600-setup.c:    .name            = "i2c-gpio",
./arch/arm/mach-ixp4xx/avila-setup.c:    .name        = "i2c-gpio",
./drivers/mfd/sm501.c:    pdev = sm501_create_subdev(sm, "i2c-gpio", 0,

- grygorii
