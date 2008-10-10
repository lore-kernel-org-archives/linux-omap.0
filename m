From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH][omapzoom] BRIDGE Add preemption support to unprotected
 functions
Date: Fri, 10 Oct 2008 18:15:47 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E13CE596E@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A5344D13167@dlee03.ent.ti.com>
 <20081009.074617.195054430.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYJJXP6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 19:15:58 -0400
In-Reply-To: <20081009.074617.195054430.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>

Hi Doyu-san,

Thank you for your comments.

> By the way, would it be possible to replace this "sync.c" with normal
> in-kernel APIs like "mutex_lock()" and "wait_event()" families?
> 
> There's no point to have home brewed synchronization APIs, but it may
> lose the readability of the code. If you need to add debug feature to
> kernel synchronization mechanism, it should be done in generic APIs,
> not in the driver specific code.

I agree with you that we would lose the readability and also any changes to the sync module functionality will have an impact on the current Bridge design and might require considerable amount of rework. 

I wouldn't be comfortable removing the sync module completely for above mentioned reasons, but we can look at analyzing and making the changes in a phased manner.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, October 08, 2008 11:46 PM
> To: Ramirez Luna, Omar; Kanigeri, Hari
> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: Re: [PATCH][omapzoom] BRIDGE Add preemption support to
> unprotected functions
> 
> Hi Omar and Hari,
> 
> From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
> Subject: [PATCH][omapzoom] BRIDGE Add preemption support to unprotected
> functions
> Date: Wed, 8 Oct 2008 17:07:15 -0500
> 
> > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > Date: Fri, 3 Oct 2008 12:20:45 -0500
> > Subject: [PATCH] BRIDGE Add preemption support to unprotected functions
> >
> > This patch protects the critical sections in bridge
> > driver that otherwise might end in unexpected behavior.
> 
> Nice catch.
> 
> By the way, would it be possible to replace this "sync.c" with normal
> in-kernel APIs like "mutex_lock()" and "wait_event()" families?
> 
> There's no point to have home brewed synchronization APIs, but it may
> lose the readability of the code. If you need to add debug feature to
> kernel synchronization mechanism, it should be done in generic APIs,
> not in the driver specific code.
> 
>      Hiroshi DOYU
> 
> 

