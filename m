From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] arm: omap4: add USBHOST and related base
 addresses
Date: Tue, 30 Nov 2010 10:41:23 -0800
Message-ID: <20101130184123.GU17222@atomide.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
 <1290364814-4417-6-git-send-email-gadiyar@ti.com>
 <1290364814-4417-7-git-send-email-gadiyar@ti.com>
 <1290364814-4417-8-git-send-email-gadiyar@ti.com>
 <20101122102446.GR2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56693 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab0K3Sla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 13:41:30 -0500
Content-Disposition: inline
In-Reply-To: <20101122102446.GR2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@suse.de>

* Felipe Balbi <balbi@ti.com> [101122 02:15]:
> On Mon, Nov 22, 2010 at 12:10:10AM +0530, Anand Gadiyar wrote:
> >Add base addresses for USBHOST, USBTLL, EHCI and OHCI to
> >the header file.
> >
> >This will disappear when the drivers are converted to use
> >the hwmod database, however this patch is needed until then.
> >
> >Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> 
> Tony, I need an Ack here again :-p

Acked-by: Tony Lindgren <tony@atomide.com>
