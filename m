From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 0/4] start phasing out legacy GPIO calls
Date: Wed, 22 Oct 2008 23:50:54 -0700
Message-ID: <200810222350.54467.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:27092 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751948AbYJWHCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 03:02:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Following this are four patches matching $SUBJECT:

 - remove omap_set_gpio_dataout() and omap_get_gpio_datain()
	... same call syntax, different name, minor code shrink
 - use gpio_direction_input()
	... minor call syntax change, otherwise not interesting
 - use gpio_direction_output(), remove omap_set_gpio_direction()
	... different call syntax and initialization model
 - use gpio_to_irq()
	... at least, outside of static initializers

The third patch might conceivably make trouble; see the patch
comments.  Ditto the fourth, but IMO that's less likely.

I did test builds for OMAP1, OMAP2420, OMAP2430, and OMAP3430,
and tried to make sure all the files affected by this patch
got rebuilt.  The build breakage was mostly related to McBSP
and iomem pointers; nothing affected by these patches.

Two remaining OMAP GPIO calls can be removed a bit later:

	int omap_request_gpio(int gpio);
	void omap_free_gpio(int gpio);

Once that's done, I think it'll be time to move the GPIO
code into mach-omap1/mach-omap2 ... the OMAP2/OMAP3 stuff
in particular should become a LOT simpler.

- Dave
