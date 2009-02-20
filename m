From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP3530 USB host problems
Date: Fri, 20 Feb 2009 11:15:36 -0700
Message-ID: <499EF348.6020302@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76.skybeam.com ([76.76.67.137]:5148 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbZBTSPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 13:15:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

I have a 3530 board (similar to the OMAP3EVM) and I'm trying
to get the USB host working.  Sadly, this is failing, but I
don't quite see why.  From drivers/usb/host/echi-omap.c:
	/* Wait for TLL to be Active */
        timeout = 1000;
	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
        {
            if (--timeout <= 0) {
                printk(KERN_ERR "USB TLL is unavailable\n");
                return -ENODEV;
            }
		cpu_relax();
        }

Any clues on why this might be?  How do I solve it?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
