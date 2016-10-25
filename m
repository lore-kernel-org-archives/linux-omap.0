From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Tue, 25 Oct 2016 12:07:51 +0530
Message-ID: <7024bec3-2ebe-db82-12e2-6d6bcc664c6b@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DB09B26E-C5AB-427A-82D5-6FE857E7C218-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Syne <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Tuesday 25 October 2016 11:46 AM, John Syne wrote:
> 
>> On Oct 24, 2016, at 11:01 PM, John Syne <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>>
>>> On Oct 24, 2016, at 10:52 PM, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> wrote:
>>>
[...]
>>>>>>
>>>>>> ---
>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>> index b9a53e0..96c4207 100644
>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>> @@ -90,7 +90,7 @@
>>>>>> /* Delay register */
>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>>>> Wouldn’t this be better to add this to the devicetree?
>>>>
>>>> 	ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
>>>> 	ti,chan-step-opendelay = <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
>>>> 	ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
>>>
>>> For a touch screen, there is not need to change in these parameter
>>> settings, so my opinion is to keep it as is. Or am I missing something?
>> I was thinking that if you are using this driver as an ADC, you may want the flexibility to make these changes in the DT. I’m doing this by connecting sensors to the ADC inputs. I’m not using this driver for a touchscreen.
> 

ti_am335x_adc driver already supports above DT parameters and its upto
the user to adjust these parameters as required.

> Here is a DT overlay were this gets using on the BeagleBoneBlack.  
> 
> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-ADC-00A0.dts
> 
> Besides, these DT features are already implemented in the driver so it is just a matter of adding these entries to the am33xx.dtsi & am4372.dtsi, which you modified in this patch series.
> 

Touchscreen driver (ti_am335x_tsc.c) does not support above DT parameters.

-- 
Regards
Vignesh
