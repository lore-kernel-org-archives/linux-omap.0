From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Thu, 17 May 2012 16:12:52 -0700
Message-ID: <20120517231251.GH17852@atomide.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
 <87y5oqtpnw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34081 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182Ab2EQXMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 19:12:55 -0400
Content-Disposition: inline
In-Reply-To: <87y5oqtpnw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120517 15:29]:
> 
> I just noticed that this patch has caused some strange problems, notably
> with the GPIO IRQ used by smsc911x NIC (Overo, Zoom3, 2430SDP, etc. etc.)
> 
> The patch itself is OK, but it has exposed a bug in other parts of the
> context restore path that was previously hidden.
> 
> We seem to have been finding lots of GPIO bugs by just testing the
> network chips with GPIO IRQs.  Can I suggest that a platform with a GPIO
> IRQ NIC be added to the test platforms you're using? 

Yes considering the breakage it's pretty obvious the original series was
never properly tested on omaps.

Regarding this fix, using gpio/next + this patch fixes nfsroot for 2430sdp,
and gets zoom3 nfsroot booting going a bit better.

However, at least on zoom3 nfsroot now takes several _minutes_ to get to
login: with gpio/next + this patch. The system is totally unusable.

It seems that the GPIO interrupt wake-up events are not properly working
now?

Reverting the "gpio/omap: fix missing check in *_runtime_suspend()"
patch seems to fix the issue.

> Subject: [PATCH] gpio/omap: fix broken context restore for non-OFF mode
>  transitions
> 
> The fix in commit 1b12870 (gpio/omap: fix missing check in
> *_runtime_suspend()) exposed another bug in the context restore path.

Kevin, looks like commit 1b12870 does not exist in gpio/next?

Regards,

Tony
