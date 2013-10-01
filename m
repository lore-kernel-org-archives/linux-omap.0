From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/2] gpio/omap: maintain GPIO and IRQ usage separately
Date: Tue, 01 Oct 2013 09:34:24 +0200
Message-ID: <524A7B00.4010001@collabora.co.uk>
References: <1380069414-2922-1-git-send-email-javier.martinez@collabora.co.uk> <87r4cajfx0.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:36422 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3JAHfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Oct 2013 03:35:00 -0400
In-Reply-To: <87r4cajfx0.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, r.sricharan@ti.com, holler@ahsoftware.de

On 09/27/2013 08:08 PM, Kevin Hilman wrote:
> Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:
> 
>> The GPIO OMAP controller pins can be used as IRQ and GPIO
>> independently so is necessary to keep track GPIO pins and
>> IRQ lines usage separately to make sure that the bank will
>> always be enabled while being used.
>>
>> Also move gpio_is_input() definition in preparation for the
>> next patch that setups the controller's irq_chip driver when
>> a caller requests an interrupt line.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> I'm fine with this appproach.  For both patches:
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Also, I gave it a spin across a handful of OMAP boards using v3.12-rc2 +
> these 2 patches.
> 
> Boot tested successfully with DT boot:
> 
> omap3530/beagle
> omap3730/beagle-xm
> omap3530/overo (Tobi w/GPIO IRQ networking)
> omap3730/overo STORM (w/GPIO IRQ for networking)
> am335x/beaglebone
> am335x/beaglebone black
> omap4430/panda
> omap4460/panda-es
> omap5912/OSK (omap1)
> 
> I also verified non-DT boot on the OMAP3 platforms that still support
> legacy boot.
> 
> So feel free to also add
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Thanks for your persistence in getting a fix for this upstream.
> 
> Kevin
> 

Thanks a lot Kevin for testing on so many boards.

Linus,

Since this patch-set doesn't cause any regression and fix a long standing issue
on OMAP, do you think that it would be possible to include on the -rc series as
a bugfix or do you prefer to wait until 3.13?

Thanks a lot and best regards,
Javier
