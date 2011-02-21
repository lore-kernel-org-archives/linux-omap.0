From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Tue, 22 Feb 2011 00:40:16 +0100
Message-ID: <4D62F7E0.1000102@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com> <4D5A75FF.5040703@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024B83BF08@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BD4894D@dbde02.ent.ti.com> <4D623ED8.4050906@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BD489B1@dbde02.ent.ti.com> <4D6273FE.3000205@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024BD48BED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43150 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab1BUXkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 18:40:18 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LNeHkc025853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 17:40:17 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1LNeH2F013020
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 17:40:17 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1LNeHF8022455
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 17:40:17 -0600 (CST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BD48BED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/21/2011 4:41 PM, Premi, Sanjeev wrote:

[...]

>> The comment is already there BTW, so you just have to replace that by some
>> real code:-)
>
> [sp] I have already added real code, but the problem lies here:
>       On same file (few lines up) omap_chip.oc is assigned value of
>       CHIP_IS_OMAP3430. CHIP_IS_AM3517 now needs to be added to all
>       places where CHIP_IS_OMAP3430ES3_1 is chosen.
>
>       All this to support a chip that differs in 4 peripherals and IVA.
>       ... and this is what I was planning to minimize.

This is what we've being using for some time to handle small diff 
between ES.

>       Leaving aside AM3517; we have AM3703 - same as OMAP3630 but without
>       IVA and SGX. Here obviously hwmods for either of IVA, SGX shouldn't
>       be initialized. Isn't it?
>
>       Creating CHIP_IS_ ... here would be an overkill. Thoughts?

It depends how many variant you plan to do :-) We still have some room 
for 18 more variants / chip.

You can still create a new CHIP_IS, and add a alias 
CHIP_IS_OMAP36XX_COMMON = CHIP_IS_OMAP3630 | CHIP_IS_AM3703 and then 
replace all the existing entry with that alias.

If we want to avoid using these defines, you will have potentially to 
add a feature entry in every hwmod / clock / power domain entry that 
already uses the omap_chip today.
And then during the init we can filter on both the chip revision and 
chip features.
The drawback is that we are going to waste at least 300 x 32 bits to 
store that :-)
Whereas with the extra CHIP_IS_, it is just a couple of defines... no 
memory impact.

In between, you can consider a hwmod class to feature mapping, in order 
to know what hwmod class will be excluded if the feature is not there 
during the iteration.

I think I still prefer the first solution.

Regards,
Benoit
