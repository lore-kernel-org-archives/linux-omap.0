From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] gpio/omap: fix pm_runtime for IRQ functions
Date: Tue, 22 Jan 2013 11:07:45 +0100
Message-ID: <CACRpkdbtUo4oU_yjwukuYW89sk4OM0NY+ZcwQprLEu_9mqZFgg@mail.gmail.com>
References: <1358531362-27933-1-git-send-email-jlu@pengutronix.de>
	<50FCE27D.7060500@ti.com>
	<CACRpkdYpCbWtk6PbgLm0HWFBihDqA_G_1btYQ38+WfeXridPJA@mail.gmail.com>
	<50FE61CB.5010906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:56303 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab3AVKHq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 05:07:46 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so11247697iea.38
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 02:07:46 -0800 (PST)
In-Reply-To: <50FE61CB.5010906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Jan Luebbe <jlu@pengutronix.de>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org

On Tue, Jan 22, 2013 at 10:54 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Tuesday 22 January 2013 01:52 PM, Linus Walleij wrote:
>>
>> In the Nomadik I had a similar situation with a GPIO used for the
>> ethernet IRQ. I put the GPIO number in a special board-specific
>> node and added this to the machine,
>
> Thanks Linus. Are there any bindings already available on how these
> special board-specific nodes can be defined in the dts files?

No generic bindings as they are per definition board-specific.

So in the Nomadik case it looks like this:

        /* Custom board node with GPIO pins to active etc */
        usb-s8815 {
                /* The S8815 is using this very GPIO pin for the SMSC91x IRQs */
                ethernet-gpio {
                        gpios = <&gpio3 19 0x1>;
                        interrupts = <19 0x1>;
                        interrupt-parent = <&gpio3>;
                };
                /* This will bias the MMC/SD card detect line */
                mmcsd-gpio {
                        gpios = <&gpio3 16 0x1>;
                };
        };

First I added custom nodes to the IP blocks, but it was no good idea
as it's not generic for that driver at all, just a board pecularity.

> Are there any using some such in the mainline already?

I just sent a pull request for the Nomadik example but I don't
know about any others.

Yours,
Linus Walleij
