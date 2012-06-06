From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Wed, 6 Jun 2012 09:21:28 +0200
Message-ID: <4FCF04F8.2090305@ti.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com> <4FC4C4FA.1070403@ti.com> <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46349 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2FFHVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 03:21:36 -0400
In-Reply-To: <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>

Salut Paul,

On 6/6/2012 12:55 AM, Paul Walmsley wrote:
> Hello Beno=EEt
>
> On Tue, 29 May 2012, Cousson, Benoit wrote:
>
>> On 5/25/2012 11:56 PM, Paul Walmsley wrote:
>>
>>> This patch is effectively a workaround for a hardware oversight.  A
>>> better hardware approach would have been to implement a smart-idle
>>> target idle mode for this IP block.  The smart-idle mode in this ca=
se
>>> would behave identically to the force-idle mode.
>>
>> I'm not sure to follow you here :-)
>
> I should rewrite that paragraph.  It is not as clear as it could be.
>
>> force-idle is almost equivalent to smart-idle, so it is the right
>> workaround when smart-idle is not implemented.
>>
>> In force-idle idleack =3D idlereq. Whereas in smart-idle idleack =3D=
 idlereq
>> if internal /OCP activity is completed.
>
> It would be nice if the hardware people just implemented smart-idle o=
n
> all IP blocks.  Section 3.1.1.1.2 "Module-Level Clock Management" of =
The
> OMAP4430 TRM Rev. vAA states:
>
> "Smart-idle mode is the preferred mode of operation, while forced-idl=
e and
> no-idle modes are intended for debugging purposes."
>
> Then no flags or software workarounds would be needed, except for
> debugging.

I know... I'm dreaming as well of HW that stick to the spec :-)

>> So in fact, I'm wondering if a new flag is needed. We can potentiall=
y apply that if
>> idlemodes =3D=3D (SIDLE_FORCE | SIDLE_NO).
>>
>> We need to check which IP will have that to ensure that does not add=
 any side-effects.
>
> I guess that means me :-)

Hehe, not really, I did it for OMAP4/5. counter_32k is the only IP with=
=20
that broken mode. GPU and IVA does have some missing modes as well but=20
at least smart_idle is there.

Regards,
Benoit

>> BTW, please note that the current idlemodes flags are wrong for the
>> counter 32k. I've just figured out that fixing the STANDBY flags for
>> some OMAP5 IPs. I'll add that fix in my WIP OMAP4 hwmod data cleanup=
 for
>> 3.6.
>>
>> Something like that:
>
> Okay will queue up a fix for 3.5-rc.
>
>>>    			.context_offs =3D OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
>>>    		},
>>>    	},
>>> +	.flags		=3D HWMOD_ALWAYS_FORCE_SIDLE,
>>
>> I'm confused by the location and the value, both linus/master and
>> lo/master branches does already have a flag for the counter_32k:
>>
>> /* counter_32k */
>> static struct omap_hwmod omap44xx_counter_32k_hwmod =3D {
>>          .name           =3D "counter_32k",
>>          .class          =3D&omap44xx_counter_hwmod_class,
>>          .clkdm_name     =3D "l4_wkup_clkdm",
>>          .flags          =3D HWMOD_SWSUP_SIDLE,
>>          .main_clk       =3D "sys_32k_ck",
>>          .prcm =3D {
>>                  .omap4 =3D {
>>                          .clkctrl_offs =3D OMAP4_CM_WKUP_SYNCTIMER_C=
LKCTRL_OFFSET,
>>                          .context_offs =3D OMAP4_RM_WKUP_SYNCTIMER_C=
ONTEXT_OFFSET,
>>                  },
>>          },
>> };
>>
>> So the patch should be slightly different, I guess ?
>>
>>   	.class          =3D&omap44xx_counter_hwmod_class,
>>   	.clkdm_name     =3D "l4_wkup_clkdm",
>> -	.flags          =3D HWMOD_SWSUP_SIDLE,
>> +	.flags		=3D HWMOD_ALWAYS_FORCE_SIDLE,
>>   	.main_clk       =3D "sys_32k_ck",
>>   	.prcm =3D {
>>
>>
>> This is the same issue for OMAP3 data.
>>
>> What base branch are you using?
>
> The wrong one, evidently.  Will ensure this is fixed.
>
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
