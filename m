From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Thu, 10 May 2012 18:18:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA21788@DBDE01.ent.ti.com>
References: <1336562667-6741-1-git-send-email-hvaibhav@ti.com>
 <20120509185435.GU5088@atomide.com> <20120510180159.GF21851@atomide.com>
 <20120510180535.GG21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760998Ab2EJSSa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:18:30 -0400
In-Reply-To: <20120510180535.GG21851@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thu, May 10, 2012 at 23:35:36, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120510 11:06]:
> > * Tony Lindgren <tony@atomide.com> [120509 11:58]:
> > > * Vaibhav Hiremath <hvaibhav@ti.com> [120509 04:28]:
> > > > Initially, we decided to make am33xx family of device to fall
> > > > under omap3 class (cpu_is_omap34xx() = true), since it carries
> > > > Cortex-A8 core. But while adding complete baseport support
> > > > (like, clock, power and hwmod) support, it is observed that,
> > > > we are creating more and more problems by treating am33xx device
> > > > as omap3 family, as nothing matches between them
> > > > (except cortex-A8 mpu).
> > > 
> > > Thanks applying into devel-soc after updating for soc_is change
> > > and fixing typo in the description that stil said OMAPAM. Updated
> > > patch below.
> > 
> > Turns out we still need to add defined(CONFIG_SOC_AM33XX) around
> > __omap2_set_globals() to keep compile working when omap4 + am33xx
> > are selected without omap2 or 3. Also removed the "default y"
> > for am33xx as that's where we're heading to anyways.
> > 
> > Updated patch below.
> 
> Argh, now it breaks with:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap2_set_globals_am33xx':
> twl-common.c:(.init.text+0x1dd8): undefined reference to `omap2_set_globals_sdrc'
> 
> There are clearly some dependencies to the clean up patches being
> discussed.. So I'll drop this for now until the clean up is sorted
> out.
> 

All cleanup patches which I have posted should resolve these issues.
Do you see any issues with them? 

ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add
one entry
ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to dpll3xxx.c
ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around
    __omap2_set_globals


You can only drop last patch, on which Kevin had commented, rest all should 
be merged.

ARM: OMAP2+: CLEANUP: Add new config option for different DPLL
    Features


Please let me know if I am missing something.

Thanks,
Vaibhav
