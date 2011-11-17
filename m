From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 17 Nov 2011 16:56:01 +0530
Message-ID: <CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com>
	<4EC1EB9D.1000503@ti.com>
	<CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 17 November 2011 13:38, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Linus,
>> Is there a plan to move even the data that exists in the pinmux
>> drivers today (including the function/pin-groups definition)
>> eventually to DT? Or is it just the 'mapping' data to map
>> devices to functions (that today is done from board files) which
>> alone will be moved?
>
> Not for the U300 driver, for the simple reason that it cannot
> use device tree. So both methods of providing the data need
> to be allowed - either as static data (the U300 driver does not
> even have platform data, the pin data is encoded in the driver
> itself since it's tied to U300 and not used for any other systems
> or variants) or as device tree lookups.
>
> That said I have no clue on how to make the DT bindings
> FTM, patches and suggestions welcome.

For now, the Samsung GPIO, Pinconfig and Pinmux information is
represented in device tree as listed below.

i2c@1C004000 {
          compatible = "...";
          reg = <0x... 0x..>;
           gpios = <&gpa0 2 2 3 0>,
                      <&gpa0 3 2 3 0>;
          ...
};

The format of the gpio specifier is
<[Pad Controller phandle] [pin number within the controller] [Pin Mux
Function] [Pull Up/Down] [Drive Strength]>

>From a perspective of writing a 'gpios' property for a device node,
this is quite simple. Looking up the hardware manual of the SoC can
provide all the values that should be used in the gpio specifier.

The GPIO/PinCtrl driver can provide a translate function that picks up
the values for the gpio specifier and writes the same value to the
pad-controller registers. But, this a deviation from the existing
pinctrl subsystem code which mainly relies on name of the pin-group
and pin-function.

Does this seem to be a feasible option for specifying
gpio/pinconfig/pinmux dt bindings?

Thanks.
Thomas.
