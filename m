From: Bill Gatliff <bgat@billgatliff.com>
Subject: Question on OTG transceivers
Date: Wed, 17 Mar 2010 16:35:02 -0500
Message-ID: <4BA14B06.8050202@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64904 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0CQVey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 17:34:54 -0400
Received: by gyg8 with SMTP id 8so647844gyg.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Mar 2010 14:34:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Guys:


I have a Beagleboard-like unit here that uses two SMSC USB3320C-EZK
PHYs: one for EHCI (usb1), the other for OTG (usb0).

Two questions.  First, the code in drivers/usb/otg/ulpi.c looks like it
might be what I need (my attempts so far with the "nop" transceiver have
ended in failure).  Am I right?

Second, it looks like otg_set_transceiver() assumes there is only one
transceiver in the system.  On a device like the OMAP3530 with multiple
ports, this seems like an odd assumption--- and one that clearly isn't
accurate for my platform.  Or am I paying attention to the wrong stuff?

Can anyone help navigate me through the trees in this forest?  :)


Thanks!


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com

