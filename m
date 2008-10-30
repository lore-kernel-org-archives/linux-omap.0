From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 0/4] legacy gpio phaseout...
Date: Wed, 29 Oct 2008 20:36:21 -0700
Message-ID: <200810292036.21321.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:32982 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752308AbYJ3DoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 23:44:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is the first two of the four patches I sent before, split
into stuff that only relates to the OMAP tree and stuff that
applies to that and to mainline:

 - OMAP tree
    * use standard gpio get/set calls
    * use gpio_direction_input
 - Mainline *and* OMAP trees:
    * use standard get/set calls, remove the legacy one
    * use gpio_direction_input

Some of the OMAP-only bits relate to touchscreen support;
when it's ads7846-compatible, that should probably be in
the mainline merge queue too.

There will be a couple minor glitches applying the second
set to mainline; nothing of significance.

I'll do the same split for the second pair of patches a
bit later.
