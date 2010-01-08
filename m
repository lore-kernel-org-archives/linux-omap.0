From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV4 3/4] OMAP3: Introduce 3630 DPLL4 HSDivider changes
Date: Fri, 8 Jan 2010 16:24:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001081619390.28650@utopia.booyaka.com>
References: <1262849801-9955-1-git-send-email-vishwanath.bs@ti.com> <1262849801-9955-2-git-send-email-vishwanath.bs@ti.com> <1262849801-9955-3-git-send-email-vishwanath.bs@ti.com> <1262849801-9955-4-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.1001071106150.10034@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC3560870300519BD9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53738 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab0AHXYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 18:24:08 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870300519BD9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Vishwanath,

On Fri, 8 Jan 2010, Sripathy, Vishwanath wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > On Thu, 7 Jan 2010, Vishwanath BS wrote:
> > >
> > > +static struct clk dpll4_ck_3630 __initdata = {
> > 
> > Marking these as __initdata will crash the system for DVFS changes after
> > the kernel boots.  Please fix.
> 
> Sorry I did not understand why it should crash the system for DVFS? 
> dpll4_ck_3630 is not used anywhere after it's values are copied into 
> dpll4_ck as part of clock_init. Same is the case with others.

Sorry, you're right - your code copies the entire structure and not just 
the pointer. 


- Paul
