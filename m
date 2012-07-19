From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention
 issue
Date: Thu, 19 Jul 2012 11:15:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1207191113440.1764-100000@iolanthe.rowland.org>
References: <20120719102013.GJ14302@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44006 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751516Ab2GSPPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 11:15:16 -0400
In-Reply-To: <20120719102013.GJ14302@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, khilman@ti.com, sameo@linux.intel.com, notasas@gmail.com, Greg KH <gregkh@linuxfoundation.org>

On Thu, 19 Jul 2012, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Jun 21, 2012 at 07:12:12PM +0530, Keshava Munegowda wrote:
> > This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
> > "Fix OMAP EHCI suspend/resume failure (i693)" is causing
> > the usb hub and device detection fails in beagle XM
> > causeing NFS not functional. This affects the core retention too.
> > The same commit logic needs to be revisted adhering to hwmod and
> > device tree framework.
> > for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aac
> > titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
> > 
> > This patch is validated on BeagleXM with NFS support over
> > usb ethernet and USB mass storage and other device detection.
> > 
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> turns out this is causing other issues and another version of the patch
> will be provided.
> 
> Greg, Alan, this is basically a git revert of the commit id listed
> above.

I have no objection to reverting the patch.  But on a related note,
have you had a chance to read my comment:

	http://marc.info/?l=linux-usb&m=134098423528415&w=2

?

Alan Stern


