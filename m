From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Add basic support for 720MHz part
Date: Fri, 7 Jan 2011 23:01:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024829AE88@dbde02.ent.ti.com>
References: <1294405659-25662-1-git-send-email-premi@ti.com>
 <87wrmgoe2a.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53370 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab1AGRbf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:31:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p07HVWse031104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 7 Jan 2011 11:31:34 -0600
In-Reply-To: <87wrmgoe2a.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com] 
> Sent: Friday, January 07, 2011 10:18 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > This patch adds support for new speed enhanced parts with ARM
> > and IVA running at 720MHz and 520MHz respectively. These parts
> > can be probed at run-time by reading PRODID.SKUID[3:0] at
> > 0x4830A20C [1].
> 
> Please expand this a little to describe exactly which parts have this
> feature.  All OMAP3?  34xx? 35xx? what about 36xx/37xx?  ISTR the
> runtime probing for this feature is available on 35xx but not on 34xx,
> but a summary of this should be here.
> 

[sp] Will update...

[snip]...[snip]

> nit: Unrelated to this patch, but OMAP3EVM ethernet is still 
> broken due to
> missing GPIO configuration for the network reset.  This has 
> been broken
> since the GPIO hwmod merge and pointed out but nobody seems 
> to be fixing
> it.

[sp] It is currently in works.

[snip]...[snip] 

> > +			omap34xx_opp_def_list[INDEX_MPU_720MHZ]
> > +				.default_available = true;
> > +			omap34xx_opp_def_list[INDEX_IVA_720MHZ]
> > +				.default_available = true;
> > +		}
> > +
> 
> I'm with Nishanth here.  Please stick to the OPP API for 
> enabling OPPs.
> 
> First, it is future proof to internal table changes, but it 
> also sets a
> better precedent for others wanting to fiddle with OPPs.
> 

[sp] Okay. I will have to revert the a patch on my repo
     to to get there. Will send an update patch on MON.

> Thanks,
> 
> Kevin

[snip]...[snip] 
