From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Fri, 18 Feb 2011 17:43:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024B83BF08@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
 <4D5A75FF.5040703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34293 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462Ab1BRMNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 07:13:11 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ICD7Qe012747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 06:13:10 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ICD7if011551
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 17:43:07 +0530 (IST)
In-Reply-To: <4D5A75FF.5040703@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Tuesday, February 15, 2011 6:18 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: hwmod: multi-omap: disabling smartreflex on AM3517
> 
> Hi Sanjeev,
> 
> On 2/15/2011 12:51 PM, Premi, Sanjeev wrote:
> > AM3517 doesn't support SmartReflex.
> >
> > However, these HWMODS are defined in omap3xxxx_hwmods[]:
> > 	&omap34xx_sr1_hwmod,
> > 	&omap34xx_sr2_hwmod,
> > 	&omap36xx_sr1_hwmod,
> > 	&omap36xx_sr2_hwmod,
> >
> > (similar definition in l4_slaves as well)
> >
> > This leads to crash when booting the kernel on AM3517EVM during
> > _setup().
> >
> > I see the field .omap_chip being initialized; but not used.
> 
> Yes, it is. During the hwmod initialization (omap_hwmod_init), only the
> hwmods that match the correct chip version are kept.
> I guess that your problem is that AM3517 is probably seen as a regular
> 3430 for the moment.
> 
> > If I were to use this - along with cpu_is_omap3517(), I would need
> > to define a new flag e.g. CHIP_IS_AM3517 and add it to almost all
> > devices defined in omap_hwmod_3xxx_data.c.
> >
> > Before going all out on making changes, wanted to check if there is
> > a better way. Has this/similar possibility been considered earlier?
> 
> Well, this is the best way to do that for my point of view. This
> .omap_chip field was done for that purpose.
> During device init, the sr code will do query for the smartreflex hwmod
> and will failed, thus avoiding to do further initialization.

[sp] Trying to avoid big change, and thinking 'narrowly' about this
     issue in isolation, I had been mulling adding SmartReflex to
     the omap3_features; and (somehow) using the same.

     But after noticing the patch related to USBOTG on AM35x, I think
     original proposal is unambiguous and best way forward.

     Started working on the patch. Hope to have it ready later tonight
     or tomorrow.

~sanjeev

> 
> Regards,
> Benoit

