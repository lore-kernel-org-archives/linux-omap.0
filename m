From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Fri, 14 May 2010 08:43:43 -0700
Message-ID: <20100514154343.GX3428@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
 <20100505150209.GC2606@n2100.arm.linux.org.uk>
 <20100513174023.GB13001@n2100.arm.linux.org.uk>
 <20100513211951.GH3428@atomide.com>
 <20100513215825.GC13001@n2100.arm.linux.org.uk>
 <20100513220139.GO3428@atomide.com>
 <20100513221229.GD13001@n2100.arm.linux.org.uk>
 <20100514152208.GU3428@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C558B316@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65374 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0ENPn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:43:56 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C558B316@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100514 08:28]:
> > 
> > Yeah, that missing patch was it. Compiles and boots now:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Did you get the frame buffer with lmb ??

I've never gotten a DSS2 frame buffer yet with the code that's
in omap for-next, but I believe Tomi has the missing pieces queued up.

My tested-by was for the patch not breaking the current behaviour,
basically to make sure things boot. So since it's really half
tested, maybe acked-by would be more suitable.

Regards,

Tony
