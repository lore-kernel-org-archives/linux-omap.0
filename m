From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Fri, 8 May 2009 12:27:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B476B68B@dbde02.ent.ti.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
 <04c801c9cfa0$4563dfa0$LocalHost@wipultra793>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B4688490@dbde02.ent.ti.com>
 <001801c9cfa4$0cf99840$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38451 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbZEHG5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 02:57:44 -0400
In-Reply-To: <001801c9cfa4$0cf99840$LocalHost@wipultra793>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> Subject: RE: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
> 
> 
> > -----Original Message-----
> > From: V, Hemanth
> > Sent: Friday, May 08, 2009 11:16 AM
> > To: Shilimkar, Santosh; linux-arm-kernel@lists.arm.linux.org.uk
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
> >
>
> >>U-boot has no knowledge of secondary CPUs. Kernel takes 
> care of it with 
> >>help of ROM code.
> 
> For my information could you pl point to the routine which 
> does this, i.e 
> enable instruction cache on the secondary cpu. 
This is done using __enable_mmu in head.S. Bye the way even if the u-boot don't enable I-cache , D-caches, kernel does that anyways depending on settings.