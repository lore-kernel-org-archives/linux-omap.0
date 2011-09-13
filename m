From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
 include interconnect barriers.
Date: Tue, 13 Sep 2011 13:27:01 -0700
Message-ID: <20110913202701.GF24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53970 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932470Ab1IMU1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 16:27:04 -0400
Content-Disposition: inline
In-Reply-To: <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Richard Woodruff <r-woodruff2@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
> On OMAP4 SOC intecronnects has many write buffers in the async bridges
> and they can be drained only with stongly ordered accesses.

This is not correct, strongly ordered access does not guarantee
anything here. If it fixes issues, it's because it makes the writes
to reach the device faster. Strongly ordered does not affect anything
outside ARM, so the bus access won't change.

The only real fix here is to do a read back of the device in question
to guarantee the write got to the device.
 
> There are two ports as below from MPU and both needs to be drained.
> 	- MPU --> L3 T2ASYNC FIFO
> 	- MPU --> DDR T2ASYNC FIFO
> 
> Without the interconnect barriers, many issues have been observed
> leading to system freeze, CPU deadlocks, random crashes with
> register accesses, synchronization loss on initiators operating
> on both interconnect port simultaneously.

We had these issues for omap3 too. Adding a few read backs solved
those kinds of issues.

Regards,

Tony
