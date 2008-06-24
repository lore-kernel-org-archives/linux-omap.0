From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/4] usb: musb: musb on omap3 has 32 endpoints
Date: Tue, 24 Jun 2008 11:15:29 +0300
Message-ID: <20080624081528.GG5257@kedavra.cpe.vivax.com.br>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com> <20080623111009.GM7741@atomide.com> <20080623111455.GH4414@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BE46969@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46098 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYFXIP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 04:15:27 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46969@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jun 24, 2008 at 09:52:05AM +0530, Gadiyar, Anand wrote:
> > > > Fix hdrc_cnf.h for omap3 configuration.
> > >
> > > Does this break the configuration for omap2?
> > >
> > > We should set these dynamically if different for omap2 and omap3
> > > so we can compile both into the same kernel.
> >
> > Should check omap2430 trm to be sure, maybe someone in TI
> > could help us with it ?
> 
> It won't break the 2430. The 2430 has 32 endpoints as well.

Good.

> > Maybe we could bring it via platform_data as well?
> 
> Yep. That would be good.

Cool, I'll start doing it.

Tony, maybe is safe to push this one so we can use all 32 endpoints ?

Meanwhile I'll create a way for different boards to tell musb driver its
configuration details.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
