From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP TWL4030/TPS65950 power off
Date: Fri, 30 Mar 2012 22:20:07 +0300
Message-ID: <4F760767.9080000@compulab.co.il>
References: <CANLagX8oMGLkkKuvDw4g30CE+n9bbvO=ouEDk0Vf=xOM5Q2eDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:39741
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756782Ab2C3TUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 15:20:21 -0400
In-Reply-To: <CANLagX8oMGLkkKuvDw4g30CE+n9bbvO=ouEDk0Vf=xOM5Q2eDA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Ashwin,

On 03/30/12 21:04, Ashwin Bihari wrote:
> Greetings,
> 
> In one of the older Kernels, there was a twl4030-poweroff driver that
> provided a hook to shutdown the OMAP when the "poweroff" or "shutdown
> -h now" command was issued in Linux. This also put the
> TWL4030/TPS65950 into it's power on state awaiting a press of the
> power button. My most recent experience with this functionality
> working is with a 2.6.32 Kernel.

Probably, not the mainline kernel...

> 
> I'm trying to get this functionality going with a 3.1.10 Kernel. I've
> brought over the same twl4030-poweroff driver, but now the system just
> crashes during shutdown as opposed to nice going down.

The power off functionality of the TWL4030 is split in two phases:
1) capturing the interrupt and propagating it through the input event handler
   to the userspace (drivers/input/misc/twl4030-pwrbutton.c) - this is already
   available in v3.1.10 stable kernel.
2) overriding the pm_power_off method with TWL4030 specific implementation
   (drivers/mfd/twl4030-power.c) available since:
# git describe 26cc3ab984cd00e95cb58ba5aaea4238ea56c700
v3.2-36-g26cc3ab

To get that working, you need:
1) the CONFIG_INPUT_TWL4030_PWRBUTTON enabled in the kernel config
2) git cherry-pick 26cc3ab984cd00e95cb58ba5aaea4238ea56c700
3) add struct twl4030_power_data to your board file and set use_poweroff field,
   here is an example: http://www.spinics.net/lists/linux-omap/msg67280.html

> 
> The file 'drivers/mfd/twl4030-power.c' does define the
> PWR_P1_SW_EVENTS and PWR_DEVOFF bit, but the PWR_DEVOFF bit is never
> used to turn the system off, why is it even defined and what is the
> right way of turning of the system now?

If you experience problems with the above proposed solution,
please, post console logs and may be also some debug output.
Also, why can't you try it on 3.3 kernel?

-- 
Regards,
Igor.
