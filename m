From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] usb: musb: dma: Add a DMA completion platform
 callback
Date: Mon, 23 Jan 2017 14:51:26 +0100
Message-ID: <465b73e5-28ee-a3a6-51d6-6bb4e1d16272@baylibre.com>
References: <20170119100659.11370-1-abailon@baylibre.com>
 <20170119100659.11370-2-abailon@baylibre.com>
 <20170120200030.GD14571@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170120200030.GD14571@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/20/2017 09:00 PM, Bin Liu wrote:
> On Thu, Jan 19, 2017 at 11:06:57AM +0100, Alexandre Bailon wrote:
>> Currently, the CPPI 4.1 driver is not completely generic and
>> only work on dsps. This is because of IRQ management.
>> Add a callback to dma_controller that could be invoked on DMA completion
>> to acknodlege the IRQ.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/usb/musb/musb_cppi41.c | 7 +++++--
>>  drivers/usb/musb/musb_dma.h    | 4 ++++
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
>> index 1636385..f7d3d27 100644
>> --- a/drivers/usb/musb/musb_cppi41.c
>> +++ b/drivers/usb/musb/musb_cppi41.c
>> @@ -217,6 +217,10 @@ static void cppi41_dma_callback(void *private_data)
>>  	int is_hs = 0;
>>  	bool empty;
>>  
>> +	controller = cppi41_channel->controller;
>> +	if (controller->controller.dma_callback)
>> +		controller->controller.dma_callback(&controller->controller);
>> +
>>  	spin_lock_irqsave(&musb->lock, flags);
>>  
>>  	dmaengine_tx_status(cppi41_channel->dc, cppi41_channel->cookie,
>> @@ -249,8 +253,6 @@ static void cppi41_dma_callback(void *private_data)
>>  	 * We spin on HS (no longer than than 25us and setup a timer on
>>  	 * FS to check for the bit and complete the transfer.
>>  	 */
>> -	controller = cppi41_channel->controller;
>> -
>>  	if (is_host_active(musb)) {
>>  		if (musb->port1_status & USB_PORT_STAT_HIGH_SPEED)
>>  			is_hs = 1;
>> @@ -695,6 +697,7 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
>>  	controller->controller.channel_program = cppi41_dma_channel_program;
>>  	controller->controller.channel_abort = cppi41_dma_channel_abort;
>>  	controller->controller.is_compatible = cppi41_is_compatible;
>> +	controller->controller.musb = musb;
>>  
>>  	ret = cppi41_dma_controller_start(controller);
>>  	if (ret)
>> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
>> index 46357e1..8bea0cd 100644
>> --- a/drivers/usb/musb/musb_dma.h
>> +++ b/drivers/usb/musb/musb_dma.h
>> @@ -181,10 +181,13 @@ dma_channel_status(struct dma_channel *c)
>>   * @channel_release: call this to release a DMA channel
>>   * @channel_abort: call this to abort a pending DMA transaction,
>>   *	returning it to FREE (but allocated) state
>> + * @platform_dma_callback: invoked on DMA completion, useful to run platform
>> + *	code such IRQ acknowledgment.
>>   *
>>   * Controllers manage dma channels.
>>   */
>>  struct dma_controller {
>> +	struct musb *musb;
> 
> Since musb is added here, can we clean up the corresponding one in
> struct cppi41_dma_controller and struct cppi?
Yes, and also for the one in tusb_omap_dma.
> 
> Regards,
> -Bin.
> 
Regards,
Alexandre
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
