From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [pm] keep Cortex M3 cores running while OMAP4 is suspended?
Date: Sun, 19 Jun 2011 11:29:24 +0530
Message-ID: <4DFD903C.4020402@ti.com>
References: <882569.33615.qm@web121412.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51794 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475Ab1FSF7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jun 2011 01:59:33 -0400
Received: by ywa6 with SMTP id 6so654500ywa.9
        for <linux-omap@vger.kernel.org>; Sat, 18 Jun 2011 22:59:32 -0700 (PDT)
In-Reply-To: <882569.33615.qm@web121412.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linxz02@ovi.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/19/2011 10:37 AM, linxz02@ovi.com wrote:
> Hi All,
>
> I was wondering whether it is possible to keep the Cortex M3 cores running while the OMAP processor is suspended.
>
> My testing environment was simple: I used Pandaboard (OMAP4430) and kernel 2.6.35. I wrote an M3 program to toggle one GPIO pin (which drives a LED). As long as the M3 program is running, the LED will blink.
>
> On the kernel side, I tried to change the suspend functions in arch/arm/mach-omap2/pm44xx.c. I set the states of core_pwrdm and l4per_pwrdm to ON, right before the system suspends. However, when the system was suspended (omap4_pm_suspend() was invoked), the LED stopped to blink. I think the M3 cores were powered off then.
>
> Did I miss anything? I'll really appreciate any input. Thanks!
>
Are you trying this on mainline. Mostly not.
And when you say OMAP suspend, whole SOC should go down to low power
state. If you keep M3 active then CORE PD can't go down and hence the
OMAP won't really suspend. Mostly MPUSS and some independent PD's only
will transition.

Your problem is the GPIO clocks are cut in late suspend code.
You can comment out the gpio_suspend code. Since you don't use
GPIO kernel driver, linux side has no idea that any one else
wants to use GPIO.

Hope this helps.

Regards
Santosh
