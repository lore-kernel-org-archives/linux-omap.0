From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 5/7] ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
Date: Wed, 18 Jun 2014 14:24:46 +0300
Message-ID: <53A176FE.4040608@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <1399283686-6127-6-git-send-email-rogerq@ti.com> <53A173A5.7020509@ti.com> <53A175DC.8080709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A175DC.8080709-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/18/2014 02:19 PM, Rajendra Nayak wrote:
> On Wednesday 18 June 2014 04:40 PM, Roger Quadros wrote:
>> + Nishant and Rajendra for review.
>>
>> On 05/05/2014 12:54 PM, Roger Quadros wrote:
>>> Add the sysconfig class bits for the Super Speed USB
>>> controllers
>>>
>>> CC: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> 
> verified against TRM version vP, looks good to me.
> Reviewed-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>

Tested-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

against 3.16-rc1. no dependency patches.

cheers,
-roger

> 
>>> ---
>>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>> index 810c205..067d322 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>> @@ -1731,8 +1731,20 @@ static struct omap_hwmod dra7xx_uart6_hwmod = {
>>>   *
>>>   */
>>>  
>>> +static struct omap_hwmod_class_sysconfig dra7xx_usb_otg_ss_sysc = {
>>> +	.rev_offs	= 0x0000,
>>> +	.sysc_offs	= 0x0010,
>>> +	.sysc_flags	= (SYSC_HAS_DMADISABLE | SYSC_HAS_MIDLEMODE |
>>> +			   SYSC_HAS_SIDLEMODE),
>>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>>> +			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
>>> +			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
>>> +	.sysc_fields	= &omap_hwmod_sysc_type2,
>>> +};
>>> +
>>>  static struct omap_hwmod_class dra7xx_usb_otg_ss_hwmod_class = {
>>>  	.name	= "usb_otg_ss",
>>> +	.sysc	= &dra7xx_usb_otg_ss_sysc,
>>>  };
>>>  
>>>  /* usb_otg_ss1 */
>>>
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
