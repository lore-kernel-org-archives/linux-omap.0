From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v7 2/3] usb: musb: Add support of CPPI 4.1 DMA controller
 to DA8xx
Date: Wed, 5 Apr 2017 10:07:55 +0200
Message-ID: <5f201199-2d5e-0474-fc0d-2d8e289849e3@baylibre.com>
References: <20170329162432.27299-1-abailon@baylibre.com>
 <20170329162432.27299-3-abailon@baylibre.com>
 <20170403145916.GA12799@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170403145916.GA12799@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/03/2017 04:59 PM, Bin Liu wrote:
> On Wed, Mar 29, 2017 at 06:24:31PM +0200, Alexandre Bailon wrote:
>> Currently, only the PIO mode is supported.
>> This add support of CPPI 4.1 to DA8xx.
>> As the In DA8xx the CPPI 4.1 DMA is a part of the USB.
>> Create the CPPI 4.1 device as a child of USB.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>   drivers/usb/musb/Kconfig |  4 ++--
>>   drivers/usb/musb/da8xx.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>> index 72a2a50..5506a9c 100644
>> --- a/drivers/usb/musb/Kconfig
>> +++ b/drivers/usb/musb/Kconfig
>> @@ -160,8 +160,8 @@ config USB_TI_CPPI_DMA
>>   	  Enable DMA transfers when TI CPPI DMA is available.
>>   
>>   config USB_TI_CPPI41_DMA
>> -	bool 'TI CPPI 4.1 (AM335x)'
>> -	depends on ARCH_OMAP && DMADEVICES
>> +	bool 'TI CPPI 4.1'
>> +	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX) && DMADEVICES
>>   	select TI_CPPI41
> TI_CPPI41 also should depend on ARCH_DAVINCI_DA8XX due to this patch.  You
> might need the following change for dma Kconfig as well.
This change has been done in the series "dmaengine: cppi41: Add dma 
support to da8xx".
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index d01d59812cf3..15e31bfae9f9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -514,8 +514,8 @@ config TIMB_DMA
>            Enable support for the Timberdale FPGA DMA engine.
>   
>   config TI_CPPI41
> -       tristate "AM33xx CPPI41 DMA support"
> -       depends on ARCH_OMAP
> +       tristate "CPPI41 DMA support"
> +       depends on ARCH_OMAP || ARCH_DAVINCI_DA8XX
>          select DMA_ENGINE
>          help
>            The Communications Port Programming Interface (CPPI) 4.1 DMA engine
>
> Regards,
> -Bin.
Regards,
Alexandre
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
