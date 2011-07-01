From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: gpio interrupt is not invoked on Panda board
Date: Fri, 1 Jul 2011 16:17:44 -0500
Message-ID: <4E0E3978.9050805@ti.com>
References: <1309543835.48880.YahooMailClassic@web161712.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59339 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757559Ab1GAVRp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:17:45 -0400
In-Reply-To: <1309543835.48880.YahooMailClassic@web161712.mail.bf1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: linux-omap@vger.kernel.org

Hi Henry

On 7/1/2011 1:10 PM, hong zhang wrote:
> List,
>
> I try to get gpio_191 ping interrupted on panda but never succeeded. What I do is
>
> 1. set 0x410b on dpm_emu19 register to enable interrupt and wakeup
>     on gpio_191
> 2. set bit 31 to 1 on GPIO_IRQSTATUS_SET_0 register at 0x4805d034
> 3. set bit 31 to 1 on GPIO_IRQWAKEN_0 register at 0x4805d044
> 4. set bit 31 to 0 on GPIO_OE register at 0x4805d134 (output)
> 5. set bit 31 to 1 on GPIO_SETDATAOUT register at 0x4805d194
>
> Then I expect I should see interrupt on GPIO_IRQSTATUS_0 register at 0x4805d02c. But nothing happens for both output and input (put pin on ground or 1,8v).

You will not get an interrupt if you are configuring the gpio as an 
output (GPIO_OE[31] = 0).

Jon
