From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] OMAP: DSS2: DSI: IRQ restructuring
Date: Wed, 9 Mar 2011 16:45:10 +0200
Message-ID: <1299681910.2151.98.camel@deskari>
References: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
	 <4D77868A.7020700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243Ab1CIOpO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 09:45:14 -0500
In-Reply-To: <4D77868A.7020700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, 2011-03-09 at 07:54 -0600, Taneja, Archit wrote:
> On Wednesday 09 March 2011 12:51 PM, Valkeinen, Tomi wrote:
> > Hi,
> >
> > In the future we will have more features using the DSI interrupts, like ULPS
> > handling, and making use-case specific hooks into the main IRQ handler would
> > become burdensome.
> >
> > This patch set cleans up the DSI IRQ handling a bit by implementing a generic
> > way to register/unregister interrupt service routines. This allows us to remove
> > the use-case specific callbacks from the main IRQ handler.
> >
> 
> Would this make it more easy/difficult to migrate to irq_chip(if needed) 
> later on? I guess it will atleast bring dispc and dsi irq 
> requesting/handling in a similar state, hence the changes needed to move 
> to irq_chip would be the same for both.

Well, I'm not really familiar with irq_chip, but I don't see how this
could make it more difficult. It divides the code in cleaner way,
removing irq specific callbacks in the irq handler, so it should make
migrating easier, if anything.

 Tomi


