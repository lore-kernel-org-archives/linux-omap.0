From: Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Thu, 11 Jan 2018 14:25:24 +0530
Message-ID: <a30be8a0-63ee-da02-f7a2-4958b7ee35bf@codeaurora.org>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
 <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
 <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
 <87r2qwyfp9.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <87r2qwyfp9.fsf@linux.intel.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Roger Quadros <rogerq@ti.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,


On 1/11/2018 1:44 PM, Felipe Balbi wrote:
> Hi,
>
> Manu Gautam <mgautam@codeaurora.org> writes:
>>> On 27/09/17 14:19, Manu Gautam wrote:
>>>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>>>> resume. While this works fine for gadget mode but in host
>>>> mode there is not re-initialization of host stack. Also, resetting
>>>> bus as part of bus_suspend/resume is not correct which could affect
>>>> (or disconnect) connected devices.
>>>> Fix this by not reinitializing core on suspend/resume in host mode
>>>> for HOST only and OTG/drd configurations.
>>>>
>>> All this seems correct but we (TI) were relying on dwc3_core_exit() to be called
>>> during dwc3_suspend() to have the lowest power state for our platforms.
>>>
>>> After this patch, DWC3 controller and PHYs won't be turned off thus
>>> preventing our platform from reaching low power levels.
>>>
>>> So this is a regression for us (TI) in v4.15-rc.
>>>
>>> Felipe, do you agree?
>>>
>>> If yes I can send a patch which fixes the regression
>>> and also makes USB host work after suspend/resume.
>>>
>> I think it will be better to separate runtime_suspend and pm_suspend handling for
>> host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across system
>> suspend-resume should be ok but doing that for runtime suspend-resume is not
>> correct.
> it sure is. It's part of hibernation-while-disconnected programming sequence
>
>> Let me know if that sounds ok, I can provide a patch for same instead of
>> reverting this which affects runtime PM with dwc3 host.
> nope, that would break platforms using hibernation

Please don't mind me asking this if it is very basic, I am probably missing something there
We should be able to distinguish between runtime_pm vs system_suspend/hibernation
and then process accordingly.
In host mode runtime suspend/resume could happen very often with device connected,
and resetting h/w on every runtime_resume might not be desired. And PHYs drivers
can also support runtime_suspend which would be preferred instead of shutting down
phy.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
