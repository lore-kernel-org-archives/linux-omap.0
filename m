From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Mon, 15 Jan 2018 17:40:10 +0200
Message-ID: <50a99a20-6c7f-de39-8173-18e5ce4881a1@ti.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
 <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
 <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Manu Gautam <mgautam@codeaurora.org>, Felipe Balbi <balbi@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Manu,

On 11/01/18 03:41, Manu Gautam wrote:
> Hi,
> 
> 
> On 1/10/2018 6:18 PM, Roger Quadros wrote:
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
>>
> 
> I think it will be better to separate runtime_suspend and pm_suspend handling for
> host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across system
> suspend-resume should be ok but doing that for runtime suspend-resume is not
> correct.
> Let me know if that sounds ok, I can provide a patch for same instead of
> reverting this which affects runtime PM with dwc3 host.
> Also, we need to consider dwc3 in Host mode with dr_mode as DRD/OTG similar to
> dr_mode as HOST.
> 
> 

Are you going to provide a patch for this any time soon?

FYI, suspend/resume is broken on DRA7x with Dual-role while in host mode.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
