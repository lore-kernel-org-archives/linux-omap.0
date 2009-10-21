From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: stable kernel version
Date: Wed, 21 Oct 2009 14:21:58 +0200
Message-ID: <4ADEFCE6.3010608@tzi.de>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com>	 <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com>	 <4AD88BBD.9010602@tzi.de> <20091016154051.GE12576@atomide.com>	 <4ADC7476.9090208@tzi.de>	 <FCCFB4CDC6E5564B9182F639FC35608702FA174DCE@dbde02.ent.ti.com>	 <4ADC9470.4080403@tzi.de>	 <A24693684029E5489D1D202277BE89444CFD937C@dlee02.ent.ti.com> <269694c00910191028x7e9499cas6e6f51b75fa15710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:46415 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753393AbZJUMWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 08:22:05 -0400
In-Reply-To: <269694c00910191028x7e9499cas6e6f51b75fa15710@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <2ameya@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ameya,
this patch fixes the kernel panic. For my taste
there should be a more verbose message, that
the USB won't work, but otherwise it is fine ;-)
Regards
    Janosch

Ameya Palande wrote:
> Hi,
>
> Does this commit fixes the issue?
>
> [v2] usb: musb: Warn and check for OTG transceiver misconfiguration
>
> Warn if OTG is selected in Kconfig but not initialized by platform code.
> Add checks to prevent NULL pointer exception in case the
> OTG transceiver has not been initialized. i.e. musb->xceiv == NULL
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> ---
>  drivers/usb/musb/musb_core.c |    7 ++++++-
>  drivers/usb/musb/omap2430.c  |    3 ++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> Link: http://patchwork.kernel.org/patch/32914/
>
> Cheers,
> Ameya.
>
> On Mon, Oct 19, 2009 at 8:19 PM, Maldonado Zambrano, Ivan
> <ivan.maldonado@ti.com> wrote:
>   
>> Hi Machowinski,
>>
>> Enabling TWL4030 USB Transceiver Driver on your menuconfig the issue that you mentioned on a log file attached on previous mails is corrected. I had the same problem. Like an introduction, my name is Ivan Maldonado Zambrano and I'm working on USB tests for zoom3 and sdp. Attached my log file, if you compare with yours is the same problem.
>>
>> Regards
>> Maldonado Zambrano, Ivan
>> x0109876@ti.com
>> Project L23x3630.
>>
>>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Janosch Machowinski
>> Sent: Monday, October 19, 2009 11:32 AM
>> To: linux-omap@vger.kernel.org
>> Subject: Re: stable kernel version
>>
>> Pandita, Vikram schrieb:
>>     
>>> Here's the problem:
>>> <3>HS USB OTG: no transceiver configured
>>> <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19
>>>
>>> Depending on your board, you will have to define the transceiver for MUSB.
>>> It could be TWL4030 or NO-transceiver...
>>>
>>>       
>> I got an Gumstix Overo Earth so which one would it be then ?
>>
>> I tried one kernel, with only NOOP,
>> and one with all three options enabled,
>> same result any time (crash).
>>     
>>> Drivers -> USB -> (last options) *** OTG and related infrastructure ***
>>>
>>> Or do u want to disable USB to start with !!
>>>
>>>       
>> Actually USB is the feature why I started compiling a new kernel
>> in the fist place ;-)
>>
>>
>> Regards
>>    Janosch
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>     
>
>   

