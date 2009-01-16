From: Peter Barada <peterb@logicpd.com>
Subject: Question on how to best access a chip on init that needs VAUX1
	power?
Date: Fri, 16 Jan 2009 14:31:27 -0500
Message-ID: <1232134287.347.44.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:13148 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755130AbZAPTb3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 14:31:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On the OMAP board I have, I want to access production information
(model, serial number, MAC addresses, etc), and the part requires 3v
which is powered off of VAUX1.

I need to pull this out at initialization time, but I have to wait until
the twl4030 driver is running or I get "twl4030: client 3 is not
initialized" when I try to turn on the power.   Looking at the
twl4030-core.c code, I see its invoked via initcall_subsys().  I'd like
to have my code invoked before the other devices come up (so I can
provide a MAC address to the ethernet, etc).  I'm trying
initcall_sysbys_sync() to have my code called after the twl4040
initializes, but before the devices come up.

Is the the right way to approach this?

-- 
Peter Barada <peterb@logicpd.com>
