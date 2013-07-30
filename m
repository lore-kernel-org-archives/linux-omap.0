From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for DRA7xx
 based SoCs'
Date: Tue, 30 Jul 2013 13:43:05 -0500
Message-ID: <51F80939.7060403@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-2-git-send-email-rnayak@ti.com> <20130730131009.GA28162@radagast> <51F7CB2F.6070705@ti.com> <20130730142353.GL28162@radagast> <51F7CF6F.6050702@ti.com> <20130730153138.GA5978@radagast> <51F807EF.6020809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34879 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab3G3Snc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 14:43:32 -0400
In-Reply-To: <51F807EF.6020809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, ambresh@ti.com, sourav.poddar@ti.com

On 07/30/2013 01:37 PM, Sricharan R wrote:
> Hi,
> On Tuesday 30 July 2013 09:02 PM, Felipe Balbi wrote:
>> Hi,
>>
>> On Tue, Jul 30, 2013 at 08:06:31PM +0530, Sricharan R wrote:
>>> On Tuesday 30 July 2013 07:53 PM, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Tue, Jul 30, 2013 at 07:48:23PM +0530, Sricharan R wrote:
>>>>> On Tuesday 30 July 2013 06:40 PM, Felipe Balbi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
>>>>>>> @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
>>>>>>>   # define soc_is_omap543x()		is_omap543x()
>>>>>>>   #endif
>>>>>>>
>>>>>>> +# if defined(CONFIG_SOC_DRA7XX)
>>>>>>> +# undef soc_is_dra7xx
>>>>>>> +# undef soc_is_dra75x
>>>>>>> +# define soc_is_dra7xx()		is_dra7xx()
>>>>>>> +# define soc_is_dra75x()		is_dra75x()
>>>>>> since this platform is DT-only, couldn't we just believe DT-data to be
>>>>>> correct of_machine_is_compatible() ? 2/3 of this patch would be removed.
>>>>>>
>>>>>> I patched this for OMAP5 (compile-tested only, no boards available) and
>>>>>> came out with the patch below (still needs to be split):
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>>>>>> index 08b7267..b3136e5 100644
>>>>>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>>>>>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>>>>>> @@ -13,7 +13,7 @@
>>>>>>
>>>>>>   / {
>>>>>>   	model = "TI OMAP5 uEVM board";
>>>>>> -	compatible = "ti,omap5-uevm", "ti,omap5";
>>>>>> +	compatible = "ti,omap5-uevm", "ti,omap5432-es2.0", "ti,omap5";
>>>>>>
>>>>>   ok, nice and simpler way.
>>>>>   But would this make different revisions, to appear the same ?
>>>> well omap5-uevm is omap5432 es2.0 only, right ? If a new board comes up,
>>>> it should be treated as such, then you can pass a different string to
>>>> that new board's compatible attribute.
>>>> s
>>>   Yes for OMAP5. I was thinking in general about this approach.
>>>   For example, for OMAP4 we have same board and
>>>   different revisions can be socketed there.
>>>
>>>   For OMAP5, this is good.
>> do we really production socketed boards? Well, at least Blaze has such
>> thing. But do we have too many differences that need to be trated at
>> arch/arm or should/could those be handled by reading IP's revision
>> register (e.g. usb host erratas)
>>
>   OMAP4 SDP is socketed as well.
a) OMAP4SDP is not production device
b) OMAP4SDP uses SOM (System On Module)
c) Socketted SOMs were used only during initial days of SoC
d) almost all latest OMAP4 SDP switched to using soldered in SOM
e) we claim compatibility of OMAP4 SDP with Blaze.

So, I dont think this is a rational argument for keeping soc checks with 
dts.

>   Ya, revision checks used only in few places and as you said
>   we handle them using IP revisions, but that we have to look and clean
>   up those places, if we really intend to do this for other socs.

I agree this is the right approach :).


-- 
Regards,
Nishanth Menon
