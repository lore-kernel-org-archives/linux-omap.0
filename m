From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Wed, 18 Jan 2017 12:04:32 -0600
Message-ID: <f33ba3b1-a35d-8d63-35ec-db1e0ca96c54@ti.com>
References: <20170117175524.3484-1-tony@atomide.com>
 <20170118142501.GA10928@uda0271908> <20170118165308.GC7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170118165308.GC7403-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 01/18/2017 10:53 AM, Tony Lindgren wrote:
> Hi,
> 
> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 06:26]:
>> With this v3, I still get -71 error when a device is plugged to a hub to
>> musb. It doesn't happen though if the device is already plugged to the hub
>> before attaching the hub to musb.
>>
>> [  177.579300] usb 1-1: reset high-speed USB device number 2 using musb-hdrc
>> [  177.719308] usb 1-1: device descriptor read/64, error -71
>> [  178.350297] usb 1-1.1: new high-speed USB device number 4 using musb-hdrc
> 
> I think the -71 issue is a different regression. I've verified that v4.8.y
> does not have this, but v4.9.y does have it.
> 
> So far the easiest way for me to reproduce the -71 problem is by plugging
> a USB drive into a connected hub. If I connect the hub with USB drive already
> plugged into the hub, it does not happen.
> 
> With the hub connected musb is already active when the USB drive is plugged

This is not exactly try, i think, because cppi can be in inactive state
because of autosuspend (all calls are paired).

> in. So I'm now suspecting this -71 regression is not related to runtime PM
> changes. Bisect and boot and plug devices time I think unless you have
> better ideas?
> 
>> And I still get -115 error flooding with thumb drive.
>>
>> [  236.880068] cppi41-dma-engine 47400000.dma-controller: cppi41_irq pm runtime get: -115
>>
>> I tested with TI AM335x GP EVM. The problems happen on both musb ports.
> 
> OK. So it's pointless to try to play with the autosuspend timeout.
> 
> Let's just do a WARN(!pm_runtime_active(cdd->ddev.dev->parent)) there
> until we have musb_cppi41.c dma calls properly paired and don't have
> dma requests lingering.
> 
> Care to try the updated patch below? It won't help with the -71 issue
> but the $subject issue should be fixed. And you should not see the
> WARN() trigger with your tests presumably.
> 

Sry, but wouldn't be more simple and safe just to drop PM runtime from this driver,
as it is part of musb and musb PM state expected to be handled properly by PM runtime now.

More over, There is another possibility related to the current PM runtime implementation and autosuspend
- it might introduce delay between time when musb request desc push and time when cppi will actually
put this desc in HW queue if cppi was not active.
For example, there might not be -71 error seen if CPPI autosuspend is disabled
(cppi is active all the time) before plug-in hub and then USB drive.


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
