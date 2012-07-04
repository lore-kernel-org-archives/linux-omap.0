From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 1/3] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses
 omap-device.o target so add one entry
Date: Wed, 4 Jul 2012 09:16:56 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA632CE@DBDE01.ent.ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
 <1340895567-22766-2-git-send-email-hvaibhav@ti.com>
 <20120704072758.GP1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab2GDJSM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:18:12 -0400
In-Reply-To: <20120704072758.GP1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Jul 04, 2012 at 12:57:58, Tony Lindgren wrote:
> Hi
> 
> Applying these, but few comments below to make my life easier..
> 
> * Vaibhav Hiremath <hvaibhav@ti.com> [120628 08:04]:
> > All OMAP2PLUS based devices, builds omap-device.o target;
> > so just add one entry so that there is no need to patch this file
> > for any future OMAP2+ devices.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > 
> > NOTE: No code change from last version.
> 
> Extra comments like this should be within the --- sections so they
> down't show up when applying the patch. Otherwise I have to manually
> edit every patch, which sucks.
> 

Oops...my bad.

These comments I keep deliberately after signoff so that I can move it
after --- section while submitting, but somehow missed to do it for this 
patch-series.
I will take care of it in the future, sorry for inconvenience.


> Then, I'm leaving out the CLEANUP part in $Subject, that alone is not
> a reason to patch anything. The description should say why the patch
> is needed, which it does. If you want to specify that this should be
> grouped in the clean-up branch, then that too could be mentioned within
> the --- sections.
> 

Point taken, and will follow now.

> > ---
> >  arch/arm/plat-omap/Makefile |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> > index 6d87532..961bf85 100644
> > --- a/arch/arm/plat-omap/Makefile
> > +++ b/arch/arm/plat-omap/Makefile
> > @@ -10,9 +10,7 @@ obj-n :=
> >  obj-  :=
> > 
> >  # omap_device support (OMAP2+ only at the moment)
> > -obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> > -obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> > -obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> > +obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
> > 
> >  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
> >  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
> > --
> > 1.7.0.4
> > 
> 
> This patch did not apply for some reason, I got:
> 
> patching file arch/arm/plat-omap/Makefile
> patch: **** malformed patch at line 73: 1.7.0.4
> 
> So please tune up your scripts a bit to the patches can be applied
> as they are without manual editing ;)
> 

Hmmmm...

I usually submit the patch against linux-omap/master (to handle cross 
dependencies), which in some cases fails on other branches you maintain. 
Probably I will make sure that it allies atleast to relevant branches, for 
example, in this case it should be applied on linux-omap/cleanup branch as 
well. 

Thanks,
Vaibhav

