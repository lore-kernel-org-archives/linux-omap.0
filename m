From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: collaboration on hwmod conversions and runtime PM
Date: Thu, 20 May 2010 16:56:31 -0700
Message-ID: <87mxvucekw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62703 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0ETX4e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 19:56:34 -0400
Received: by pvg3 with SMTP id 3so159222pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 16:56:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

There has been quite a bit of activity on the hwmod front, but no
common place to combine patches for testing.

To that end, I've update the pm-wip/hwmods branch in my tree to 
the two fixes/cleanup series from Benoit (which will be merged
via for 2.6.35):

  [PATCH 00/10] OMAP: HWMOD fixes and cleanup
  [PATCH 0/5] OMAP4: PRCM: Spring cleanup

On top of this, there is the pm-wip/hwmods-omap4 branch which includes
the OMAP4 series from Benoit

  [PATCH 0/6] OMAP: hwmod: Full data set for OMAP4430 ES1.0

so that conversions for OMAP4 can also be done and tested.  Note that
I've reverted the two "temporary" patches in this series since they
cause problems on OMAP3,

On top of this, there is the pm-wip/runtime branch which includes
the base runtime PM implementation for OMAP.

On top of this there are work-in-progress branches for the conversions
for UART (pm-wip/uart) and MMC (pm-wip/mmc)

Kevin
