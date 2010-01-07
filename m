From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
 related update.
Date: Thu, 7 Jan 2010 10:15:16 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C041BF11@dbde02.ent.ti.com>
References: <1261583238-22187-1-git-send-email-abhijitpagare@ti.com>
 <alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001051608340.21295@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C041BB3A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001061401560.10034@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab0AGEpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 23:45:31 -0500
In-Reply-To: <alpine.DEB.2.00.1001061401560.10034@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Hello Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, January 07, 2010 2:40 AM
> To: Pagare, Abhijit
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
> related update.
> 
> Hello Abhijit,
> 
> On Wed, 6 Jan 2010, Pagare, Abhijit wrote:
> 
> > I checked the dependency patch-set. The complete stuff looks really
> > neat. Applying OMAP4 on top of this would be feasible. The only thing is
> > that till the point the OMAP4 dependency patches go in the "autodeps"
> > variable in arch/arm/clockdomain.c would not be initialized which will
> > cause a kernel boot-crash for the functions _clkdm_add_autodeps(clkdm)
> > and _clkdm_del_autodeps(clkdm). Hence the hack patch referred to in the
> > subject above is essential. Should I re-post it with the missing FIXME
> > indication that you had recommended?
> 
> My concern is that we don't want to forget about the OMAP4 sleep and
> wakeup dependencies.  How long do you think it will take to add them?

It shouldn't take all that long. I will internally send you the auto-generated file having the dependency details soon. Do let me know if you want any modification in it. If all that's done in a couple of days then the patch above can be skipped.

Regards,
Abhijit

> 
> 
> - Paul
