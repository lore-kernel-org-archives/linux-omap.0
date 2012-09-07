From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 09:10:50 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57309 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536Ab2IGJLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 05:11:11 -0400
In-Reply-To: <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
Cc: "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Domenico,

On Fri, Sep 07, 2012 at 14:18:39, Domenico Andreoli wrote:
> On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > Adopt pinctrl support to leds-gpio driver based on leds-gpio
> > device pointer, pinctrl driver configure SoC pins to GPIO
> > mode according to definitions provided in .dts file.
> 
> Shouldn't be the interaction with the pinctrl layer left to gpiolib?
> 

No, these gpio's are configured specifically for user leds.

So, leds-gpio driver should have this call, because these gpio
pins are used by leds-gpio driver.

+       am33xx_pinmux: pinmux@44e10800 {
+               userled_pins: pinmux_userled_pins {
+                       pinctrl-single,pins = <
+                               0x54 0x7       
+                               0x58 0x17       
+                               0x5c 0x7        
+                               0x60 0x17       
+                       >;
+               };
+       };
+

[...]

+               leds {
+                       compatible = "gpio-leds";
+                       pinctrl-names = "default";
+                       pinctrl-0 = <&userled_pins>;
                                      ^^^^^^^^^^^^

This devm_pinctrl_get_select_default() call in leds-gpio driver
will internally take userled_pins node and configure those pins
according to the above definitions.

Lets take gpio-keypad driver, in that case we have to configure
pins as INPUT mode (generic gpio driver might not know what
the end usecase is) and this leds case we configure as OUTPUT
mode.

Thanks
AnilKumar
