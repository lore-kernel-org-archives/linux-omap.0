From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: RX51: support sleep indicator LEDs
Date: Fri, 02 Oct 2009 09:18:42 -0700
Message-ID: <87tyyh7orh.fsf@deeprootsystems.com>
References: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>
	<20091002155944.GV1133@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:37363 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbZJBQSj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 12:18:39 -0400
Received: by pxi9 with SMTP id 9so1253753pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 02 Oct 2009 09:18:43 -0700 (PDT)
In-Reply-To: <20091002155944.GV1133@earth.li> (Jonathan McDowell's message of "Fri\, 2 Oct 2009 16\:59\:44 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap@vger.kernel.org

Jonathan McDowell <noodles@earth.li> writes:

> On Fri, Oct 02, 2009 at 08:35:55AM -0700, Kevin Hilman wrote:
>> The sleep indicator LEDs can be enabled/disabled by toggling GPIO162.
>> Request this GPIO in RX51 board init, disable by default and expose
>> GPIO162 to userspace so LEDs can be toggled from userspace:
>
> Wouldn't this be better done using the LED class subsystem?

No, these are HW controlled LEDs which blink based on whether the OMAP
is hitting retention or OFF mode etc.  The software has no control
over the blinking of LEDs themselves.  The GPIO simply enables them.

Kevin


>> To enable:
>> 
>>   # echo 1 > /sys/class/gpio/gpio162/value
>> 
>> To disable:
>> 
>>   # echo 0 > /sys/class/gpio/gpio162/value
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>
> J.
>
> -- 
> 101 things you can't have too much of : 16 - Time.
