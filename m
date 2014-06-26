From: Jason Kridner <jkridner@gmail.com>
Subject: Re: [PATCH v1 3/3] ARM: dts: am335x-bone: add support for beaglebone
 LCD4 cape
Date: Thu, 26 Jun 2014 00:30:36 -0400
Message-ID: <CA+T6QPnxyQJnuN3invimzOHWsBBVjsjw-V+B5Q5z8jRAmE6X7g@mail.gmail.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
	<1403612666-31197-4-git-send-email-pekon@ti.com>
	<CA+T6QP=eETQtLKs6HcCAJsZg7+tSdJyeaXdaZTv5qt9y+7+mmg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EAF737A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:60525 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaFZEah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 00:30:37 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so3083173wgg.32
        for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2014 21:30:36 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF737A@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Robert Nelson <robertcnelson@gmail.com>

On Wed, Jun 25, 2014 at 1:49 AM, Gupta, Pekon <pekon@ti.com> wrote:
>>From: Jason Kridner [mailto:jkridner@gmail.com]
>>On Tue, Jun 24, 2014 at 8:24 AM, Pekon Gupta <pekon@ti.com> wrote:
>>> This patch adds support for LCD4 cape as advertised on
>>>   http://elinux.org/CircuitCo:BeagleBone_LCD4
> [...]
>
>>>
>>> diff --git a/arch/arm/boot/dts/am335x-bone-display-cape.dts b/arch/arm/boot/dts/am335x-bone-
>>display-cape.dts
>>
>>If this is mean to be included, why not use the .dtsi extension rather
>>than .dts. .dts implies it is a top-level file.
>>
> I followed the ideology given in in below discussion
> http://comments.gmane.org/gmane.linux.drivers.devicetree/13921
>
> As I understood .dtsi file extension should be used for silicon DT data which
> which remains common for all the boards using that silicon (like am33xx.dtsi).
> And .dts is for board specific DT data.
> However, anything works for me, as its just matter of file-name-extension.
> So should I rename all files to .dtsi ?

I believe the thread is not thinking of "board-level" as being add-on
boards. I don't think it disagrees that if it is an include file, it
should be called .dtsi. If it is called .dts, the assumption should be
that it results in a .dtb (or .dtbo if for an overlay --- not yet a
solution in mainline).

>
> [...]
>
>>> +/ {
>>> +       backlight {
>>> +               status = "disabled";
>>> +               compatible = "gpio-backlight";
>>> +               pinctrl-names = "default";
>>> +               pinctrl-0 = <&bbcape_backlight_pins>;
>>> +               gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>>> +               default-on;
>>> +       };
>>> +
>>> +       panel {
>>> +               status = "disabled";
>>
>>Where are you expecting to enable this? I'm guessing through your
>>u-boot hacking? Certainly I can see editing the boot script to make
>>this work, but I don't see how this results in the average user simply
>>plugging in the cape and having it work without having to edit files.
>>
> Yes, using u-boot commands, *without touching any source file*.
> I'm planning to send patch for adding following helper commands  in u-boot
> u-boot> fdt node enable <node-path>
> u-boot> fdt node disable <node-path>
> If that's accepted, enabling disabling capes will become very easy.
> And, as you said user can put these commands in scripts (like Uenv.txt)
> or environment variable, and execute them automatically at each boot.
>
>
>>Perhaps you can put some real logic into the bootloader that looks at
>>the cape EEPROMs?
>>
> No, I don't want to go the EEPROM way, because of reasons suggested
> in earlier mail. It's not scalable, especially when you don't have control
> over what type and how third-party is developing the capes.

Well, I have no interest in needing to manually switch my uEnv.txt
file based on whatever cape I have installed. Your patches to put
by-default-disabled disabled support for various capes into the the
main .dtb feels useful to me. I'm just going to optimize my systems to
utilize the EEPROM (when provided) to trigger loading the
configuration for me.

>
>
>>Have you considered using tools like pinmux-helper as is done with the
>>cape-universal overlay?
>>https://github.com/beagleboard/devicetree-source/blob/master/arch/arm/boot/dts/cape-universal-
>>00A0.dts
>>
> Yes, I have seen that. In pin-mux helper pins are configured not based on
> their actual names but as they appear on P8 and P9 headers of Beaglebone.
> - For shared pins, you have defined all possible functionality.
> - For dedicated pins, there is single fragment.
> Now there are two questions..
> (1) Do we need to update this cape-universal-xx.dts everytime a new
> Cape in market uses some dedicated pin for some muxed functionality ?

cape-universalXXX.dts needs to be moved into the main .dtb (via
.dtsi). Can you give an example of what you mean by shared pins and
dedicated pins here? It seems to me all the pins have multiple
fragments except ADC pins and perhaps the I2C port used for expansion
EEPROMs, but even that one CAN be muxed.

> (2) I'm not sure but kernel does _not_ free the memory allocated to
> DT fragment. If so, this universal fragment which has pin-mux for all
> P8 and P9 pins will block the memory forever. Would be good to know
> the in-memory size required for this universal fragment ?

How can I check easily? Obviously loading all of these drivers is
going to have an impact.

>
>
>>I've been hacking with adding all of these pinmux helpers to the main
>>.dts. I think you are encouraging me to add it to include files to
>>make it a bit more granular.
>>
>>http://paste.debian.net/106319/
>>
> Yes, using include files would be good.
> Also one minor feedback. Please use macros for Pin directions, Pulls, etc
> instead of hex numbers, it make it more readable. And then you don't need
> to specify that in comments.
> -  0xa0 0x08    /* lcd_data0.lcd_data0, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
> + 0xa0  (OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA)    /* lcd_data0.lcd_data0 */

If those are supported in the syntax and exist in some headers, I will use them.

>
>
>>I appreciate the enthusiasm to get this support into the mainline. If
>>it goes, I'll try to follow with a bunch of other outstanding changes
>>we have sitting in the vendor tree right now.
>>
> Thanks. Waiting for Tony to at-least 'Ack' or say if this is acceptable approach.
>
>
>>Have you looked at the features in the devicetree for this cape that
>>is currently pushed in the vendor tree?
>>
>>https://github.com/beagleboard/devicetree-source/blob/master/arch/arm/boot/dts/BB-BONE-LCD4-
>>01-00A1.dts
>>
> Yes, I have not added touchscreen support.
> I developed this DTS independently while debugging some Display v/s NAND issue.
> If these DTS patches are acceptable, then I'll refine them further.
>
>
> with regards, pekon
