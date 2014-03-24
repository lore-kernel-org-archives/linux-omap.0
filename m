From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Mon, 24 Mar 2014 14:01:30 -0500
Message-ID: <5330810A.3090004@ti.com>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com> <20140321055242.GA1959@saruman.home> <53304F76.8090703@ti.com> <20140324185027.GC12500@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57159 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbaCXTB6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2014 15:01:58 -0400
In-Reply-To: <20140324185027.GC12500@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Dave Gerlach <d-gerlach@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, nsekhar@ti.com, rnayak@ti.com, mark.rutland@arm.com

On 03/24/2014 01:50 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Mar 24, 2014 at 10:29:58AM -0500, Dave Gerlach wrote:
>> On 03/21/2014 12:52 AM, Felipe Balbi wrote:
>>> On Fri, Mar 21, 2014 at 10:50:13AM +0530, Lokesh Vutla wrote:
>>>> From: Dave Gerlach <d-gerlach@ti.com>
>>>>
>>>> Do not reset GPIO5 at boot-up because GPIO5_7 is used
>>>> on AM437x GP-EVM to control VTT regulators on DDR3.
>>>> Without this some GP-EVM boards will fail to boot because
>>>> of DDR3 corruption.
>>>>
>>>> Reported-by: Nishanth Menon <nm@ti.com>
>>>> Tested-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>
>>> every now and again we see a patch like this because yet another board
>>> is using a GPIO to toggle DDR regulators.
>>>
>>> Instead of constantly patching things like this, how about we try
>>> something like below (build-tested only):
>>
>> Why should we change all of them? Is it correct to leave every single GPIO
>> at the mercy of the bootloader in every situation? The reason we see these
> 
> it's not leaving anything at the mercy of the bootloader. It's simply
> looking at the HW itself and asking "what's the current state of this
> GPIO ?"

And you assume here that every GPIO pin left in what ever state by
bootloader is the correct state for kernel to function in? that is not
exactly a good idea from even power consumption perspective - example
GPIOs used by bootloader to detect board revision is not used in
kernel, leaving such GPIOs active is not optimal, certain other GPIOs
used by external peripherals might even be wrongly configured by
bootloader issues -> the idea of ti,no-reset-on-init is to ensure that
we *know* which instances "need special handling" and we depend on
bootloader configuration.

Taking it a step further, why is "not doing IP module kernel reset"
just a constraint for GPIO then? Why not leave every IP module in what
ever state bootloader left it at?

>> patches only every now and again is because it's a special case that should
> 
> I wouldn't call it "special". A GPIO block is pretty dumb, its registers
> only give you current pin state, there's virtually no state machine
> involved whatsoever.
> 
>> be handled only for that situation. I also don't think it makes sense
>> to make gpio's a unique case that never gets reset while every other
>> IP does by default.
> 
> Well, if it doesn't need to be reset, why would you spend that time
> resetting it ? In the GPIO case, you gain nothing by resetting the IP,
> nothing at all, other than "now I'm sure the IP is in
> no-standby/no-idle" but that can be easily read back from SYS[SC]
> registers anyway.

because, you do not know how else the system might be used. instead of
assuming the bootloader or host OS (in a virtualized environment) will
always be doing the right thing, kernel takes responsibility of
peripherals and exceptions are clearly marked (such as with
ti,no-reset-on-init;).

> 
> The point is that we have two choices here:
> 
> a) every time a new board comes around using GPIO as an enable signal
> for DDR, we spend a few days debugging why it's not booting.

yeah - read the darned schematics - this is valid for anyone doing
board/platform bringup - this is the right way to do it.

> 
> b) make sure no GPIO block is ever reset, so we never go through the
> debugging cycle again.
> 
the holy grail of new bugs! Sigh!

-- 
Regards,
Nishanth Menon
