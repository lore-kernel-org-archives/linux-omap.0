From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/10 v1] EHCI and OHCI patches of OMAP3 and OMAP4
Date: Tue, 1 Mar 2011 11:38:47 +0200
Message-ID: <20110301093847.GG2942@legolas.emea.dhcp.ti.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <20110228191143.GT2459@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57039 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753517Ab1CAJix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 04:38:53 -0500
Content-Disposition: inline
In-Reply-To: <20110228191143.GT2459@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gadiyar@ti.com, p-basak2@ti.com, Greg KH <greg@kroah.com>

On Mon, Feb 28, 2011 at 09:11:43PM +0200, Felipe Balbi wrote:
> On Mon, Feb 28, 2011 at 10:01:42PM +0530, Keshava Munegowda wrote:
> > this is how it EHCI/OHCI code re oraganize look like:
> > 	. we have EHCI and OHCI be children of a usbhs "core driver"
> > 		which will take care of all accesses to
> > 		UHH and TLL bases. 
> > 
> > 	. we pass enable/disable functions down from EHCI and OHCI drivers.
> > 		to USBHS driver.
> > 
> > 	. UHH and TLL power management will eventually move to
> > 		omap-usb-host.c
> 
> Anand, I'm not taking this directly. I need a pull request from you in
> order for me to send a pull request to Greg. Bear in mind we have little
> time for this merge window, I'll wait until tomorrow and if I have no
> reply, this won't be going into this merge window. Sorry but I also have
> other MUSB patches which will be waiting until tomorrow due to these
> EHCI/OHCI patches.

@Anand: ping...

-- 
balbi
