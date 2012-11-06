From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
Date: Tue, 6 Nov 2012 13:46:58 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC05260@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
 <509543E8.60209@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC00B9B@DBDE01.ent.ti.com>
 <5098D889.60909@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC049E4@DBDE01.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A83EB64336@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54562 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab2KFNrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 08:47:03 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB64336@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Tue, Nov 06, 2012 at 18:38:08, Hiremath, Vaibhav wrote:
> On Tue, Nov 06, 2012 at 15:39:14, Bedia, Vaibhav wrote:
> > On Tue, Nov 06, 2012 at 14:59:45, Hiremath, Vaibhav wrote:
> > [...]
> > > > 
> > > > Ok I checked this one. The change I made was indirectly fixing another
> > > > issue with the AM33xx hwmod data. am33xx_cpgmac0_addr_space[] has two
> > > > entries and the SYSC register is part of the second entry. The function
> > > > _find_mpu_rt_addr_space in omap_hwmod.c looks for the first entry with
> > > > the flag ADDR_TYPE_RT flag. The change I made indirectly made the second
> > > > entry in am33xx_cpgmac0_addr_space[] become the first memory space with
> > > > the ADDR_TYPE_RT flag. Due to this the hwmod code wrote to the correct
> > > > SYSC address of CPGMAC0 and the IP went to standby during bootup. 
> > > > After changing the order of the entries in am33xx_cpgmac0_addr_space[]
> > > > things work fine.
> > > > 
> > > 
> > > Good catch.
> > > 
> > > Just a side note on this, driver expects the addresses in this order
> > > only, first SS and then WR.
> > > 
> > 
> > Sorry I didn't understand your comment. For HWMOD code to work as expected,
> > we need to change the order. 
> 
> Why do you want to change the order? Just specify "ADDR_TYPE_RT", that 
> should be it.
> 

The problem is that the memory space without the SYSC comes first and is labeled
as ADDR_TYPE_RT. I think this is not correct and hence either we change the order
or remove the flag from the first entry. If we do the latter then taking the logic
of putting in the flag only for memory spaces with SYSC further we need to fixup
the entries for ephrpwm0/1/2 and ecap0/1/2.

Regards,
Vaibhav 
