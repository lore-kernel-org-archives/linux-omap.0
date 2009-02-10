From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: musb OTG broken in 2.6.29-rc3?
Date: Tue, 10 Feb 2009 10:17:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81B610@dbde02.ent.ti.com>
References: <5e088bd90902090940s3c6de0eqac55e21acd4490bc@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739403FA81B5E5@dbde02.ent.ti.com>
 <5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46578 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbZBJEr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 23:47:26 -0500
In-Reply-To: <5e088bd90902092043u913d35axe658e784d4befb59@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Steve Sakoman [mailto:sakoman@gmail.com]
> Sent: Tuesday, February 10, 2009 10:13 AM
> To: Gupta, Ajay Kumar
> Cc: linux-omap
> Subject: Re: musb OTG broken in 2.6.29-rc3?
> 
> On Mon, Feb 9, 2009 at 8:05 PM, Gupta, Ajay Kumar <ajay.gupta@ti.com> wrote:
> 
> >> Before I spend too much time debugging, has anyone else been
> >> successful with musb OTG in 2.6.29-rc3?  A quick search of this list
> >> didn't turn up any discussion of issues.
> >
> > It works fine on OMAP35x EVM too. I had to add a proc entry for session start
> > (Switching on the vBus).
> 
> Could you give me a little more detail on what you had to do for
> session start?  Perhaps I have a similar issue on Overo.
It is same $ echo "F" >/proc/driver/musb_hdrc, which was earlier
In musb_procfs.c and now been removed.

+       case 'F':
+               reg = musb_readb(mbase, MUSB_DEVCTL);
+               reg |= MUSB_DEVCTL_SESSION;
+               musb_writeb(mbase, MUSB_DEVCTL, reg);

Ajay

> 
> Thanks!
> 
> Steve

