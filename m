From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Thu, 11 Jan 2018 11:15:07 +0200
Message-ID: <4dea746b-3b7a-7a0e-7136-cb771044e627@ti.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
 <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
 <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
 <87r2qwyfp9.fsf@linux.intel.com>
 <a30be8a0-63ee-da02-f7a2-4958b7ee35bf@codeaurora.org>
 <87d12gydev.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <87d12gydev.fsf@linux.intel.com>
Content-Language: en-GB
Sender: linux-arm-msm-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Manu Gautam <mgautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Felipe,

On 11/01/18 11:04, Felipe Balbi wrote:
> 
> Hi,
> 
> Manu Gautam <mgautam@codeaurora.org> writes:
>>>>> On 27/09/17 14:19, Manu Gautam wrote:
>>>>>> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
>>>>>> resume. While this works fine for gadget mode but in host
>>>>>> mode there is not re-initialization of host stack. Also, resetting
>>>>>> bus as part of bus_suspend/resume is not correct which could affect
>>>>>> (or disconnect) connected devices.
>>>>>> Fix this by not reinitializing core on suspend/resume in host mode
>>>>>> for HOST only and OTG/drd configurations.
>>>>>>
>>>>> All this seems correct but we (TI) were relying on dwc3_core_exit() to be called
>>>>> during dwc3_suspend() to have the lowest power state for our platforms.
>>>>>
>>>>> After this patch, DWC3 controller and PHYs won't be turned off thus
>>>>> preventing our platform from reaching low power levels.
>>>>>
>>>>> So this is a regression for us (TI) in v4.15-rc.
>>>>>
>>>>> Felipe, do you agree?
>>>>>
>>>>> If yes I can send a patch which fixes the regression
>>>>> and also makes USB host work after suspend/resume.
>>>>>
>>>> I think it will be better to separate runtime_suspend and pm_suspend handling for
>>>> host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across system
>>>> suspend-resume should be ok but doing that for runtime suspend-resume is not
>>>> correct.
>>> it sure is. It's part of hibernation-while-disconnected programming sequence
>>>
>>>> Let me know if that sounds ok, I can provide a patch for same instead of
>>>> reverting this which affects runtime PM with dwc3 host.
>>> nope, that would break platforms using hibernation
>>
>> Please don't mind me asking this if it is very basic, I am probably
>> missing something there
>>
>> We should be able to distinguish between runtime_pm vs
>> system_suspend/hibernation and then process accordingly.
> 
> I'm not talking about Linux suspend to disk; I'm talking about Synopsys'
> Hibernation feature (open up your databook and have a read ;-)
> 
>> In host mode runtime suspend/resume could happen very often with
>> device connected, and resetting h/w on every runtime_resume might not
>> be desired. And PHYs drivers can also support runtime_suspend which
>> would be preferred instead of shutting down phy.
> 
> We don't do anything when dwc3 is working as a host, we simply assume if
> we reach dwc3.ko, xhci has done its part. Here's what our
> suspend_common looks like:
> 
> static int dwc3_suspend_common(struct dwc3 *dwc)
> {
> 	unsigned long	flags;
> 
> 	switch (dwc->current_dr_role) {
> 	case DWC3_GCTL_PRTCAP_DEVICE:
> 		spin_lock_irqsave(&dwc->lock, flags);
> 		dwc3_gadget_suspend(dwc);
> 		spin_unlock_irqrestore(&dwc->lock, flags);
> 		dwc3_core_exit(dwc);
> 		break;
> 	case DWC3_GCTL_PRTCAP_HOST:
> 	default:
> 		/* do nothing */
> 		break;
> 	}
> 
> 	return 0;
> }
> 
> We're not resetting anything, not tearing down anything. No idea why
> you're saying that in host mode we're breaking things apart. If you have
> out-of-tree patches on top of v4.15-rc7, fix them instead of claiming
> mainline is at fault.
> 

This is the case after commit 689bf72c6e0d	("usb: dwc3: Don't reinitialize core during host bus-suspend/resume")
which is breaking low power for TI platforms in Host mode.

If we revert that commit we will be doing dwc3_core_exit() for host mode as well. Which is what we want for system suspend
but probably not for runtime suspend in host case.

This is why Manu wants to differentiate runtime vs system suspend.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
