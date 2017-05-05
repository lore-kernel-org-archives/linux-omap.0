From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/4] usb: musb: tusb6010_omap: Convert to DMAengine
Date: Fri, 5 May 2017 10:28:17 +0300
Message-ID: <0286755f-edc5-36a8-e268-aceed30de647@ti.com>
References: <20170503105645.26759-1-peter.ujfalusi@ti.com>
 <20170504143145.GO3780@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170504143145.GO3780@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org



On 2017-05-04 17:31, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170503 04:00]:
>> Hi,
>>
>> With port_window support implemented in DMAengine and the sDMA DMAengine driver,
>> the tusb6010_omap driver can be converted away from the custom legacy omap-dma
>> API to generic DMAengine.
>>
>> The first two patch is to prepare the tusb6010_omap driver for the conversion.
>> The third one adds the needed entries for the dma_slave_map so we can request
>> the DMA channels. This can be reverted when the stack is converted to DT.
>>
>> The last patch does the main work to move the driver to DMAengine API.
>>
>> I have tested the set on top of next-20170503 on Nokia n810 with nfsroot using
>> CDC Ethernet (g_cdc) and copying files with scp to/form my host.
>
> Thanks for doing this! For this series:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>
>> To force that the DMA is actually used I have:
>> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
>> index 05aefcad40b5..a5fc2a6bdad3 100644
>> --- a/drivers/usb/musb/tusb6010_omap.c
>> +++ b/drivers/usb/musb/tusb6010_omap.c
>> @@ -216,8 +216,8 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>>  	 * use a timer for the callback, but it is unsafe as the XFR_SIZE
>>  	 * register is corrupt, and we won't know if the DMA worked.
>>  	 */
>> -	if (dma_addr & 0x2)
>> -		return false;
>> +// 	if (dma_addr & 0x2)
>> +// 		return false;
>>
>>  	/*
>>  	 * Because of HW issue #10, it seems like mixing sync DMA and async
>>
>> Since this condition will almost all the time was true - effectively disabling
>> the DMA use.
>
> Yeah this really should have the transfers aligned to 32-bit like
> the production kernel did. For reference, the following should do
> the trick but of course would have to be done conditionally.
>
> Regards,
>
> Tony
>
> 8< ----------------------
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -2153,6 +2153,7 @@ __acquires(musb->lock)
>  	musb->g.a_alt_hnp_support = 0;
>  	musb->g.a_hnp_support = 0;
>  	musb->g.quirk_zlp_not_supp = 1;
> +	musb->g.quirk_avoids_skb_reserve = 1;

note for myself: this only works with g_ncm. I was using g_cdc, switched 
to g_ether, then to g_ncm.
However... If I revert this series and add this line, the ethernet will 
not work at all, I can not ping the n810 and it will not get the nfsroot 
either (next-20170503).

only f_ncm.c does:
	ncm->port.no_skb_reserve =
		gadget_avoids_skb_reserve(cdev->gadget);

>  	/* Normal reset, as B-Device;
>  	 * or else after HNP, as A-Device
>

- Péter
