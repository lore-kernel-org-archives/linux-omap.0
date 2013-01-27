From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: fix pm_runtime for IRQ functions
Date: Sun, 27 Jan 2013 18:35:24 +0530
Message-ID: <51052614.5020606@ti.com>
References: <1358531362-27933-1-git-send-email-jlu@pengutronix.de> <50FCE27D.7060500@ti.com> <CACRpkdYpCbWtk6PbgLm0HWFBihDqA_G_1btYQ38+WfeXridPJA@mail.gmail.com> <50FE61CB.5010906@ti.com> <CACRpkdbtUo4oU_yjwukuYW89sk4OM0NY+ZcwQprLEu_9mqZFgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683Ab3A0NE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Jan 2013 08:04:27 -0500
In-Reply-To: <CACRpkdbtUo4oU_yjwukuYW89sk4OM0NY+ZcwQprLEu_9mqZFgg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Jan Luebbe <jlu@pengutronix.de>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Jon Hunter <jon-hunter@ti.com>

On Tuesday 22 January 2013 03:37 PM, Linus Walleij wrote:
> On Tue, Jan 22, 2013 at 10:54 AM, Rajendra Nayak <rnayak@ti.com> wrote:
>> On Tuesday 22 January 2013 01:52 PM, Linus Walleij wrote:
>>>
>>> In the Nomadik I had a similar situation with a GPIO used for the
>>> ethernet IRQ. I put the GPIO number in a special board-specific
>>> node and added this to the machine,
>>
>> Thanks Linus. Are there any bindings already available on how these
>> special board-specific nodes can be defined in the dts files?
>
> No generic bindings as they are per definition board-specific.
>
> So in the Nomadik case it looks like this:
>
>          /* Custom board node with GPIO pins to active etc */
>          usb-s8815 {
>                  /* The S8815 is using this very GPIO pin for the SMSC91x IRQs */
>                  ethernet-gpio {
>                          gpios = <&gpio3 19 0x1>;
>                          interrupts = <19 0x1>;
>                          interrupt-parent = <&gpio3>;
>                  };
>                  /* This will bias the MMC/SD card detect line */
>                  mmcsd-gpio {
>                          gpios = <&gpio3 16 0x1>;
>                  };
>          };
>
> First I added custom nodes to the IP blocks, but it was no good idea
> as it's not generic for that driver at all, just a board pecularity.
>
>> Are there any using some such in the mainline already?
>
> I just sent a pull request for the Nomadik example but I don't
> know about any others.
>
Thanks Linus for the pointer.

Regards
Santosh
