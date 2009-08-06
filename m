From: Peter Barada <peterb@logicpd.com>
Subject: Question regarding MUSB and dynamic fifo sizing
Date: Thu, 06 Aug 2009 16:10:41 -0400
Message-ID: <1249589441.10885.75.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:17339 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755686AbZHFUG6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 16:06:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I'm running into a problem where the MUSB controller stops talking with
the hardwired device on the other end, and I wasn to unload the musb as
a module and reload it to the connection working again.

I can compile MSUB as a module, but when I load it the 2nd time it
complains with:

OMAP-35x# modprobe musb_hdrc
musb_hdrc: version 6.0, pio, otg (peripheral+host), debug=0
musb_core_init 1421: reconfigure software for static FIFOs
musb_hdrc musb_hdrc: musb_init_controller failed with status -19

This is due to the platform device wanting dynamic fifo sizing but the
CONFIGDATA register has DYNFIFO bit cleared.  Looking through the TRM, I
can't find informaiton on how the MUSB controller changes the state of
DYNFIFO - I'm guessing once any of the dynamic registers are written to
that the controller switches to Dynamic Fifo sizing.

The code that aborts is:

	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
		if (musb->config->dyn_fifo)
			status = ep_config_from_table(musb);
		else {
			ERR("reconfigure software for Dynamic FIFOs\n");
			status = -ENODEV;
		}
	} else {
		if (!musb->config->dyn_fifo)
			status = ep_config_from_hw(musb);
		else {
			ERR("reconfigure software for static FIFOs\n");
			return -ENODEV;
		}
	}

1) How can one change from dynamic to static fifo sizing in the MUSB?

2) Would it be safe to program for dynamic fifo sizing if CONFIG_DATA
indicates the fifos are Statically sized?


-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
