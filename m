From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv2 06/10] ARM: DRA7: hwmod_data: Add mailbox hwmod data
Date: Wed, 23 Jul 2014 10:18:43 -0500
Message-ID: <53CFD253.9080805@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com> <1405115083-52977-7-git-send-email-s-anna@ti.com> <20140715133013.GA2605@atomide.com> <53C55D68.8050308@ti.com> <20140716070708.GC2605@atomide.com> <20140723092449.GF22006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34770 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757732AbaGWPTR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jul 2014 11:19:17 -0400
In-Reply-To: <20140723092449.GF22006@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 07/23/2014 04:24 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140716 00:10]:
>> * Suman Anna <s-anna@ti.com> [140715 09:59]:
>>> Hi Tony,
>>>
>>> On 07/15/2014 08:30 AM, Tony Lindgren wrote:
>>>> * Suman Anna <s-anna@ti.com> [140711 14:47]:
>>>>> Add the hwmod data for the 13 instances of the system mailbox
>>>>> IP in DRA7 SoC. The patch is needed for performing a soft-reset
>>>>> while configuring the respective mailbox instance, otherwise is
>>>>> a non-essential change for functionality. The modules are smart
>>>>> idled on reset, and the IP module mode is hardware controlled.
>>>>>
>>>>> Cc: Rajendra Nayak <rnayak@ti.com>
>>>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>> ---
>>>>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 305 ++++++++++++++++++++++++++++++
>>>>>  1 file changed, 305 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>>>> index 20b4398..e35f5b1 100644
>>>>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>>>>> @@ -939,6 +939,194 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
>>>>>  };
>>>>>  
>>>>>  /*
>>>>> + * 'mailbox' class
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +static struct omap_hwmod_class_sysconfig dra7xx_mailbox_sysc = {
>>>>> +	.rev_offs	= 0x0000,
>>>>> +	.sysc_offs	= 0x0010,
>>>>> +	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
>>>>> +			   SYSC_HAS_SOFTRESET),
>>>>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>>>>> +	.sysc_fields	= &omap_hwmod_sysc_type2,
>>>>> +};
>>>>> +
>>>>> +static struct omap_hwmod_class dra7xx_mailbox_hwmod_class = {
>>>>> +	.name	= "mailbox",
>>>>> +	.sysc	= &dra7xx_mailbox_sysc,
>>>>> +};
>>>>
>>>> Hmm I'm seeing just the following MAILBOX_SYSCONFIG in at least
>>>> am57xx TRM:
>>>>
>>>> 31:4	RESERVED
>>>> 3:2	SIDLEMODE	0 = force-idle 1 = no-idle, 2 = smart-idle, 3 = reserved
>>>> 1	RESERVED
>>>> 0	SOFTRESET
>>>>
>>>> So it seems that SYSC_HAS_RESET_STATUS above is wrong? Can you guys
>>>> please check.
>>>
>>> The same SOFTRESET bit is used for both triggering the softreset and
>>> reading the reset done status. Once you write a 1 to trigger a reset,
>>> the bit will be cleared once the reset is done. This is no different
>>> from OMAP4. The logic in _wait_softreset_complete in omap_hwmod.c was
>>> already designed to work with this properly.
>>
>> Oh OK, I guess I got it confused with SYSS_HAS_RESET_STATUS. Paul,
>> want to ack this one if no other issues? I can then set this series
>> into a branch against -rc1 that we can all merge in as needed as
>> it seems that the driver changes may need this branch as a base too.
> 
> I have applied these into omap-for-v3.17/mailbox and merged also
> into omap-for-v3.17/soc.
> 

Thank you, Tony.

regards
Suman

