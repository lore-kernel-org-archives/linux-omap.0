From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RESEND PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate
 class
Date: Tue, 10 Jul 2012 08:38:35 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA699EE@DBDE01.ent.ti.com>
References: <1341320447-18918-1-git-send-email-hvaibhav@ti.com>
 <1341320447-18918-2-git-send-email-hvaibhav@ti.com>
 <20120704072454.GO1122@atomide.com> <20120704081546.GR1122@atomide.com>
 <20120705152743.GG1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab2GJIit convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 04:38:49 -0400
In-Reply-To: <20120705152743.GG1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Jul 05, 2012 at 20:57:43, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120704 01:20]:
> > * Tony Lindgren <tony@atomide.com> [120704 00:29]:
> > > * Vaibhav Hiremath <hvaibhav@ti.com> [120703 06:12]:
> > > > Initially, we decided to make am33xx family of device to fall
> > > > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > > > Cortex-A8 core. But while adding complete baseport support
> > > > (like, clock, power and hwmod) support, it is observed that,
> > > > we are creating more and more problems by treating am33xx device
> > > > as omap3 family, as nothing matches between them
> > > > (except cortex-A8 mpu).
> > > > 
> > > > So,  after long discussion we have came to the conclusion that,
> > > > we should not consider am33xx device as omap3 family, instead
> > > > create separate class (SOC_AM33XX) under OMAP2PLUS.
> > > > This means, for am33xx device, cpu_is_omap34xx() will return false,
> > > > and only cpu_is_am33xx() will be true.
> > > 
> > > Thanks applying both.
> > 
> > I believe all your patches are now applied. I've pushed them out
> > into devel-am33xx-part2 branch. Can you please check and send
> > additional patches as needed?
> 
> I ended up moving some patches into cleanup-part2 branch as omap5
> patches also need those. So the new branch for am33xx is called
> devel-am33xx-data at commit 79ab2664. The old devel-am33xx-part2
> branch should be ignored now.
> 

Tony,

Can we clean these branches; it is very confusing to track with so many 
multiple versions?

Also, One patch still has not merged is,

[PATCH-V2] ARM: OMAP: cpu: Make cpu_class_is_omap2 true for all non-omap1 platforms

Do you have any comments on this? If not, can you merge it?

Thanks,
Vaibhav

