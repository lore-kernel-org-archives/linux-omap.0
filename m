From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: musb_cppi41: Fix the address of teardown
 and autoreq registers
Date: Mon, 14 Aug 2017 19:06:22 +0530
Message-ID: <abce1d79-bc75-2018-2112-d701a8ca69d5@ti.com>
References: <20170813120423.16371-1-abailon@baylibre.com>
 <20170813120423.16371-2-abailon@baylibre.com>
 <7ee74cb1-19aa-5323-5325-ef9cc3410762@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7ee74cb1-19aa-5323-5325-ef9cc3410762-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 14 August 2017 07:01 PM, Sekhar Nori wrote:
> Hi,
> 
> On Sunday 13 August 2017 05:34 PM, Alexandre Bailon wrote:
>> The DA8xx and DSPS platforms don't use the same address for few registers.
>> On Da8xx, this is causing some issues (e.g. teardown that doesn't work).
>> Configure the address of the register during the init and use them instead
>> of constants.
>>
>> Reported-by: nsekhar-l0cyMroinI0@public.gmane.org

Reported-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/usb/musb/musb_cppi41.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
>> index ba255280a624..dbff0e0a4ff5 100644
>> --- a/drivers/usb/musb/musb_cppi41.c
>> +++ b/drivers/usb/musb/musb_cppi41.c
>> @@ -26,6 +26,9 @@
>>  
>>  #define MUSB_DMA_NUM_CHANNELS 15
>>  
>> +#define DA8XX_USB_AUTOREQ_REG	0x14
>> +#define DA8XX_USB_TEARDOWN_REG	0x1c
> 
> Nice catch. I noticed that the USB_CTRL_TX_MODE and USB_CTRL_RX_MODE are
> incorrect for DA8xx too. Perhaps those should be fixed too.

Ah, just read 2/2 now, and seems like thats exactly what you are
handling there.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
