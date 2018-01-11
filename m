From: Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Thu, 11 Jan 2018 07:11:27 +0530
Message-ID: <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
 <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,


On 1/10/2018 6:18 PM, Roger Quadros wrote:
> Hi Manu,
>
> On 27/09/17 14:19, Manu Gautam wrote:
>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>> resume. While this works fine for gadget mode but in host
>> mode there is not re-initialization of host stack. Also, resetting
>> bus as part of bus_suspend/resume is not correct which could affect
>> (or disconnect) connected devices.
>> Fix this by not reinitializing core on suspend/resume in host mode
>> for HOST only and OTG/drd configurations.
>>
> All this seems correct but we (TI) were relying on dwc3_core_exit() to be called
> during dwc3_suspend() to have the lowest power state for our platforms.
>
> After this patch, DWC3 controller and PHYs won't be turned off thus
> preventing our platform from reaching low power levels.
>
> So this is a regression for us (TI) in v4.15-rc.
>
> Felipe, do you agree?
>
> If yes I can send a patch which fixes the regression
> and also makes USB host work after suspend/resume.
>

I think it will be better to separate runtime_suspend and pm_suspend handling for
host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across system
suspend-resume should be ok but doing that for runtime suspend-resume is not
correct.
Let me know if that sounds ok, I can provide a patch for same instead of
reverting this which affects runtime PM with dwc3 host.
Also, we need to consider dwc3 in Host mode with dr_mode as DRD/OTG similar to
dr_mode as HOST.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
