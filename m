From: Afzal Mohammed <afzal@ti.com>
Subject: Re: AM335x, early printk
Date: Tue, 20 Aug 2013 16:44:14 +0530
Message-ID: <52134F86.3010503@ti.com>
References: <5211FFA3.6060407@linutronix.de> <CAORVsuWy3D1WcCMbr0UB-kp+DOMMro30xicd-Mxf34MYyVGpdg@mail.gmail.com> <52121176.2050401@linutronix.de> <5213379D.4010006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab3HTLO1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Aug 2013 07:14:27 -0400
In-Reply-To: <5213379D.4010006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jean Pihet <jean.pihet@newoldbits.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sebastian,

On Tuesday 20 August 2013 03:02 PM, Lokesh Vutla wrote:

>> Yes. I do not see the decompress messages but I have an early console
>> later on. Unfortunately it stops now right at the serial core:
>>
>> |pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
>> |Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled

> I guess you are missing the following series from Rajendra. 
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92515.html

I think Lokesh's suggestion is more likely to help your case than mine.

Regards
Afzal

