From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Question on how to best access a chip on init that needs VAUX1
	power?
Date: Fri, 16 Jan 2009 14:17:06 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D6A1527@dlee02.ent.ti.com>
References: <1232134287.347.44.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39867 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229AbZAPURQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 15:17:16 -0500
In-Reply-To: <1232134287.347.44.camel@blackhole>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>, linux-omap <linux-omap@vger.kernel.org>

Subject: Question on how to best access a chip on init that needs VAUX1 power?
>
> On the OMAP board I have, I want to access production information
> (model, serial number, MAC addresses, etc), and the part requires 3v
> which is powered off of VAUX1.
>
> I need to pull this out at initialization time, but I have to wait until
> the twl4030 driver is running or I get "twl4030: client 3 is not
> initialized" when I try to turn on the power.   Looking at the
> twl4030-core.c code, I see its invoked via initcall_subsys().  I'd like
> to have my code invoked before the other devices come up (so I can
> provide a MAC address to the ethernet, etc).  I'm trying
> initcall_sysbys_sync() to have my code called after the twl4040
> initializes, but before the devices come up.

You can access this info from u-boot with i2c api.  For development you want the mac address available at that time anyway.

When you program it into Ethernet chip for many it will stick so kernel will see the right thing.

u-boot also has simple utility to read from mtd which has u-boot environment where you could have stored it away.

Regards,
Richard W.
