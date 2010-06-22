From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Tue, 22 Jun 2010 09:08:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032358EE5A@dbde02.ent.ti.com>
References: <1277151798-26232-1-git-send-email-tarun.kanti@ti.com>
 <8739wg2xg7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33199 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab0FVDiq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 23:38:46 -0400
In-Reply-To: <8739wg2xg7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, June 21, 2010 9:24 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; R, Sricharan
> Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Generation of 1ms granular GPTIMER events using 32KHz or system
> > clocks as inputs does not have whole number count value to load
> > into the register. This inaccurate count value with respect to 1ms
> > period leads to time drift subsequently. OMAP3 and later silicons
> > have dedicated registers for GPTIMER1, GPTIMER2 and GPTIMER10,
> > which can be programmed with computed values to keep this error
> > controlled within specified limit.
> >
> > Version 2:
> > (i) optimized omap_dm_timer_ms_correction() function and corrected
> > error in computing the positive and negative increments.
> > (ii) typo corrections in comment section and warning removal related
> > to 80-character limit
> >
> > Tested on Zoom3 using Linus tree.
> >
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> Please coordinate this change with the GPTIMER hwmod changes.  The timers
> that have/need this feature should be flagged at the hwmod level (probably
> by
> a dev_attr flag.)


OK!

> 
> Kevin
