From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 1/2] OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
Date: Wed, 29 Feb 2012 11:10:26 +0000
Message-ID: <4F4E07A2.5030008@gmx.de>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>	 <1330505302-8258-2-git-send-email-tomi.valkeinen@ti.com>	 <4F4DF801.3000905@gmx.de> <1330510902.1934.76.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:54663 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757731Ab2B2LKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 06:10:49 -0500
In-Reply-To: <1330510902.1934.76.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi Tomi,

On 02/29/2012 10:21 AM, Tomi Valkeinen wrote:
> On Wed, 2012-02-29 at 10:03 +0000, Florian Tobias Schandinat wrote:
>> On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
>>> panel-dvi uses i2c, but the Kconfig didn't have dependency on I2C. Add
>>> it.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>  drivers/video/omap2/displays/Kconfig |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
>>> index 74d29b5..408a992 100644
>>> --- a/drivers/video/omap2/displays/Kconfig
>>> +++ b/drivers/video/omap2/displays/Kconfig
>>> @@ -12,7 +12,7 @@ config PANEL_GENERIC_DPI
>>>  
>>>  config PANEL_DVI
>>>  	tristate "DVI output"
>>> -	depends on OMAP2_DSS_DPI
>>> +	depends on OMAP2_DSS_DPI && I2C
>>
>> It's just a matter of taste, but are you sure you want to "depend" on it and not
>> "select" it? Other drivers tend to use select for I2C, for me it doesn't really
>> matter.
> 
> Well, I'd like to "select", but I don't think that's correct. From
> Documentation/kbuild/kconfig-language.txt:
> 
>         In general use select only for non-visible symbols
>         (no prompts anywhere) and for symbols with no dependencies.
> 
> But I do see quite many selects for I2C, so I'm not sure if all those
> are wrong, or has it just been decided that I2C is a valid target for
> select.

I'd say that the above is only a guideline but not absolute rule. For I2C I'd
argue that I probably wouldn't even know that my hardware has it if I weren't
the one writing the driver using it.
But it's true that select should be used with care as it is much easier to get
the config messed up by using it.

> Using depend is in line with the other panel drivers in the same
> directory. I've been thinking about the same thing from time to time,
> and I'd rather select I2C, SPI and BACKLIGHT_CLASS_DEVICE than use
> depend.
> 
> But, for example, using select to BACKLIGHT_CLASS_DEVICE is broken: if I
> change a panel driver to select BACKLIGHT_CLASS_DEVICE, but then I
> manually disable CONFIG_BACKLIGHT_LCD_SUPPORT (which the
> BACKLIGHT_CLASS_DEVICE depends on) from the kernel config, this leads to
> BACKLIGHT_CLASS_DEVICE being enabled, but CONFIG_BACKLIGHT_LCD_SUPPORT
> being disabled, which is clearly broken.

Yes, as far as I understand the problem here is that we don't have any mechanism
to handle transitive dependencies (probably because we don't want it). So if one
wants to do select something I think the right way to do it would be to inherit
all its select/depend statements in the option.

> So... As I see it, depending is a bit awkward, but it's correct.

Yes, it certainly is correct.


Best regards,

Florian Tobias Schandinat
