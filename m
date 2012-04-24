From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 0/3] ARM: OMAP: PM: reduce overhead of pwrdm pre/post transitions
Date: Tue, 24 Apr 2012 07:23:37 -0700
Message-ID: <1335277420-29124-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:39837 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679Ab2DXOWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:22:52 -0400
Received: by dacx6 with SMTP id x6so790352dac.32
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:22:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Here's a first pass attempt to reduce the overhead of the pre/post
transitions by allowing them to be called per powerdomain and making
them conditional on powerdomain transtions.

This can be used for testing/measurements to see the reduction the
latencies involved in entering/exiting idle with and without these
patches.

Kevin Hilman (3):
  ARM: OMAP2+: powerdomain: allow pre/post transtion to be per pwrdm
  ARM: OMAP3: PM: call pre/post transition per powerdomain
  ARM: OMAP3: PM: cleanup cam_pwrdm leftovers

 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c              |   14 ++++++++------
 arch/arm/mach-omap2/powerdomain.c         |   16 ++++++++++++----
 arch/arm/mach-omap2/powerdomain.h         |    4 ++--
 4 files changed, 24 insertions(+), 14 deletions(-)

-- 
1.7.9.2

