From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 07/10] usb: dwc3: gadget: Fix suspend/resume during
 dual-role mode
Date: Tue, 12 Apr 2016 11:25:46 +0300
Message-ID: <570CB10A.2020903@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
 <1460374506-9779-8-git-send-email-rogerq@ti.com> <878u0knxkp.fsf@intel.com>
 <570BA2AA.8030308@ti.com> <87oa9gmg2k.fsf@intel.com>
 <570BAC4D.8010209@ti.com> <87shyrl0iw.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87shyrl0iw.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/04/16 11:00, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> On 11/04/16 16:26, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq@ti.com> writes:
>>>> On 11/04/16 15:23, Felipe Balbi wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>> Gadget controller might not be always active during suspend/
>>>>>> resume when we are operating in dual-role/otg mode.
>>>>>> Check if we're active and only if we are then perform
>>>>>> necessary actions during suspend/resume.
>>>>>
>>>>> I don't get this. If we're operating in OTG, we should have a gadget
>>>>> driver loaded, no ?
>>>>>
>>>> At boot gadget driver is not automatically loaded. We're still in OTG mode
>>>> but OTG state machine hasn't started.
>>>> System suspend/resume can still happen.
>>>>
>>>> User might also load/unload the gadget driver prior to system suspend.
>>>
>>> good point, this should go in the -rc too.
>>>
>> But there is no dual-role mode currently so it won't fix any bug yet :).
> 
> this should be a problem even for device-only, right ?
> 
> i) boot-up
> ii) modprobe dwc3
> iii) echo mem > /sys/power/state
> 
Indeed. It is applicable for device-only mode as well. I'll send this patch for rc then.

cheers,
-roger
