From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 04/35] ARM: OMAP3+: PRM: add common APIs for prm_vp_check/clear_txdone
Date: Wed, 25 Feb 2015 21:44:32 +0200
Message-ID: <54EE2620.8080106@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com> <1424891085-10392-5-git-send-email-t-kristo@ti.com> <20150225190930.GN11136@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38927 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbbBYToc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:44:32 -0500
In-Reply-To: <20150225190930.GN11136@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/25/2015 09:09 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Feb 25, 2015 at 09:04:14PM +0200, Tero Kristo wrote:
>> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
>> index 2c2e7ed..79cee11 100644
>> --- a/arch/arm/mach-omap2/prm_common.c
>> +++ b/arch/arm/mach-omap2/prm_common.c
>> @@ -555,6 +555,40 @@ int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
>>   }
>>
>>   /**
>> + * omap_prm_vp_check_txdone - check voltage processor TX done status
>> + *
>> + * Checks if voltage processor transmission has been completed.
>> + * Returns non-zero if a transmission has completed, 0 otherwise.
>> + */
>> +u32 omap_prm_vp_check_txdone(u8 vp_id)
>> +{
>> +	if (!prm_ll_data->vp_check_txdone) {
>> +		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
>> +			  __func__);
>
> same here:
>
> 	if (WARN_ONCE(!prm_ll_data->vp_check_txdone,
> 		"prm: %s: no mapping function defined\n", __func__))
>
> same for all others below
>

Similar convention (the one I used) is already used all over the place 
in the same file, would probably be better to convert them all at the 
same time if needed.

-Tero
