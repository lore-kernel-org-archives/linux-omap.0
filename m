From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/3] Add support for OMAP35x processors
Date: Sun, 11 Jan 2009 01:24:43 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB858B54@dbde02.ent.ti.com>
References: <1231513323-27379-1-git-send-email-premi@ti.com>
 <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301BB858A3B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56464 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZAJTy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 14:54:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0AJsmcO007874
	for <linux-omap@vger.kernel.org>; Sat, 10 Jan 2009 13:54:54 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0AJsloa016245
	for <linux-omap@vger.kernel.org>; Sun, 11 Jan 2009 01:24:48 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301BB858A3B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Friday, January 09, 2009 10:29 PM
> To: Aguirre Rodriguez, Sergio Alberto; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 0/3] Add support for OMAP35x processors
> 
> <snip>
> 
> > > +config ARCH_OMAP35XX
> > > +	bool "OMAP35x Family"
> > > +	select ARCH_OMAP3
> > > +	select ARCH_OMAP34XX
> > > +	select ARCH_OMAP3430
> > > +	select OMAP3430_ES2
> > 
> > AFAIK the above select (OMAP3430_ES2) doesn't exist. 
> > omap_rev() is used in drivers to check instead.
> 
> [sp] Wasn't aware; will remove it.

Done.

> 
> > Question to all,
> > 
> > Why don't making above options as choice.. endchoice. Or is 
> there any 
> > case that multiple boards are compiled at once?
> 
> [sp] It is a quick change; will wait for a day - just in case 
> there is a different opinion.

Done for OMAP3 boards only. There were few cases of circular dependency in H4 boards; and an additional "default" value set for MACH_OMAP2_TUSB6010 (line 109).

Though I was able to take care of circular dependency by moving the config items out of choice .. endchoice block, wasn't sure of impact if I removed the default value.

I will be sending the updated patches shortly. Hope we can use this patch-set as base; and people closely associated with other boards can make necessary changes to move other boards into the choice..endchoice block.

~sanjeev 

> 
> > Regards,
> > Sergio
> > 
> 
> Best regards,
> Sanjeev--
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 