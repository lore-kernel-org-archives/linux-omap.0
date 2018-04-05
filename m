From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: regression: twl4030 audio/clock stopped working in v4.16
Date: Thu, 5 Apr 2018 16:43:55 +0200
Message-ID: <7983D97B-3266-450A-AD8C-F1CA838F616F@goldelico.com>
References: <2E644641-82D1-40AB-B878-06066C91AC7A@goldelico.com> <3c615b51-f9f4-7267-cc2d-2a74184058a8@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c615b51-f9f4-7267-cc2d-2a74184058a8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

> Am 05.04.2018 um 13:05 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
>=20
> Nikolaus,
>=20
> can you CC me also, I have almost missed this...

Ah, good. Thanks for quick response! I was just starting to setup git =
bisect...

>=20
> On 2018-04-04 21:29, H. Nikolaus Schaller wrote:
>> Hi Peter,
>> I just noticed a problem in v4.16 kernels with twl4030 audio and =
vibra driver no longer working.
>>=20
>> Tracing it back shows that it already did appear in v4.16-rc1 and =
wasn't fixed up to v4.16.0.
>> Kernel v4.15.9 (the latest one where I have a binary) works.
>=20
> v4.16 works just fine on beagle-xm (including audio), =
omap2plus_defconfig.
>=20
>> The symptoms are:
>>=20
>> [    1.557342] twl4030-audio 48070000.i2c:twl@48:audio: Invalid =
audio_mclk
>> [    1.564788] twl4030-audio: probe of 48070000.i2c:twl@48:audio =
failed with error -22
>> [    1.839141] TWL4030: HFCLK is not configured
>=20
> Hrm, the order looks a bit weird, it should be
> TWL4030: HFCLK is not configured
> twl4030-audio 48070000.i2c:twl@48:audio: Invalid audio_mclk
> twl4030-audio: probe of 48070000.i2c:twl@48:audio failed with error =
-22

Indeed, but I see it is as listed:

root@letux:~# dmesg|fgrep -i twl4030
[    1.787200] twl4030_reg 48070000.i2c:twl@48:regulator-vmmc2: can't =
register VMMC2, -22
[    1.795745] twl4030_reg: probe of 48070000.i2c:twl@48:regulator-vmmc2 =
failed with error -22
[    1.840789] TWL4030: HFCLK is not configured
[    1.845977] twl4030-audio 48070000.i2c:twl@48:audio: Invalid =
audio_mclk
[    1.852935] twl4030-audio: probe of 48070000.i2c:twl@48:audio failed =
with error -22
[    6.764160] twl4030_madc 48070000.i2c:twl@48:madc: =
48070000.i2c:twl@48:madc supply vusb3v1 not found, using dummy regulator
[    6.872253] input: twl4030_pwrbutton as =
/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@=
48:pwrbutton/input/input2
[    6.997192] twl4030_gpio twl4030-gpio: can't dispatch IRQs from =
modules
[    7.120666] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized =
TWL4030 USB module
[    8.176147] omap-twl4030 sound: ASoC: CODEC DAI twl4030-hifi not =
registered
[    8.183441] omap-twl4030 sound: devm_snd_soc_register_card() failed: =
-517
[    8.267120] omap-twl4030 sound: ASoC: CODEC DAI twl4030-hifi not =
registered
[    8.280975] omap-twl4030 sound: devm_snd_soc_register_card() failed: =
-517
[    8.388366] omap-twl4030 sound: ASoC: CODEC DAI twl4030-hifi not =
registered
[    8.404113] omap-twl4030 sound: devm_snd_soc_register_card() failed: =
-517
[    9.250274] omap-twl4030 sound: ASoC: CODEC DAI twl4030-hifi not =
registered
[    9.264312] omap-twl4030 sound: devm_snd_soc_register_card() failed: =
-517
[    9.653381] omap-twl4030 sound: ASoC: CODEC DAI twl4030-hifi not =
registered
[    9.664123] omap-twl4030 sound: devm_snd_soc_register_card() failed: =
-517
root@letux:~#=20

>=20
> In twl4030_audio_probe() we try to get the HFCLK rate via
> twl_get_hfclk_rate(), which is reading it with:
> twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &ctrl, R_CFG_BOOT);
>=20
>> Those are not visible in v4.15.9. And I am not aware of any changes =
to the gta04 device tree.
>>=20
>> Do you know about this issue and a fix, before I start to bisect?
>=20
> The CFG_BOOT register of twl4030 is not configured correctly for some
> reason?
> The TRM of twl4030 states that the SW should program the HFCLK_FREQ
> during boot sequence.
>=20
> If it is not done, MDAC and USB should not work either. And all sorts =
of
> other issues might happen.

