From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Mon, 24 Sep 2012 15:54:22 +0300
Message-ID: <CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
	<20120924121538.GH2892@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59941 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab2IXMyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 08:54:24 -0400
In-Reply-To: <20120924121538.GH2892@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Philippe De Swert <philippe.deswert@jollamobile.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On 24/09/2012, Felipe Balbi <balbi@ti.com> wrote:
> SoB's mail doesn't From mail.

Well still in the progress of migrating of my personal to work laptop.
Since the patch does not seem correct the replacement will have
matching addresses.

>> /*-------------------------------------------------------------------------*/
>>
>>  #if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
>> -	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
>> +	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500) || \
>> +	defined(CONFIG_ARCH_OMAP2PLUS)
>
> Weird, how can you build OMAP2PLUS without SOC_OMAPXXXX ??

It seems entirely possible. I quickly tried to look if it got defined
somewhere and it does not seem to be set anywhere.  That is why I got
the impression it was replaced by CONFIG_ARCH_OMAP2PLUS. I'll dig
deeper to find out why SOC_OMAPXXXX is not set if it should be.

>From the .config I got (used menuconfig)

#
# TI OMAP2/3/4 Specific Features
#
CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
CONFIG_SOC_HAS_OMAP2_SDRC=y
# CONFIG_ARCH_OMAP2 is not set
CONFIG_ARCH_OMAP3=y
# CONFIG_ARCH_OMAP4 is not set
# CONFIG_SOC_OMAP5 is not set
# CONFIG_SOC_OMAP3430 is not set
# CONFIG_SOC_TI81XX is not set
# CONFIG_SOC_AM33XX is not set
CONFIG_OMAP_PACKAGE_CBB=y

Not a mention of CONFIG_SOC_OMAP2430 and  CONFIG_SOC_OMAP3430 did not
get set (while it is not a 3430 but a 3630 I am using). Maybe
CONFIG_ARCH_OMAP3 would have been a better choice then?

> BTW, this is also wrong as OMAP2PLUS is also used to enable AM3xxx and
> TI8xxx, and those platforms don't use generic_interrupt().

It would not break them from what I could see in musb_core.c

        musb->isr = generic_interrupt;
        status = musb_platform_init(musb); <--- isr would be (re)set here
        if (status < 0)
                goto fail1;

        if (!musb->isr) {
                status = -ENODEV;
                goto fail2;
        }

The two you mention set their own interrupt routines.
drivers/usb/musb/da8xx.c:	musb->isr = da8xx_musb_interrupt;
drivers/usb/musb/am35x.c:	musb->isr = am35x_musb_interrupt;


Regards,

Philippe
