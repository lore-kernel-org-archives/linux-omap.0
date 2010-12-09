From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource structure
Date: Thu, 09 Dec 2010 22:34:04 +0300
Message-ID: <4D012F2C.9060303@ru.mvista.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com> <8762xo62b5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64843 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0LITf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 14:35:28 -0500
In-Reply-To: <8762xo62b5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Frysinger <vapier@gentoo.org>

Hello.

Kevin Hilman wrote:

>> The resource data is getting automatically populated from a set of data
>> generated from TI's hardware database for the OMAP platform, 
>> While we could hack in some exceptions to that tool to generate resources
>> in a specific order, it seems less fragile to use the resource name
>> instead.That way, no matter what order the resources are generated, the
>> driver still work. 

>> Modified the OMAP,Blackfin and Davinci architecture files to add the name of the IRQs
>> in the resource structures and musb driver to use the get_irq_byname() api to
>> get the device and dma irq numbers instead of using the index.

>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Mike Frysinger <vapier@gentoo.org>
>> ---

> For the davinci changes:

> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> Kevin

[...]

>> Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>> +++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>> @@ -64,10 +64,12 @@ static struct resource usb_resources[] =
>>  	{
>>  		.start          = IRQ_USBINT,
>>  		.flags          = IORESOURCE_IRQ,
>> +		.name		= "mc"
>>  	},
>>  	{
>>  		/* placeholder for the dedicated CPPI IRQ */
>>  		.flags          = IORESOURCE_IRQ,
>> +		.name		= "dma"
>>  	},
>>  };

    Argh! This failed to also modify da8xx_usb20_resources[]... :-(

WBR, Sergei
