From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Fri, 25 Feb 2011 13:40:21 +0100
Message-ID: <4D67A335.3030102@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com> <4D5A75FF.5040703@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024B83BF08@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BD4894D@dbde02.ent.ti.com> <4D623ED8.4050906@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BD489B1@dbde02.ent.ti.com> <4D6273FE.3000205@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BD48BED@dbde02.ent.ti.com>,<4D62F7E0.1000102@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BBE29A4@dbde02.ent.ti.com>,<4D643E6A.5020705@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BBE29B0@dbde02.ent.ti.com> <4D652D3E.7010501@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BE49E50@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34588 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1BYMkY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 07:40:24 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BE49E50@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Hi Sanjeev,

On 2/25/2011 12:39 PM, Premi, Sanjeev wrote:
>> From: Cousson, Benoit
>> Sent: Wednesday, February 23, 2011 9:23 PM

[...]

>> In that case you can handle that using cpu_is_3517().
>>
>> omap_hwmod_init(omap3xxx_common_hwmods);
>> if (omap3_has_smartreflex())
>>           omap_hwmod_init(omap3xxx_sr_hwmods);
>> if (omap3_has_iva())
>>           omap_hwmod_init(omap3xxx_iva_hwmods);
>> if (cpu_is_omap3517())
>>           omap_hwmod_init(omap3xxx_emac_usb_vpfe_hwmods);
>> ...
>>
>> Isn't it enough for your needs?
>>
> [sp] Removal of smartreflex has more cyclic dependencies than I expected.

I didn't anticipated that either :-(

> Just removing omap34xx_sr1_hwmod, omap34xx_sr2_hwmod isn't sufficient.
> It leads to:
>
> [    0.000000] omap_hwmod: l4_core: cannot clk_get interface_clk sr_l4_ick
> [    0.000000] omap_hwmod: l4_core: cannot clk_get interface_clk sr_l4_ick
>
> Now wemoving, omap3_l4_core__sr1 and omap3_l4_core__sr2 from the array
> omap3xxx_l4_core_slaves[] leads to ripple effect in pretty much all
> hwmods.
>
> . omap3xxx_l4_core_slaves is referenced in omap3xxx_l4_core_hwmod,
> . omap3xxx_l4_core_hwmod is referenced in many other hdmods.
> . and so on.
>
> In the end, we might end up making changes to almost all.
> I will be submitting an updated patch in about an hour.

I'm afraid, we will probably end up with a dynamic binding solution like 
what we have to do for the clock framework for the similar reason.
We can optimize the size but it will impact the performance... the usual 
trade off.

Thanks,
Benoit
