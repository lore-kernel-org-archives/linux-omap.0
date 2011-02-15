From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Tue, 15 Feb 2011 13:47:59 +0100
Message-ID: <4D5A75FF.5040703@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39187 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab1BOMsD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 07:48:03 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1FCm2WV001043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:48:02 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1FCm24f026421
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:48:02 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1FCm2xm014751
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:48:02 -0600 (CST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Sanjeev,

On 2/15/2011 12:51 PM, Premi, Sanjeev wrote:
> AM3517 doesn't support SmartReflex.
>
> However, these HWMODS are defined in omap3xxxx_hwmods[]:
> 	&omap34xx_sr1_hwmod,
> 	&omap34xx_sr2_hwmod,
> 	&omap36xx_sr1_hwmod,
> 	&omap36xx_sr2_hwmod,
>
> (similar definition in l4_slaves as well)
>
> This leads to crash when booting the kernel on AM3517EVM during
> _setup().
>
> I see the field .omap_chip being initialized; but not used.

Yes, it is. During the hwmod initialization (omap_hwmod_init), only the 
hwmods that match the correct chip version are kept.
I guess that your problem is that AM3517 is probably seen as a regular 
3430 for the moment.

> If I were to use this - along with cpu_is_omap3517(), I would need
> to define a new flag e.g. CHIP_IS_AM3517 and add it to almost all
> devices defined in omap_hwmod_3xxx_data.c.
>
> Before going all out on making changes, wanted to check if there is
> a better way. Has this/similar possibility been considered earlier?

Well, this is the best way to do that for my point of view. This 
.omap_chip field was done for that purpose.
During device init, the sr code will do query for the smartreflex hwmod 
and will failed, thus avoiding to do further initialization.

Regards,
Benoit

