From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 0/5] legacy gpio phaseout (II) ...
Date: Thu, 30 Oct 2008 00:31:42 -0700
Message-ID: <200810300031.42711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34846 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751939AbYJ3Hig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 03:38:36 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Second set, plus the first of Jarkko's:

 - OMAP tree
    * use gpio_direction_output()
    * use gpio_to_irq()
 - Mainline *and* OMAP trees:
    * use gpio_direction_output(), remove the legacy version
    * use gpio_to_irq()
    * make legacy gpio_request()/gpio_free() calls superfluous

These go on top of the preceding four.

Merging these will facilitate for example a mach-omap2/gpio.c file
that is much nicer since it's not full of OMAP1 support...


