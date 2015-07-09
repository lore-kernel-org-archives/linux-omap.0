From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RESEND 1/7] tty: serial: 8250: omap: fix kernel crash
 in suspend-to-ram
Date: Thu, 9 Jul 2015 16:45:14 +0530
Message-ID: <559E57C2.5080009@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com> <d8cb86b2717e0fc084b6651be54ee6d96dbc603a.1436174801.git.nsekhar@ti.com> <559D2DFC.9010602@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559D2DFC.9010602-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Wednesday 08 July 2015 07:34 PM, Peter Hurley wrote:
> Hi Sekhar,
> 
> On 07/06/2015 05:47 AM, Sekhar Nori wrote:
>> omap_device infrastructure has a suspend_noirq hook which
>> runtime suspends all devices late in the suspend cycle (see
>> _od_suspend_noirq() in arch/arm/mach-omap2/omap_device.c)
> 
> Why is omap2 the only arch/SoC that does this; ie., call the runtime
> callbacks after the system pm callbacks?

Even I am not sure why this needs to be done. I _think_ it was done to
make sure all IPs are idled even if driver did not implement system
sleep ops, but I could be wrong.

Cc: Kevin Hilman since he added this support.

In any case, I think this patch is okay, as the additional NULL pointer
check is still valid.

Thanks,
Sekhar

> 
> Whatever positive it brings, it's a mess at the driver level.
> For example, this driver has to hook prepare()/complete() so it can
> set local state so that it can detect when the runtime suspend
> is being called during system suspend.
> 
> Regards,
> Peter Hurley
> 
> 
>> This leads to a NULL pointer exception in 8250_omap driver
>> since by the time omap8250_runtime_suspend() is called, 8250_dma
>> driver has already set rxchan to NULL via serial8250_release_dma().
>>
>> Make an explicit check to see if rxchan is NULL in
>> runtime_{suspend|resume} hooks to fix this.
>>
>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> ---
>> Previous version: http://www.spinics.net/lists/linux-omap/msg119459.html
>> No change in this version except rebased to v4.2-rc1
>>
>>  drivers/tty/serial/8250/8250_omap.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index d75a66c72750..20c5b9c4c288 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -1285,7 +1285,7 @@ static int omap8250_runtime_suspend(struct device *dev)
>>  			return -EBUSY;
>>  	}
>>  
>> -	if (up->dma)
>> +	if (up->dma && up->dma->rxchan)
>>  		omap_8250_rx_dma(up, UART_IIR_RX_TIMEOUT);
>>  
>>  	priv->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
>> @@ -1310,7 +1310,7 @@ static int omap8250_runtime_resume(struct device *dev)
>>  	if (loss_cntx)
>>  		omap8250_restore_regs(up);
>>  
>> -	if (up->dma)
>> +	if (up->dma && up->dma->rxchan)
>>  		omap_8250_rx_dma(up, 0);
>>  
>>  	priv->latency = priv->calc_latency;
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
