From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: AM335x, early printk
Date: Tue, 20 Aug 2013 15:02:13 +0530
Message-ID: <5213379D.4010006@ti.com>
References: <5211FFA3.6060407@linutronix.de> <CAORVsuWy3D1WcCMbr0UB-kp+DOMMro30xicd-Mxf34MYyVGpdg@mail.gmail.com> <52121176.2050401@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51488 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab3HTJcZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Aug 2013 05:32:25 -0400
In-Reply-To: <52121176.2050401@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mohammed, Afzal" <afzal@ti.com>

Hi Sebastian,

On Monday 19 August 2013 06:07 PM, Sebastian Andrzej Siewior wrote:
> On 08/19/2013 02:27 PM, Jean Pihet wrote:
>> Hi!
> 
> Hi Jean,
> 
>> You need to add 'earlyprintk' in the kernel command line, given (I
>> suppose) by U-Boot.
> 
> Ah, good hint.
> 
>>
>> I hope this helps!
> 
> Yes. I do not see the decompress messages but I have an early console
> later on. Unfortunately it stops now right at the serial core:
> 
> |pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
> |Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
I guess you are missing the following series from Rajendra. 

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92515.html

Thanks and regards,
Lokesh
> 
>>
>> Jean
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

