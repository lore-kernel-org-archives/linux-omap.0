From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: musb_cppi41: Fix the address of teardown
 and autoreq registers
Date: Tue, 12 Sep 2017 08:49:48 +0200
Message-ID: <81bb645e-9324-d9e4-de78-23139e9dea50@baylibre.com>
References: <20170813120423.16371-1-abailon@baylibre.com>
 <20170813120423.16371-2-abailon@baylibre.com>
 <6e5b0e12-d298-b698-bc06-d9c3ae8fb5c3@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6e5b0e12-d298-b698-bc06-d9c3ae8fb5c3-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/15/2017 12:12 PM, Sergei Shtylyov wrote:
> Hello!
>
> On 8/13/2017 3:04 PM, Alexandre Bailon wrote:
>
>> The DA8xx and DSPS platforms don't use the same address for few
>> registers.
>> On Da8xx, this is causing some issues (e.g. teardown that doesn't work).
>> Configure the address of the register during the init and use them
>> instead
>> of constants.
>>
>> Reported-by: nsekhar-l0cyMroinI0@public.gmane.org
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>   drivers/usb/musb/musb_cppi41.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_cppi41.c
>> b/drivers/usb/musb/musb_cppi41.c
>> index ba255280a624..dbff0e0a4ff5 100644
>> --- a/drivers/usb/musb/musb_cppi41.c
>> +++ b/drivers/usb/musb/musb_cppi41.c
>> @@ -26,6 +26,9 @@
>>     #define MUSB_DMA_NUM_CHANNELS 15
>>   +#define DA8XX_USB_AUTOREQ_REG    0x14
>> +#define DA8XX_USB_TEARDOWN_REG    0x1c
>
>    Why these _REG suffixes suddenly?
I took these defines in da8xx.c.
Actually, I think I should make a third patch to remove them from
da8xx.c because they are not even used.
>
> [...]
>
>    Other than that looks sane. Need my ACK?
I don't know if that is needed but I guess it would be appreciated.

Best Regards,
Alexandre
>
> WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
