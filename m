From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Allow late mdesc detection, v3
Date: Tue, 3 Aug 2010 15:56:52 +0300
Message-ID: <20100803125652.GA5450@atomide.com>
References: <20100731092522.GD23886@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C6381053@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56727 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0HCM4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 08:56:42 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6381053@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100731 15:38]:
> Jeremy,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> > Sent: Saturday, July 31, 2010 2:55 PM
> > To: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org; Tony
> > Lindgren
> > Subject: Fwd: [PATCH 0/3] Allow late mdesc detection, v3
> > 
> > Forwarding for OMAP people - as there's outstanding questions about this
> > change for their platforms.
> > 
> > ----- Forwarded message from Jeremy Kerr <jeremy.kerr@canonical.com> -----
> > 
> > Date: Fri, 30 Jul 2010 17:22:11 +0800
> > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > To: linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH 0/3] Allow late mdesc detection, v3
> > Delivery-date: Sat, 31 Jul 2010 01:25:58 +0100
> > 
> > Hi all,
> > 
> > Currently, we probe for a mdesc early in boot. At this early stage, the
> > only thing we use the mdesc for is to determine the debug page mapping.
> > 
> > However, the debug addresses (phys and virt) need to be coded into the
> > addruart macro anyway; the dynamic probing is only going to tell us what
> > we already know.
> > 
> > These changes allow us to use the addruart macros to find the debug
> > mapping addresses, rather than pulling them out of the mdesc. This means
> > that the addresses are only kept in the one place, and that we don't
> > need the mdesc nearly as early.
> > 
> > The first change updates all of the addruart macros to return both
> > physical and virtual addresses. I've used 'rp' and 'rv' as the macro
> > arguments to indicate which address goes where
> > 
> > The second change updates the debug setup routine to use the addruart
> > macro to establish the debug mapping, now that we can invoke the macro
> > to find the phyical and virtual addresses.
> > 
> > This allows us to delay the requirement to have a mdesc available until
> > much later. For example, we can parse one from the device tree once
> > we've reached C code.
> > 
> > May break OMAP1/2, as the addruart macros are more complex on these
> > platforms. I'd appreciate input from OMAP folks who may well tell me
> > that this isn't possible.
> > 
> Just tried this on OMAP4, and indeed it breaks OMAP2PLUS low level debug
> support.
> 
> Tony recently revamped the complete debug code, so that we can dynamically
> set correct debug port based on machine ID passed by boot-loaders. Based
> on this , the debug code determines the the correct debug port based on
> this using a scratch pad register.
> 
> Tony can comment better on this issue.

Looks like the fix suggested by Jason Wang <jason77.wang@gmail.com>
is needed to make the mdesc series to work on omaps. An updated
version for the mdesc series is here:

http://marc.info/?l=linux-arm-kernel&m=128083927030188&w=2

So with the patch at the link above, the mdesc series

Tested-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
