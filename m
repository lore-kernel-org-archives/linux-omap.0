From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH RFC 1/7] platform: add a device node
Date: Mon, 11 Feb 2013 11:33:19 +0100
Message-ID: <CAAwP0s0_HivRRDuBAEi4TJMB6DnbicDy1FiT7G3NcNs996V7qA@mail.gmail.com>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk>
 <20130210010246.GA1455@kroah.com> <5116FCA1.40703@collabora.co.uk>
 <20130210093708.GL17852@n2100.arm.linux.org.uk> <CAAwP0s0fCJmUfTJweGhXj5bXsQ0Gov9JbUJtqYMwL7duNLZv_Q@mail.gmail.com>
 <20130211081632.GI1906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:45840 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab3BKKdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 05:33:40 -0500
Received: by mail-vb0-f44.google.com with SMTP id fr13so3603941vbb.31
        for <linux-omap@vger.kernel.org>; Mon, 11 Feb 2013 02:33:39 -0800 (PST)
In-Reply-To: <20130211081632.GI1906@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 11, 2013 at 9:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sun, Feb 10, 2013 at 12:35:43PM +0100, Javier Martinez Canillas wrote:
>> On Sun, Feb 10, 2013 at 10:37 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Sun, Feb 10, 2013 at 02:49:21AM +0100, Javier Martinez Canillas wrote:
>> >> I knew this would be controversial and that's why I didn't mean it to be a patch
>> >> but a RFC :)
>> >>
>> >> The problem basically is that you have to associate the platform device with its
>> >> corresponding DT device node because it can be used in the driver probe function.
>> >
>> > When DT is being used, doesn't DT create the platform devices for you,
>> > with the device node already set correctly?
>> >
>>
>> Well they usually do but not always just like usually you have a
>> platform_device in your board code and call platform_device_register().
>>
>> But in some configurations you can't just define the platform_device
>> required resources (I/O memory, IRQ, etc) as static platform data.
>> In some cases you need a level of indirection.
>>
>> In this particular case a SMSC ethernet chip is connected to an
>> OMAP3 processor through its General-Purpose Memory Controller.
>>
>> You can't just define the I/O memory used by the device since you first
>> need to request that address to the GPMC. The same happens with the
>> IRQ line since a OMAP GPIO pin is used so you have to first configure
>> the GPIO line as input.
>
> For the gpio interrupt you can use, example taken from omap4-var-som.dts:
>
>         interrupt-parent = <&gpio6>;
>         interrupts = <11>; /* gpio line 171 */
>
> Other architectures allow to specify the edge/level hi/low active
> parameters from the devicetree aswell. The gpio direction should be
> handled by the gpio driver as necessary, at least that's what done on
> other architectures.
>
> If the SMSC hangs on the GPMC then the SMSC should be a child node of
> the GPMC. The GPMC would then act as a bus driver and configure the
> chipselects and timings for its children automatically, maybe based
> on timing information from the devicetree. I've never tried this before,
> but I think that's the way things should be.
>

Hi Sasha,

The SMSC is already a child node of the GPMC in the device tree but instead
using the generic SMSC binding I added a GPMC-specific SMSC binding.

Since the SMSC binding doesn't have a chip select property and it expects
the I/O memory address to be explicitly defined in the reg property while
the GPMC needs to request this memory according to the chip select used.

> No need to manually create platform devices from the devicetree.
>

Thanks a lot for your feedback, I'll go back and think more about this and try
to solve this using a different approach that won't require changing
the platform
device info structure and reusing the generic SMSC LAN DT binding.

> Sascha
>

Best regards,
Javier
