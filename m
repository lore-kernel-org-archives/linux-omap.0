From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
Date: Tue, 29 Apr 2014 12:53:45 +0200
Message-ID: <535F84B9.6000406@collabora.co.uk>
References: <5523458.JVZJJObMjC@wuerfel> <535EEB58.60809@collabora.co.uk> <13943940.Yb2C7lPSBy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:52993 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbaD2Kxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 06:53:51 -0400
In-Reply-To: <13943940.Yb2C7lPSBy@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello Arnd,

On 04/29/2014 12:26 PM, Arnd Bergmann wrote:
> On Tuesday 29 April 2014 01:59:20 Javier Martinez Canillas wrote:
>> This driver is also used by OMAP1. Even when disabling GPIO_OMAP on that
>> platform doesn't cause a build error since no function defined in the driver is
>> used directly by platform code, I think that we always want this driver on OMAP1
>> too.
>> 
>> > However, it seems entirely reasonable to include the driver in build tests
>> > on other platforms, so we should also allow building it for COMPILE_TEST
>> > builds and select the required GENERIC_IRQ_CHIP that may not already be
>> > enabled on other platforms.
>> > 
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> > index c58b828..c8c42be 100644
>> > --- a/drivers/gpio/Kconfig
>> > +++ b/drivers/gpio/Kconfig
>> > @@ -244,9 +244,10 @@ config GPIO_OCTEON
>> >         family of SOCs.
>> >  
>> >  config GPIO_OMAP
>> > -     bool "TI OMAP GPIO support"
>> > +     bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS
>> 
>> So this should be:
>> 
>> +       bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS &&
>> !ARCH_OMAP1
>> 
> 
> Well, if COMPILE_TEST is disabled on OMAP1, the option is already
> hidden and enabled in my version. It seems reasonable to me to 
> allow compile-testing OMAP1 without the GPIO driver, while a kernel
> running on OMAP1 should always have COMPILE_TEST disabled.
> 
> 	Arnd
> 

I understand your point. I thought you also wanted to be sure that the option
will be hidden in platforms where it make sense to always enable GPIO_OMAP even
if COMPILE_TEST is enabled.

If the idea of this patch is to only avoid build errors when GPIO_OMAP is
disabled and allowing build testing the driver in other platforms, then I'm ok
with your patch and feel free to add my Acked-by tag.

And you are right that COMPILE_TEST is disabled in omap1_defconfig and after all
there are so many drivers needed for a platform to be usable on boot. So one has
to take care of enabling all the needed options as long as there isn't a
combination that cause a build error like the one you are fixing here.

Thanks a lot and best regards,
Javier
