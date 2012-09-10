From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] arm: omap: hwmod: add a new addr space in otg for
 writing to control module
Date: Mon, 10 Sep 2012 18:17:03 +0200
Message-ID: <504E127F.6020406@ti.com>
References: <1346943331-18120-1-git-send-email-kishon@ti.com>
 <1346943331-18120-2-git-send-email-kishon@ti.com> <5048C2A2.2020104@ti.com>
 <20120906171301.GC17754@arwen.pp.htv.fi>
 <20120906171803.GA30717@arwen.pp.htv.fi> <20120906195607.GB1303@atomide.com>
 <20120910155855.GE7464@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120910155855.GE7464-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 09/10/2012 05:58 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Sep 06, 2012 at 12:56:07PM -0700, Tony Lindgren wrote:
>> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [120906 10:23]:
>>> Hi,
>>>
>>> On Thu, Sep 06, 2012 at 08:13:03PM +0300, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Thu, Sep 06, 2012 at 09:04:58PM +0530, Vaibhav Hiremath wrote:
>>>>>
>>>>>
>>>>> On 9/6/2012 8:25 PM, Kishon Vijay Abraham I wrote:
>>>>>> The mailbox register for usb otg in omap is present in control module.
>>>>>> On detection of any events VBUS or ID, this register should be written
>>>>>> to send the notification to musb core.
>>>>>>
>>>>>> Till we have a separate control module driver to write to control module,
>>>>>> omap2430 will handle the register writes to control module by itself. So
>>>>>> a new address space to represent this control module register is added
>>>>>> to usb_otg_hs.
>>>>>>
>>>>>> Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>>>> ---
>>>>>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>>> index 242aee4..02341bc 100644
>>>>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>>> @@ -5890,6 +5890,11 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
>>>>>>  		.pa_end		= 0x4a0ab003,
>>>>>>  		.flags		= ADDR_TYPE_RT
>>>>>>  	},
>>>>>> +	{
>>>>>> +		.pa_start	= 0x4a00233c,
>>>>>> +		.pa_end		= 0x4a00233f,
>>>>>> +		.flags		= ADDR_TYPE_RT
>>>>>> +	},
>>>>>
>>>>> I do not have any objection/comment here, but I believe this is control
>>>>> module address space required for USB module, right?
>>>>> I am not sure this is right way of accessing control module space.
>>>>> Actually Control Module Access required for drivers is one of the
>>>>> blocking issue we have currently.
>>>>>
>>>>> Also there was some effort put up by 'Konstantine' to convert Control
>>>>> module to MFD driver, I haven't seen any further update on it. But it
>>>>> would be good to check with him.
>>>>
>>>> this was an agreement with Benoit since we already lost a couple merge
>>>> windows for this patchset. We agreed to wait until -rc4 for SCM driver
>>>> and if it wasn't ready, we'd go ahead with this and SCM author would fix
>>>> it up on a patch converting users to new SCM driver.
>>>
>>> Tony, can I get your Acked-by to this patch so I can take it together
>>> with the rest of the series ? Thanks
>>>
>>> ps: I'll apply this to my 'musb' branch which is immutable, so it's safe
>>> to merge it into your tree once I apply.
>>
>> It would be best if this got acked by Benoit and Paul as they may
>> have some other patches queued up. I'll ack if they ack ;)
> 
> Benoit, care to ack this patch ???

Gosh, that's hard to ack something like that :-)

But considering that the control module driver is not there yet, I have
no choice but accepting that one if we want to have the functionality
we've been waiting for years.

Could you just update the patch with a big disclaimer on top of the
address range to explain that this should not belong here and will be
removed ASAP, when the proper driver will be done.

Then you sign the patch with your blood and that should be fine for me :-).

Thanks,
Benoit
