From: Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Tue, 16 Jan 2018 12:06:28 +0530
Message-ID: <05b7a9d6-0b52-5650-1812-359e0b6c5ea4@codeaurora.org>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
 <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
 <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org>
 <50a99a20-6c7f-de39-8173-18e5ce4881a1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50a99a20-6c7f-de39-8173-18e5ce4881a1@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,


On 1/15/2018 9:10 PM, Roger Quadros wrote:
> Hi Manu,
[snip]
>> I think it will be better to separate runtime_suspend and pm_suspend handling for
>> host mode in dwc3. Powering offf/on PHYs and dwc3_core_exit/init across system
>> suspend-resume should be ok but doing that for runtime suspend-resume is not
>> correct.
>> Let me know if that sounds ok, I can provide a patch for same instead of
>> reverting this which affects runtime PM with dwc3 host.
>> Also, we need to consider dwc3 in Host mode with dr_mode as DRD/OTG similar to
>> dr_mode as HOST.
>>
>>
> Are you going to provide a patch for this any time soon?
>
> FYI, suspend/resume is broken on DRA7x with Dual-role while in host mode.
>

Posted following patch: https://patchwork.kernel.org/patch/10166077/
Let me know if this works for you.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
