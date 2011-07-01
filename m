From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 10:54:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011045160.1988-100000@iolanthe.rowland.org>
References: <87vcvmaml6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58826 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756662Ab1GAOyG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 10:54:06 -0400
In-Reply-To: <87vcvmaml6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 30 Jun 2011, Kevin Hilman wrote:

> I'm still confused about the usage_count increment around ->probe
> though.

As a few people have already pointed out, some subsystems do perform 
runtime PM on driverless devices.

The basic idea is simple: We don't want any PM callbacks to race with
each other or with other driver-core callbacks.  Incrementing the
usage_count prevents runtime_suspend callbacks while the probe callback
is running.

This does leave open the possibility of runtime_resume occurring 
concurrently with probe.  For the most part this should be okay 
because without a driver, no part of the kernel will try to resume the 
device.

Hmmm, but a resume could occur as a result of userspace writing to a 
sysfs attribute.  It looks like we need to add some lock_device() calls 
to control_store() and autosuspend_delay_ms_store().

Alan Stern

