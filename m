From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 1/1] Registering sgx device and it's platform data
Date: Wed, 31 Mar 2010 03:39:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1003310330470.14436@utopia.booyaka.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBF372@dbde02.ent.ti.com> <alpine.DEB.2.00.1003300218100.14474@utopia.booyaka.com> <20100330094902.GG30597@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44252 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933110Ab0CaJjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 05:39:40 -0400
In-Reply-To: <20100330094902.GG30597@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "Agarwal, Preshit" <preshit.agarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>

Hi Felipe,

On Tue, 30 Mar 2010, Felipe Balbi wrote:

> On Tue, Mar 30, 2010 at 10:49:19AM +0200, ext Paul Walmsley wrote:
> > I would suggest that you name this function be named something more
> > specific, such as omap_sgx_set_bus_tput(), since the SGX driver may also
> > need to set other PM constraints later, such as wakeup latency
> > constraints.
> 
> then it could just add the contraints to the same function instead of passing
> another pointer to driver ??

It's hard to say without looking at the driver.  

Bus throughput constraints are only needed when the device is actively 
transferring data to/from the rest of the system.

Wakeup latency constraints are only needed when the device can go idle and 
enter some low-power state, but also needs to be ready in some limited 
amount of time to service an interrupt or a wakeup.

So, often it would make sense to set the two parameters at different 
points in the driver code.


- Paul
