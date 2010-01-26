From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 0/4] twl4030 threaded_irq support
Date: Tue, 26 Jan 2010 13:02:47 +0200
Message-ID: <20100126110247.GB13062@nokia.com>
References: <20091212183410.GF3092@sirena.org.uk>
 <1260786654-13294-1-git-send-email-felipe.balbi@nokia.com>
 <201001252306.55625.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21496 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab0AZLEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 06:04:44 -0500
Content-Disposition: inline
In-Reply-To: <201001252306.55625.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@openedhand.com>

On Tue, Jan 26, 2010 at 08:06:55AM +0100, ext David Brownell wrote:
>On Monday 14 December 2009, Felipe Balbi wrote:
>> move twl4030 children to threaded irq.
>>
>> Felipe Balbi (4):
>>   input: keyboard: twl4030: move to request_threaded_irq
>>   input: misc: twl4030: move to request_threaded_irq
>>   rtc: twl4030: move to request_threaded_irq
>>   usb: otg: twl4030: move to request_threaded_irq
>
>But nothing in drivers/mfd ... the entry to the whole stack?
>
>Did the threaded IRQ stuff ever get set up so that the top
>level IRQ thread didn't have to hand off to another thread
>each time?  (That's how the current stuff works.  One thread
>calling out to each handler.)
>
>If so, I'd like to see that be used here, rather than needlessly
>spend all those pages on mostly-unused stacks.

correct, that's still missing. I tried to play with it for a while, but 
had to give up due to other musb tasks. So if someone wants to step up 
and code that part, I'd be glad

-- 
balbi
