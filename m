From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa
 driver.
Date: Wed, 06 Sep 2006 23:07:09 +0300
Message-ID: <44FF2A6D.3000500@cc.jyu.fi>
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751538AbWIFUHf@vger.kernel.org>
In-Reply-To: <20060905151808.GC18073@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


>> now Tux can finally call home :-)
>>     
>
> Cool that you got the phone features working :)
>   
Yes,  and gprs is also working nicely with the pppd so I can finally
start eating dog food :-)
Some problems there still are

1) As we do not yet have any kind of multiplexing support to gsm module
(currently directly accesing dev/ttyS1 for at commands)
our phone app is not able to run simultaneously with the ppp. I am not
sure should I resolve this in the kernel space or user space.

2) I can not suspend/resume by using power button but we have still
problem from waking up the iPAQ
from suspend for the incoming calls.
So far I have tried to enable UART2 wakeup by using

    level2_wake |= OMAP_IRQ_BIT(INT_MPUIO);

in omap_pm_wakeup_setup() method of plat-omap/pm.c but did not have
success with that.
Could you have any idea for this one?

Mika