Well, USB works for me... Strange.

>=20
> So the boot loader is not configuring the HFCLK_FREQ, for me it does =
as
> I have this line in the kernel log:
> [    1.472503] Skipping twl internal clock init and using bootloader
> value (unknown osc rate)

root@letux:~# dmesg|fgrep -i Skipping
[    1.691619] Skipping twl internal clock init and using bootloader =
value (unknown osc rate)
root@letux:~#

So I can see this as well.

>=20
> In DT the twl should have the fck clock to not depend on the =
bootloader
> for the HFCLK_FREQ settings.

I am not even modifying the bootloader when trying v4.15 and v4.16. I =
just
swap uImage and kernel modules...

The interesting question is why it did work before (for years) and =
stopped with v4.16-rc1.

> We do not have that for beagle-xm for sure.

I have tried your new patches:

* first patch alone shows no change

root@letux:~# dmesg|fgrep -i twl4030
[    1.787322] twl4030_reg 48070000.i2c:twl@48:regulator-vmmc2: can't =
register VMMC2, -22
[    1.795867] twl4030_reg: probe of 48070000.i2c:twl@48:regulator-vmmc2 =
failed with error -22
[    1.834228] TWL4030: HFCLK is not configured
[    1.838714] twl4030-audio 48070000.i2c:twl@48:audio: Invalid =
audio_mclk
[    1.846313] twl4030-audio: probe of 48070000.i2c:twl@48:audio failed =
with error -22
[    6.700225] twl4030_madc 48070000.i2c:twl@48:madc: =
48070000.i2c:twl@48:madc supply vusb3v1 not found, using dummy regulator
[    6.786651] input: twl4030_pwrbutton as =
/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@=
48:pwrbutton/input/input2
[    6.891265] twl4030_gpio twl4030-gpio: can't dispatch IRQs from =
modules
[    7.039764] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized =
TWL4030 USB module
[    8.097137] Modules linked in: snd_soc_gtm601(+) pwm_omap_dmtimer(+) =
connector_analog_tv(+) generic_adc_battery(+) pwm_bl(+) extcon_gpio =
omap3_isp(+) bq27xxx_battery_hdq bq27xxx_battery videobuf2_dma_contig =
videobuf2_memops videobuf2_v4l2 videobuf2_common omap_hdq omap2430 =
snd_soc_omap_mcbsp snd_soc_omap snd_pcm_dmaengine ov9655 itg3200 =
v4l2_fwnode v4l2_common bmp280_i2c bmp280 at24 videodev hmc5843_i2c =
leds_tca6507 hmc5843_core bma180 tsc2007 lis3lv02d_i2c =
industrialio_triggered_buffer phy_twl4030_usb lis3lv02d kfifo_buf media =
input_polldev gpio_twl4030 musb_hdrc twl4030_pwrbutton twl4030_charger =
twl4030_madc w2sg0004 industrialio ehci_omap w2cbw003_bluetooth omapdss =
omapdss_base cec
[    8.609954] omap-twl4030 sound: ASoC: CODEC DAI twl4030-hifi not =
registered
[    8.655273] omap-twl4030 sound: devm_snd_soc_register_card() failed: =
-517
root@letux:~# dmesg|fgrep -i Skipping
[    1.691162] Skipping twl internal clock init and using bootloader =
value (unknown osc rate)
root@letux:~#=20

* porting the second patch to omap3-gta04.dtsi solved the problem (vibra =
and audio is working again):

root@letux:~# dmesg|fgrep -i twl4030
[    1.777770] twl4030_reg 48070000.i2c:twl@48:regulator-vmmc2: can't =
register VMMC2, -22
[    1.786315] twl4030_reg: probe of 48070000.i2c:twl@48:regulator-vmmc2 =
failed with error -22
[    6.704376] twl4030_madc 48070000.i2c:twl@48:madc: =
48070000.i2c:twl@48:madc supply vusb3v1 not found, using dummy regulator
[    6.755828] input: twl4030:vibrator as =
/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@=
48:audio/twl4030-vibra/input/input2
[    6.835510] input: twl4030_pwrbutton as =
/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@=
48:pwrbutton/input/input3
[    6.933776] twl4030_gpio twl4030-gpio: can't dispatch IRQs from =
modules
[    7.115386] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized =
TWL4030 USB module
[    8.364807] omap-twl4030 sound: twl4030-hifi <-> 49022000.mcbsp =
mapping ok
root@letux:~# dmesg|fgrep -i Skipping
root@letux:~#=20

I assume that we need a similar patch for the OpenPandora as well and =
prepare&submit both.

BR and thanks,
Nikolaus
