From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Question on OTG transceivers
Date: Thu, 18 Mar 2010 08:58:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FB2A2@dbde02.ent.ti.com>
References: <4BA14B06.8050202@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43032 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab0CRD3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 23:29:04 -0400
In-Reply-To: <4BA14B06.8050202@billgatliff.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bill Gatliff
> Sent: Thursday, March 18, 2010 3:05 AM
> To: linux-omap@vger.kernel.org
> Subject: Question on OTG transceivers
> 
> Guys:
> 
> 
> I have a Beagleboard-like unit here that uses two SMSC USB3320C-EZK
> PHYs: one for EHCI (usb1), the other for OTG (usb0).
> 
> Two questions.  First, the code in drivers/usb/otg/ulpi.c looks like it
> might be what I need (my attempts so far with the "nop" transceiver have
> ended in failure).  Am I right?
> 

Actually, the way the ehci-omap driver is currently written, it assumes
the transceiver is present and available - you don't need a separate
driver to access it.

For that matter, the same probably holds for the OTG driver as well - you
really don't need a driver for transparent transceivers like the SMSC332x.

I'm not sure why the code was written this way to introduce NOP XCEIVs
(need to go through the changelog to find out why, maybe).

> Second, it looks like otg_set_transceiver() assumes there is only one
> transceiver in the system.  On a device like the OMAP3530 with multiple
> ports, this seems like an odd assumption--- and one that clearly isn't
> accurate for my platform.  Or am I paying attention to the wrong stuff?
> 
> Can anyone help navigate me through the trees in this forest?  :)

I think this assumption comes from some part of the OTG spec which says
that OTG devices can have only one external USB port.

But embedded devices can certainly have more than one transceiver (for example
to connect an on-board USB device without exposing an external port) - so
maybe there's no point keeping this restriction any more.


- Anand