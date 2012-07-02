From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Mon, 02 Jul 2012 15:52:34 +0530
Message-ID: <4FF1766A.5060605@ti.com>
References: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com> <alpine.DEB.2.00.1206271318070.27496@utopia.booyaka.com> <CAMQu2gztSV1qtgea9rL46orqTFR-vQkES5fen4GCqEfBh046-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:54742 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932938Ab2GBKWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 06:22:41 -0400
Received: by obcva7 with SMTP id va7so8061078obc.6
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 03:22:39 -0700 (PDT)
In-Reply-To: <CAMQu2gztSV1qtgea9rL46orqTFR-vQkES5fen4GCqEfBh046-Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@ti.com, govindraj.raja@ti.com, Felipe Balbi <balbi@ti.com>

On Thursday 28 June 2012 11:45 AM, Shilimkar, Santosh wrote:
> + Shubro, Felipe,
>
> On Thu, Jun 28, 2012 at 12:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> On Wed, 27 Jun 2012, Paul Walmsley wrote:
>>
>>> Looks like something broke between v3.5-rc3 and v3.5-rc4 with dynamic
>>> idle on 3530ES3 Beagle.  37xx EVM doesn't seem to be affected.
>>>
>>> Taking a closer look now.
>> Reverting commit 91930652a23de0873a157aa1d9962cb878d64451 ("OMAP2+: UART:
>> Add mechanism to probe uart pins and configure rx wakeup") makes wakeup
>> from dynamic retention idle work again.
>>
> I suspected this.
> This could be because, all the board are now expected to setup the pin
> configurations.
I do not have access to a 3530 Beagle

Just tried on 3630 beagle that seems to be fine.
let me see if I can reproduce in other onap3 boards that I have.

Hi Paul,

On my beaglexm 3630

This is with the following steps:
1. merge your 32k timer fix branch
2. disable USB host: set CONFIG_MFD_OMAP_USB_HOST=n

Let me know if I missed anything.

# echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
# echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
# echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
#
# mount -t debugfs debugfs /debug/
# cat /debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_clkdm->per_pwrdm (17)
# echo 1 > /debug/pm_debug/enable_off_mode
# echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
# echo mem > /sys/power/state
[   12.404083] PM: Syncing filesystems ... done.
[   12.426055] Freezing user space processes ... (elapsed 0.01 seconds)
done.
[   12.452728] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   12.483795] Suspending console(s) (use no_console_suspend to debug)
[   12.609039] PM: suspend of devices complete after 115.564 msecs
[   12.611511] PM: late suspend of devices complete after 2.471 msecs
[   12.615966] PM: noirq suspend of devices complete after 4.424 msecs
[   12.616027] Disabling non-boot CPUs ...
[   13.203704] Successfully put all powerdomains to target state
[   13.206115] PM: noirq resume of devices complete after 2.135 msecs
[   13.209228] PM: early resume of devices complete after 1.708 msecs
[   13.585815] PM: resume of devices complete after 376.464 msecs
[   13.637603] Restarting tasks ... done.
#
# cat /debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:1,RET:0,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_clkdm->per_pwrdm (17)
#





>
> Regards
> Santosh

