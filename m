From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Fri, 5 Feb 2016 09:49:55 +0530
Message-ID: <56B422EB.5000603@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com> <56A90971.4020409@ti.com>
 <20160127185649.GV19432@atomide.com> <56A94FB7.6020903@ti.com>
 <20160128183156.GH19432@atomide.com> <56B087AD.4000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56B087AD.4000505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Tuesday 02 February 2016 04:10 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 29 January 2016 12:01 AM, Tony Lindgren wrote:
>> * Suman Anna <s-anna@ti.com> [160127 15:17]:
>>> On 01/27/2016 12:56 PM, Tony Lindgren wrote:
>>>> * Suman Anna <s-anna@ti.com> [160127 10:17]:
>>>>> On 01/27/2016 11:31 AM, Tony Lindgren wrote:
>>>>>> Why do you need another reset here? Can't you just implement PM runtime
>>>>>> in the driver and do the usual pm_runtime_put_sync followed by
>>>>>> pm_runtime_disable?
>>>>>
>>>>> The omap_hwmod_enable/disable code does not deal with hardresets (PRCM
>>>>> reset lines) and so the pm_runtime_get_sync/put_sync only end up dealing
>>>>> with clocks, and we need to invoke the reset functions separately.
>>>>> Modules with softresets in SYSCONFIG are ok, as they are dealt with
>>>>> properly.
>>>>
>>>> Hmm _reset() in omap_hwmod.c has this to call _assert_hardreset:
>>>>
>>>> 	if (oh->class->reset) {
>>>> 		r = oh->class->reset(oh);
>>>> 	} else {
>>>> 		if (oh->rst_lines_cnt > 0) {
>>>> 			for (i = 0; i < oh->rst_lines_cnt; i++)
>>>> 				_assert_hardreset(oh, oh->rst_lines[i].name);
>>>> 			return 0;
>>>> 		} else {
>>>> 			r = _ocp_softreset(oh);
>>>> 			if (r == -ENOENT)
>>>> 				r = 0;
>>>> 		}
>>>> 	}
>>>
>>> Right, hwmod code does the initial reset.
>>>
>>>> Care to explain what exactly the problem with the hwmod code not doing
>>>> the reset on init?
>>>
>>> And we only need to deassert the reset in probe. Technically, we don't
>>> need to assert first and deassert in probe, and that was a design choice
>>> made by Kishon.
>>
>> OK so if hwmod code has already done the reset, then why would you need
>> to deassert reset in the device driver probe?
> 
> The hwmod code only asserts the reset lines and that is not enough to access
> the PCI registers. The reset lines must be de-asserted before accessing the
> PCIe registers.
>>
>>>> And why do you need to do another reset in dra7xx_pcie_remove()?
>>>
>>> Primarily to restore the reset state back to what it was after the
>>> driver remove gets called. We cannot call deassert twice without calling
>>> a assert in between. Kishon had originally added the assert and deassert
>>> only in probe, but nothing in remove, they ought to be deassert in probe
>>> and assert in remove to match initial hardware state, and to also make
>>> it work across multiple probe/remove.
> 
> right. I thought if some program like the bootloader requires the reset lines
> to be in initial hw state, then it might break on 'reboot'. So restored it back
> to the initial hw state.
>>
>> I don't understand this part either.. Usually you just power up and init
>> the registers to a sane state in a device driver probe and on exit just
>> power down the device.
>>
>>>>>> Basically I'm wondering how come we need these platform data callbacks
>>>>>> at all.
>>>>>
>>>>> The hardresets are controlled through the
>>>>> omap_device_assert(deassert)_hardreset functions, and since these are
>>>>> limited to mach-omap2, we are invoking them through platform data callbacks.
>>>>
>>>> Right.. But I'm wondering about the why you need to do this in the
>>>> driver at all part :)
>>>
>>> The initial reset at init time is okay, but hwmod _enable() bails out if
>>> the resets lines are asserted. This was a change made long time back, I
>>> believe to deal with the problems around the DSP enabling sequences. As
>>> such, pm_runtime_get_sync() and put_sync() do not deassert and assert
>>> the resets.
>>
>> OK if the hwmod code does not deassert reset lines properly on enable,
>> then that sounds like a bug that should be fixed instead of adding
>> device specific work arounds.
> 
> I think some devices require the reset lines to be asserted and some devices
> require it to be de-asserted and hwmod was designed when there was only the
> first type of devices. I'm not sure though.
>>
>> Sorry to keep dragging this on a bit longer, but I think we need to
>> hear Paul's comments on this one.
> 
> I agree.
> Paul, what do you think is the best way forward to perform reset?

Can you give your feedback as we are at the risk of PCIe driver being removed?

Thanks
Kishon

> 
> Thanks
> Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
