From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Wed, 10 Jan 2018 14:59:35 +0200
Message-ID: <ff5636f1-eaac-b604-e35e-f56f5a15ab9c@ti.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
 <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
 <876089zxau.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <876089zxau.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-GB
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/01/18 14:57, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> Hi Manu,
>>
>> On 27/09/17 14:19, Manu Gautam wrote:
>>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>>> resume. While this works fine for gadget mode but in host
>>> mode there is not re-initialization of host stack. Also, resetting
>>> bus as part of bus_suspend/resume is not correct which could affect
>>> (or disconnect) connected devices.
>>> Fix this by not reinitializing core on suspend/resume in host mode
>>> for HOST only and OTG/drd configurations.
>>>
>>
>> All this seems correct but we (TI) were relying on dwc3_core_exit() to be called
>> during dwc3_suspend() to have the lowest power state for our platforms.
>>
>> After this patch, DWC3 controller and PHYs won't be turned off thus
>> preventing our platform from reaching low power levels.
>>
>> So this is a regression for us (TI) in v4.15-rc.
>>
>> Felipe, do you agree?
>>
>> If yes I can send a patch which fixes the regression
>> and also makes USB host work after suspend/resume.
> 
> A power consumption regression is still a regression. But it's super
> late in the -rc cycle, I think we need to get this merged after 4.16-rc1
> and make sure to Cc stable.
> 
> Should be more than enough time to review and test patches.
> 

Fine with me. 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
