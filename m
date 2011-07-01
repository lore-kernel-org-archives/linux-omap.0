From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 10:43:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011040570.1988-100000@iolanthe.rowland.org>
References: <87k4c3dktm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54553 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756689Ab1GAOne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 10:43:34 -0400
In-Reply-To: <87k4c3dktm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 30 Jun 2011, Kevin Hilman wrote:

> Another curiosity is that, contrary to the above documentation, there is
> no usage_count increment before the bus/driver ->remove() (although
> there is a _get_sync/_put_sync around the sysfs_remove and notifier just
> before the bus/driver->remove().

I hadn't noticed that.  There may be a reason for using get_sync 
instead of get_noresume, but it isn't explained anywhere.  And it 
certainly looks like a mistake for the put_sync to occur before the 
->remove() call instead of after.

This needs to be fixed.

Alan Stern

