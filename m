From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 17 Nov 2011 16:20:46 +0530
Message-ID: <4EC4E706.3050603@ti.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>	<1321274409-24643-2-git-send-email-rnayak@ti.com> <CACRpkdbxU-ViubfGGt7mqzNPhn2E3MHAhQsvsgRsC555uBQBiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:34398 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755511Ab1KQKuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 05:50:54 -0500
Received: by mail-yx0-f169.google.com with SMTP id m10so1128018yen.14
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 02:50:53 -0800 (PST)
In-Reply-To: <CACRpkdbxU-ViubfGGt7mqzNPhn2E3MHAhQsvsgRsC555uBQBiQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linus.walleij@stericsson.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

On Thursday 17 November 2011 01:50 PM, Linus Walleij wrote:
> On Mon, Nov 14, 2011 at 1:40 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
>
> (...)
>> + * The OMAP control module has a device-control sub-module
>> + * which handles all pin/padmuxing for OMAP. The sub-module
>> + * is further split into a 'core' instance within the CORE
>> + * powerdomain and a 'wkup' instance within the WAKEUP
>> + * powerdomain (which is always powered on)
> (...)
>> +/* omap4 core pads */
>> +static const struct pinctrl_pin_desc omap4_core_pads[] = {
>> +       PINCTRL_PIN(0, "c12"),
>> +       PINCTRL_PIN(1, "d12"),
>> +       PINCTRL_PIN(2, "c13"),
> (...)
>> +/* omap4 wkup pads */
>> +static const struct pinctrl_pin_desc omap4_wkup_pads[] = {
>> +       PINCTRL_PIN(0, "c12"),
>> +       PINCTRL_PIN(1, "d12"),
>> +       PINCTRL_PIN(2, "c13"),
> (...)
>
> I have a hard time wrapping my head around why you need to define
> all the same pads twice and adding two almost identical pin
> controllers.

Oops, I seem to have completely messed up with the omap4_wkup_pads
table.. It should have been just these pins from the table

+	PINCTRL_PIN(50, "h4"),
+	PINCTRL_PIN(51, "j2"),
+	PINCTRL_PIN(52, "g2"),
+	PINCTRL_PIN(53, "j1"),
+	PINCTRL_PIN(54, "k1"),
+	PINCTRL_PIN(55, "ag9"),
+	PINCTRL_PIN(56, "af9"),
+	PINCTRL_PIN(57, "ah6"),
+	PINCTRL_PIN(58, "ag8"),
+	PINCTRL_PIN(59, "ad1"),
+	PINCTRL_PIN(60, "ad2"),
+	PINCTRL_PIN(61, "ad3"),
+	PINCTRL_PIN(62, "ad4"),
+	PINCTRL_PIN(63, "ac2"),
+	PINCTRL_PIN(64, "ac3"),
+	PINCTRL_PIN(65, "ag7"),
+	PINCTRL_PIN(66, "ae7"),
+	PINCTRL_PIN(67, "af7"),
+	PINCTRL_PIN(68, "ah7"),
+	PINCTRL_PIN(69, "ag6"),
+	PINCTRL_PIN(70, "af8"),
+	PINCTRL_PIN(71, "ae8"),
+	PINCTRL_PIN(72, "ah2"),
+	PINCTRL_PIN(73, "ag1"),
+	PINCTRL_PIN(74, "ae3"),
+	PINCTRL_PIN(75, "ah1"),
+	PINCTRL_PIN(76, "ae1"),
+	PINCTRL_PIN(77, "ae2"),

But somehow I ended up with having the first 49 pins duplicated from
the omap4_core_pads table.
Will fix up, and sorry for all the confusion.

>
> Probably it's just me lacking understanding ...
>
> My recent thinking about wakeups is rather (built on experience with
> the hardware I've seen) that you define a number of states for each
> pinmux group so it can be set in say active, low_power and sleep
> state, which will reconfigure the pads associated with each mux for
> respective mode.
>
> In the current pin config patch set we also have a
> PIN_CONFIG_WAKEUP property that can be set on a per-pin
> basis to say configure that a specific pin shall trigger a wakeup
> of the system if it's in sleep state.
>
> So my idea is that when you switch states of pin muxes, say from
> active to sleeping, the subsystem will call the driver to reprogram
> the pins to sleep mode, typically grounding some pins, biasing
> some other pins and setting the wakeup property of some
> pins.
>
> So is this really two different sets of registers for the same pads at
> totally different places in memory, or is this some way of modeling
> different modes for the same pads? If it's the latter we need some
> better abstraction than doing it all twice.

These are different pads/pins and controlled through different set of
registers.

>
> Yours,
> Linus Walleij

