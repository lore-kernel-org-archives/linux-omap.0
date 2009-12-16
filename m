From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [v2 PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support OMAP4
 features.
Date: Wed, 16 Dec 2009 10:41:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFB57DB8@dbde02.ent.ti.com>
References: <1260885177-25665-1-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-2-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-3-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-4-git-send-email-abhijitpagare@ti.com>
 <1260885177-25665-5-git-send-email-abhijitpagare@ti.com>
 <alpine.DEB.2.00.0912150950050.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbZLPFLd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 00:11:33 -0500
In-Reply-To: <alpine.DEB.2.00.0912150950050.12561@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, December 15, 2009 10:23 PM
> To: Pagare, Abhijit
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Cousson, Benoit; Nayak, Rajendra
> Subject: Re: [v2 PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support
> OMAP4 features.
> 
> Hi Abhijit,
> 
> just FYI, on this patch:
> 
> On Tue, 15 Dec 2009, Abhijit Pagare wrote:
> 
> > Port the APIs to support the OMAP4 clockdomain framework.
> > Also take care of the compiling requirements for the same.
> 
> ...
> 
> > diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-
> omap2/clockdomain.c
> > index 5366a10..f768d37 100644
> > --- a/arch/arm/mach-omap2/clockdomain.c
> > +++ b/arch/arm/mach-omap2/clockdomain.c
> > @@ -1,10 +1,11 @@
> >  /*
> > - * OMAP2/3 clockdomain framework functions
> > + * OMAP2/3/4 clockdomain framework functions
> >   *
> >   * Copyright (C) 2008 Texas Instruments, Inc.
> >   * Copyright (C) 2008-2009 Nokia Corporation
> >   *
> >   * Written by Paul Walmsley and Jouni H????gander
> 
> ... looks like something mangled the UTF-8 which causes this patch to
> not apply cleanly.  Fixed this up by hand.

It's fine. Thanks..!

> 
> 
> - Paul

Regards,
Abhijit
