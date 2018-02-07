From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Wed, 7 Feb 2018 11:21:45 +0200
Message-ID: <753727a9-e155-d24a-9732-1fee10b21dc7@ti.com>
References: <20180204000335.29812776@kemnade.info>
 <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
 <20180204093831.44322452@kemnade.info>
 <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
 <20180206074201.479405e7@aktux> <20180206160452.GA21573@atomide.com>
 <20180206175509.4d80e930@aktux> <20180206171737.GB21573@atomide.com>
 <20180206185452.34d01d77@aktux> <20180206181623.GC21573@atomide.com>
 <20180206194020.349468da@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206194020.349468da@aktux>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 06/02/18 20:40, Andreas Kemnade wrote:
> On Tue, 6 Feb 2018 10:16:23 -0800
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
>> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 18:04]:
>>> On Tue, 6 Feb 2018 09:17:37 -0800
>>> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:  
>>>> uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
>>>> for uart in $uarts; do
>>>> 	echo enabled > $uart/wakeup 2>&1
>>>> 	echo auto > $uart/control 2>&1
>>>> done
>>>>   
>>>
>>> hmm, this looks a bit like runtime suspend.  
>>
>> Not only that, it enables wakeup for UART also for suspend :)
>>
> We are using the rtc for wakeup and measure discharge of battery
> for a time frame of about 300 seconds.
> 
>> That is if your dts has it configured with interrupts-extended
>> for the console UART like omap3-beagle-xm.dts has for example.
>> Seems like the gta04 dts don't have these.. And you also want
>> to have chosen with stdout-path = &uart3 or whatever the debug
>> UART is for earlycon to work.
>>
>>> I mean suspend aka echo mem >/sys/power/state
>>>   
>>>> echo -n 1 > /sys/kernel/debug/pm_debug/enable_off_mode  
>>
>> And the above will enable SoC and PMIC off modes, which will also
>> take the suspend power to some much much lower value :) You need
>> to configure the PMIC too depending if the oscillator can be turned
>> off, in that case set "ti,twl4030-power-idle-osc-off". That too
>> seems to be missing in gta04 dts files..
>>
> It was in our tree. It can be enabled for the gta04a5. We have even done
> that. But then suspend while charging breaks. I have no idea how to do a
> proper if-not-charging-power-idle-osc-off patch... 
> 
> Yes there are other places where we can optimize suspend current. But
> lets first find out why ehci-omap seems to cause trouble here.
> So we are looking for around 15mA of additional suspend current when the
> module is loaded. 
> Shouldn't the reset line of the phy (usb-nop-xceiv) be set to low when
> going to suspend? I do not see code how to do it. I guess that is the
> reason.
> 
> BTW:
> root@letux:~# cat /sys/bus/platform/devices/48064800.ehci/power/runtime_status 
> active


PM handling is not yet there in the ehci-omap driver.

> static struct platform_driver ehci_hcd_omap_driver = {
>         .probe                  = ehci_hcd_omap_probe,
>         .remove                 = ehci_hcd_omap_remove,
>         .shutdown               = usb_hcd_platform_shutdown,
>         /*.suspend              = ehci_hcd_omap_suspend, */
>         /*.resume               = ehci_hcd_omap_resume, */
>         .driver = {
>                 .name           = hcd_name,
>                 .of_match_table = omap_ehci_dt_ids,
>         }
> };

There is also some co-relation with the parent driver
drivers/mfd/omap-usb-host.c

Getting low power on system suspend should be easy as we most probably don't
need wakeup to work in this case. This should fix the increased power during
system suspend.

To fix active power consumption we need to implement runtime PM.
However, for runtime suspend case we do need remote-wakeup to work else we
won't be able to detect any new USB devices after the host runtime suspends.
For this we need to remux one of the PHY lines into a GPIO to capture the wake event.
This is where the generic wakeirq support comes in.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
