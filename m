From: "Robert Lukassen" <Robert.Lukassen@tomtom.com>
Subject: Gumstix Overo non-responsive TTY after resume
Date: Wed, 9 Jun 2010 16:28:08 +0200
Message-ID: <D6DB9C7EDECDA944B870F62B587008622C89C6@NL-EXC-06.intra.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mxvs2.esa.t-systems.com ([81.7.202.143]:17958 "EHLO
	mxvs2.esa.t-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab0FIOhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 10:37:53 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I've just started with the linux-omap-pm branch, and are experiencing problems with the keyboard when resuming from sleep. There seems to be an earlier post on this matter:

> > 4) Suspend to memory (echo mem > /sys/power/state) works now, but when I
> > wake up the board (via a keypress), I am no longer able to type anything
> > at the prompt. Any clue about this one?
> 
> Indeed, I was able to reproduce this as well and seems to be a new
> regression in the PM branch.  I see the same on omap3evm and n900 now
> too.mount 
> 
> If you enable the UART timeouts + sleep_while_idle, you should avoid
> this problem while I try and figure out what's going on:
> 
> echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
> echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
> echo 5 > /sys/devices/platform/serial8250.2/sleep_timeout
> echo 1 > /debug/pm_debug/sleep_while_idle

I've been following these lines as well, using the kernel from linux-pm-omap (tag: b1ce30edb70d1572d314b6a70de257150f5b20d1).
I'm using an Overo Fire (OMAP3530 + OpenGL + Wifi/BT gumstix) on a Tobi board. The rootfs is straight from the org.openembedded.com build result.

The lines above do not seem to help. After suspend (echo mem > /sys/power/state), the Overo resumes when waking it up with a key press on the console. However, after resume, the console does not accept any input from the keyboard. I've also experimented with a parallel 'ssh' session via the Ethernet connection of the Tobi. After resume, this session is still responsive, albeit somewhat sluggish compared to the state before the suspend.

Has there been any development on this issue? I saw the reference to an "OMAP3: Serial: improved sleep" thread that mentions an update to the PM branch, but in the git log of the linux-omap-pm branch, I do not see a change related to it.

I am also interested in results concerning waking the Overo from suspend using a USB device connected to the USB Host port (not the USB OTG port).

Regards,

Robert Lukassen
