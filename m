From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Mon, 25 Aug 2008 10:10:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31AD6@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com>
 <20080805104643.GP7193@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com>
 <20080823232238.GL4713@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33378 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbYHYErE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 00:47:04 -0400
In-Reply-To: <20080823232238.GL4713@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>
> > > 
> > > These should be sent via linux-usb list, please also Cc 
> > > linux-omap list.
> > > 
> > > Thanks,
> > > 
> > > Tony
> > 
> > 
> > Er Tony, the bus glue for OMAP is not present upstream. This patch fixes
> > something in that bus glue code, which currently exists only in your tree.
> > Care to push this to your tree for now?
> > 
> > I'll get the ehci-omap code in better shape and submit separately to the
> > linux-usb list.
> 
> Well we should really sync all usb code with mainline now that musb is
> merged. Can you repost patches against mainline for linux-usb? I can
> then reset drivers/usb to be in sync with mainline and we can move
> all USB related discussion to linux-usb.
> 
> Tony

Okay. I'll add that to my to-do queue.

-Anand