From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 06/10] ARM: OMAP2+: Show bootloader GPMC timings to allow
 configuring the .dts file
Date: Tue, 4 Nov 2014 15:40:01 +0200
Message-ID: <5458D731.1010208@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-7-git-send-email-tony@atomide.com> <545248FA.7040201@ti.com> <20141030144529.GG2542@atomide.com> <54525362.9080000@ti.com> <20141030163031.GG2560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57619 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbaKDNkb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2014 08:40:31 -0500
In-Reply-To: <20141030163031.GG2560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/30/2014 06:30 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141030 08:05]:
>> On 10/30/2014 04:45 PM, Tony Lindgren wrote:
>>> * Roger Quadros <rogerq@ti.com> [141030 07:21]:
>>>> On 10/30/2014 02:29 AM, Tony Lindgren wrote:
>>>>> +static void gpmc_cs_show_timings(int cs, const char *desc)
>>>>> +{
>>>>> +	gpmc_show_regs(cs, desc);
>>>>> +
>>>>> +	pr_info("gpmc cs%i access configuration:\n", cs);
>>>>> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
>>>>> +	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
>>>>> +	GPMC_GET_RAW(GPMC_CS_CONFIG1, 12, 13, "device-width");
>>>>> +	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
>>>>> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
>>>>> +	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 22, 22, "wait-on-read");
>>>>> +	GPMC_GET_RAW_SHIFT(GPMC_CS_CONFIG1, 23, 24, 3, "burst-length");
>>>>
>>>> how does this work with shift = 3?
>>>> Possible values of burst length are
>>>> 0 -> 4
>>>> 1 -> 8
>>>> 2 -> 16
>>>
>>> Hmm sounds like a bug..
> 
> The shift does not work here for 0 << 3 naturally :) I've changed
> it to l = (shift << l) where shift is 4 in this case.
>  
>>> In general, if you a chance to test this patch with a few
>>> devices that would be great. Assuming you have working timings
>>> in the bootloader, just remove the gpmc,* entries temporarily
>>> from the .dts file for a device, and see if the values printed
>>> by this patch make sense. I've used this to generate the values
>>> for the 2430sdp smc91x and zoom 8250 but I don't think I've tried
>>> anything with a burst mode so far.
>>
>> OK. I'll give it a spin with u-boot configured devices.
> 
> Great thanks. Updated patch below.
> 
> Regards,
> 
> Tony
> 
> 
> 8< ----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 29 Oct 2014 17:16:48 -0700
> Subject: [PATCH] ARM: OMAP2+: Show bootloader GPMC timings to allow configuring the .dts file
> 
> As we still have some devices with GPMC timings missing from the
> .dts files, let's make it a bit easier to use the bootloader
> values and print them out.
> 
> Note that we now need to move the parsing of the device tree provided
> configuration a bit earlier so we can use that for checking if anything
> was configured.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 

I don't have any board with smsc or working NOR so I called
gpmc_cs_show_timings() after NAND was setup.

The printed values match closely to the configured values in the DTS.

cheers,
-roger

