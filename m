From: Michael Trimarchi <michael@panicking.kicks-ass.org>
Subject: Re: Gumstix Overo non-responsive TTY after resume
Date: Thu, 10 Jun 2010 00:48:18 +0200
Message-ID: <4C101A32.20201@panicking.kicks-ass.org>
References: <D6DB9C7EDECDA944B870F62B587008622C89C6@NL-EXC-06.intra.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from panicking.kicks-ass.org ([95.141.32.57]:48477 "EHLO
	panicking.kicks-ass.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374Ab0FIXKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 19:10:25 -0400
In-Reply-To: <D6DB9C7EDECDA944B870F62B587008622C89C6@NL-EXC-06.intra.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Lukassen <Robert.Lukassen@tomtom.com>
Cc: linux-omap@vger.kernel.org

Robert Lukassen wrote:
> Hi,
> 
> I've just started with the linux-omap-pm branch, and are experiencing problems with the keyboard when resuming from sleep. There seems to be an earlier post on this matter:
> 
>>> 4) Suspend to memory (echo mem > /sys/power/state) works now, but when I
>>> wake up the board (via a keypress), I am no longer able to type anything
>>> at the prompt. Any clue about this one?
>> Indeed, I was able to reproduce this as well and seems to be a new
>> regression in the PM branch.  I see the same on omap3evm and n900 now
>> too.mount 
>>
>> If you enable the UART timeouts + sleep_while_idle, you should avoid
>> this problem while I try and figure out what's going on:
>>
>> echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
>> echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
>> echo 5 > /sys/devices/platform/serial8250.2/sleep_timeout
>> echo 1 > /debug/pm_debug/sleep_while_idle
> 
> I've been following these lines as well, using the kernel from linux-pm-omap (tag: b1ce30edb70d1572d314b6a70de257150f5b20d1).
> I'm using an Overo Fire (OMAP3530 + OpenGL + Wifi/BT gumstix) on a Tobi board. The rootfs is straight from the org.openembedded.com build result.
> 
> The lines above do not seem to help. After suspend (echo mem > /sys/power/state), the Overo resumes when waking it up with a key press on the console. However, after resume, the console does not accept any input from the keyboard. I've also experimented with a parallel 'ssh' session via the Ethernet connection of the Tobi. After resume, this session is still responsive, albeit somewhat sluggish compared to the state before the suspend.
> 
> Has there been any development on this issue? I saw the reference to an "OMAP3: Serial: improved sleep" thread that mentions an update to the PM branch, but in the git log of the linux-omap-pm branch, I do not see a change related to it.
> 
> I am also interested in results concerning waking the Overo from suspend using a USB device connected to the USB Host port (not the USB OTG port).

I have the same problem using the experimental android 2.6.34 branch. The console send garbage to the serial device. I will try tomorrow to investigate a little bit more

Michael Trimarchi

> 
> Regards,
> 
> Robert Lukassen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

