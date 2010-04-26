From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] usb: Fix tusb6010 for DMA API (Re: [patch-2.6.34-rc2+
 00/11] musb patches (v2))
Date: Mon, 26 Apr 2010 09:29:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322986A97@dbde02.ent.ti.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <20100423210854.GA13366@kroah.com> <20100423212307.GY18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54413 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab0DZD7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Apr 2010 23:59:43 -0400
In-Reply-To: <20100423212307.GY18272@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> * Greg KH <greg@kroah.com> [100423 14:05]:
> > On Thu, Mar 25, 2010 at 01:14:22PM +0200, Felipe Balbi wrote:
> > > Hi Greg,
> > > 
> > > sorry for the last time. There was a bug in my script
> > > which caused it to rebased against the wrong branch.
> > 
> > All queued up, thanks
> 
> This compile fix still needs to be queued too. Can also
> merge via omap tree if you guys ack.

Probably a good idea to mention in the changelog that you are
also musb_platform_{save,restore}_context for TUSB.

Other than that, looks good.

- Anand
