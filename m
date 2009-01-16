From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 14:31:00 -0800
Message-ID: <200901161431.00469.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <200901161327.52661.david-b@pacbell.net> <20090116221920.GC8189@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44622 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1763982AbZAPWbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 17:31:03 -0500
In-Reply-To: <20090116221920.GC8189@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 16 January 2009, Felipe Balbi wrote:
> On Fri, Jan 16, 2009 at 01:27:52PM -0800, David Brownell wrote:
> > So why not just enable PM=y in the configuration?  It's not
> > actually required to do much, beyond not being broken.
> 
> That patch would have to go through tony
> 
> arch/arm/plat-omap/include/mach/pm.h:
> 
> #if     !defined(CONFIG_ARCH_OMAP730) && \
> 	!defined(CONFIG_ARCH_OMAP15XX) && \
> 	!defined(CONFIG_ARCH_OMAP16XX) && \
> 	!defined(CONFIG_ARCH_OMAP24XX) && \
> 	!defined(CONFIG_ARCH_OMAP34XX)
> #error "Power management for this processor not implemented yet"
> #endif

I didn't realize anyone outside of TI had their hands
on OMAP4 chips yet.  :)

