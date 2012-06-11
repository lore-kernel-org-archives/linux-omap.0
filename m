From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned
 to PRCM modules
Date: Mon, 11 Jun 2012 23:11:46 +0200
Message-ID: <4FD65F12.2050805@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com> <1339433225-30042-2-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44247 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab2FKVLw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 17:11:52 -0400
In-Reply-To: <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 6/11/2012 7:26 PM, Paul Walmsley wrote:
> On Mon, 11 Jun 2012, Benoit Cousson wrote:
>
>> The following commit (794b480a37e3d284d6ee7344d8a737ef60476ed5) was =
adding
>> the PRCM IPs data for PRCM, CM, PRCM_MPU and SCRM.
>> The clkdm entry are not the correct ones and does not exist in the s=
ystem.
>>
>> Replace them with the proper wkup, l4_ao and l4_cfg.
>
> This does not match either the publicly avaiable documentation and th=
e
> internal NDA hardware specifications[1].

That's almost true, until I realized that the clock domain modules list=
=20
contain this information (clock.py/clock_domain['l4_wkup']['modules']).
Now, I'm wondering as well why this is not documented better. I'll chec=
k=20
that tomorrow.

> Nor does it make sense from a logical perspective.

I do think it does.

> To take an example from your patch:
>
>> @@ -2564,12 +2543,33 @@ static struct omap_hwmod_rst_info omap44xx_p=
rm_resets[] =3D {
>>   static struct omap_hwmod omap44xx_prm_hwmod =3D {
>>   	.name		=3D "prm",
>>   	.class		=3D &omap44xx_prcm_hwmod_class,
>> -	.clkdm_name	=3D "prm_clkdm",
>> +	.clkdm_name	=3D "l4_wkup_clkdm",
>>   	.mpu_irqs	=3D omap44xx_prm_irqs,
>>   	.rst_lines	=3D omap44xx_prm_resets,
>>   	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_prm_resets),
>>   };
>
> There is no possible way that the PRM can exist in the L4_WKUP
> clockdomain.  The L4_WKUP clockdomain must be able to go inactive for=
 the
> chip to enter idle, as we just discussed[1].  But the PRM is the
> entity that supervises chip wakeup from off-mode, so for off-mode
> to work, there's no way that the PRM can be clock-gated.

OK, so let's replace PRM by GPT1, without the part that is not=20
applicable in that case:

"There is no possible way that the GPT1 can exist in the L4_WKUP=20
clockdomain. The L4_WKUP clockdomain must be able to go inactive for th=
e
chip to enter idle, as we just discussed[1] ... so for off-mode
to work, there's no way that the GPT1 can be clock-gated."

Don't you think that this sentence looks wrong now?
Why can the GPT1 run during OFF mode and not the PRM?

The wkup domain is far from being a standard domain. The 32k is always=20
running even in OFF mode. So for the same reason, that domain can go to=
=20
inactive without gating the 32k. This is clearly not a standard domain=20
but that does not make it a bad one either.

All the IPs that belongs to the l4_wkup are all active during OFF mode,=
=20
so is the PRM. The point discussed in [1] clearly show that the domain=20
inactive state in the case of the wakeup is just used for the OCP clock=
=2E=20
The functional 32k is still active during OFF mode.

> Frustrating :-(

You should not, I'm happy we were able to figured out where these PRCM=20
IPs are located after all these years :-)

>> Fix as well the wrong OCP port used by the cm_core_aon. It uses the
>> l4_cfg interconnect and not the l4_wkup.
>>
>> Re-order the entries by address value.
>
> If you split this part off into a separate patch, I'll take it.

You should take both since this patch is perfectly valid as explained=20
previously.

cm_clkdm does not exist either whereas l4_aon / l4_cfg does. And=20
honestly considering that the core_cm_aon is inside a domain names=20
l4_aon does not seems stupid at all.

The more or less accurate definition of the PRCM clock domain since eve=
r=20
is that a domain is mostly a group of IPs and the related clocks that=20
does belong to the same interconnect. So it makes sense that the cm_cor=
e=20
(CM2), cm_core_aon (CM1) and prm does belong to the domain that contain=
s=20
its respective interconnect.

Regards,
Benoit


> - Paul
>
> 1. Cousson, Beno=EEt.  _Re: [PATCH] ARM: OMAP2+: hwmod code/data: fix=
 32K
>     sync timer_.  linux-omap@vger.kernel.org mailing list.  Available=
 from
>     http://www.spinics.net/lists/arm-kernel/msg177128.html (among oth=
ers).
>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
