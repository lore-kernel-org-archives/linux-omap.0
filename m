From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
Date: Tue, 23 Feb 2010 11:12:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C42E1069@dbde02.ent.ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C417FA42@dbde02.ent.ti.com>
 <20100222213932.GW18786@atomide.com> <20100222230712.GB18786@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab0BWFm2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 00:42:28 -0500
In-Reply-To: <20100222230712.GB18786@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>

Thanks Tony
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, February 23, 2010 4:37 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Woodruff, Richard; Ghorai,
> Sukumar
> Subject: Re: [PATCH 1/9] omap3/4: uart: fix full-fifo write abort
> 
> * Tony Lindgren <tony@atomide.com> [100222 13:35]:
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100218 21:22]:
> > > Bye the way just to add bit more clarity, this patch addresses TX
> > > hardware restriction in the new UART IP used on omap3630 and omap4430.
> > > First part of the fix for RX is already in mainline,
> > > Commit: "ce13d4716a276f4331d78ba28a5093a63822ab95"
> > >
> > > More details on this thread are here.
> > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19447.html
> >
> > Thanks, I've updated the comments for this patch with the link above
> > and added the whole series into omap for-next.
> 
> Except patches 8 and 9 as they break compile for mach-omap1
> and need to be updated.

I will check these two patches tony and also boot test the OMAP1.

Regards,
Santosh
