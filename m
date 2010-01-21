From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP CPU ID: fix OMAP4 build failure
Date: Wed, 20 Jan 2010 20:20:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58963 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0AUDU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 22:20:29 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Abhijit,

On Wed, 20 Jan 2010, Pagare, Abhijit wrote:

> I think the latest patch-set that I had posted has this change in it. 
> You can refer to the patch in the link below
> 
> http://marc.info/?l=linux-omap&m=126088474831309&w=2

Looks like this patch had somehow not made it into the for_2.6.34 branch; 
this has now been fixed, which resolves the problem.  But this part we 
should discuss further:

> I had used this flag earlier as there was nothing fixed as to name it as 
> ES1 that time.

Yep, I understand.

> So now it can be migrated from CHIP_IS_OMAP4430 to CHIP_IS_OMAP4430ES1. 
> I think CHIP_IS_OMAP4430 would be redundant in that case and should be 
> removed. A patch would be essential to take care of that in the places 
> where it is used. If you feel the same I can send a patch for fixing 
> this.

In the past, there have been some clock, clockdomain, powerdomain, IP 
block, etc. changes going from ES1 to ES2 revisions.  But most clocks, 
etc. stay the same.  So it seems best to keep the actual CHIP_IS_* bits 
ES-level sensitive, then define a rollup macro like CHIP_IS_OMAP4430 for 
what stays the same.  Until ES2 details are available, this shouldn't 
require any further changes to the codebase aside from id.c.

We don't currently define a rollup macro for CHIP_IS_OMAP3430, but it's 
planned for 2.6.34 to include all of the individual CHIP_IS_OMAP* bits.  
We'd do the same thing for OMAP2xxx but most of the 2xxx data in the 
kernel tree has no ES-level information, so we'll probably leave those 
as-is.  We'll probably add in a Sitara CHIP_IS_* bit in there also.

Anyway, there's no need for you to change your patch, now that it's 
included in the for_2.6.34 branch.  But keep in mind that we'll probably 
post another id.c cleanup patch to change things around as described 
above, unless you or others have some strong reason not to...


- Paul
