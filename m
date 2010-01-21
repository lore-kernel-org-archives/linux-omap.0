From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP CPU ID: fix OMAP4 build failure
Date: Wed, 20 Jan 2010 20:26:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001202025410.3977@utopia.booyaka.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com> <alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48436 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0AUD0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 22:26:44 -0500
In-Reply-To: <alpine.DEB.2.00.1001202008530.3977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Abhijit,

On Wed, 20 Jan 2010, Paul Walmsley wrote:

> > So now it can be migrated from CHIP_IS_OMAP4430 to CHIP_IS_OMAP4430ES1. 
> > I think CHIP_IS_OMAP4430 would be redundant in that case and should be 
> > removed. A patch would be essential to take care of that in the places 
> > where it is used. If you feel the same I can send a patch for fixing 
> > this.
> 
> In the past, there have been some clock, clockdomain, powerdomain, IP 
> block, etc. changes going from ES1 to ES2 revisions.  But most clocks, 
> etc. stay the same.  So it seems best to keep the actual CHIP_IS_* bits 
> ES-level sensitive, then define a rollup macro like CHIP_IS_OMAP4430 for 
> what stays the same.  Until ES2 details are available, this shouldn't 
> require any further changes to the codebase aside from id.c.

I guess the rollup should probably be CHIP_IS_OMAP44XX.  Do you happen to 
know whether software will be able to discriminate between 4430 and 4440 
chips at run-time, and if so, what mechanism to use?


- Paul
