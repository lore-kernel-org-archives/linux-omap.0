From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 12:36:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211221226360.2255-100000@netrider.rowland.org>
References: <20121122135603.GA20066@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:34638 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754182Ab2KVSgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 13:36:45 -0500
In-Reply-To: <20121122135603.GA20066@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 22 Nov 2012, Felipe Balbi wrote:

> > If you mean change the regulator managing code from living in
> > omap-hsusb to ehci-hcd, it sounds like a good idea.
> 
> I mean that drivers/usb/core/hub.c should manage it, since that's what
> actually manages the HUB entity.

This is an interesting problem.  How should we handle devices which
live on a discoverable bus but whose power is controlled by an
undiscoverable platform-specific regulator?

Has this sort of thing come up in the past with other types of devices?

A big part of the problem is associating the hub, which is created
dynamically by the USB core code, with the regulator, which is known
from platform data at boot time.  The suggestion that the regulator
should really be associated with a port on the hub's parent is
reasonable at first glance.  But what if we don't know which port that
is?

Once we can solve this part of the problem, I think the rest of it will 
fall into place.

> as long as Alan is ok and it comes in the same series, I'd be really,
> really glad to see such a patch and would happily review it.

If we can figure out a good way to set up the necessary association, I
won't mind adding the appropriate calls to the USB core.  But is the
hub driver the right place?  What if a similar power arrangement is
used for a different kind of USB-connected chip (for example, a webcam
or a fingerprint reader)?

Alan Stern

