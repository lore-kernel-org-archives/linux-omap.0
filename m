From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
Date: Wed, 17 Feb 2010 12:55:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF840A@dbde02.ent.ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1002161506030.10478@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF826A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1002162218540.10478@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF831B@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF8335@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1002162342290.1116@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab0BQHZY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 02:25:24 -0500
In-Reply-To: <alpine.DEB.2.00.1002162342290.1116@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, February 17, 2010 12:15 PM
> To: Shilimkar, Santosh
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com;
> lrg@slimlogic.co.uk; Cousson, Benoit
> Subject: RE: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
> 
> Hello Santosh,
> 
> On Wed, 17 Feb 2010, Shilimkar, Santosh wrote:
> 
> > Having said that, I think it's best time to changes this so that
> > the drivers getting up streamed can use correct names directly.
> >
> > Also irqs-44xx.h header inclusion can be avoided in each driver if plat/irqs.h
> > include it.
> >
> > I can check this if this can go in the currunt series itself. At least USB
> > and MCPDM are the two drivers I know of, planned to be lined up which will
> > get affected.
> >
> > How about doing this in the .34-rc1 so that we don't break anybody ?
> 
> How about just submitting the auto-generated IRQ file, convert the
> existing in-tree users, and leave the old macros there and mark them
> deprecated with a comment?  Then for the next release, submit a patch to
> change the newly-merged users and remove the deprecated macros?
Sounds ok if we can keep both exist for some time. Will do this.
