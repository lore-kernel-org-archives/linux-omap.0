From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH] ARM: OMAP2+: Re-enable SW_SLEEP for clockdomains
Date: Fri, 7 Feb 2014 16:20:58 -0600
Message-ID: <1391811659-33716-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32860 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbaBGWVO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Feb 2014 17:21:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>

This patch changes clockdomain handling for platforms using omap4
operations. Commit 65aa94b204d removed SW_SLEEP functionality
from the omap4 clockdomain controls with the intention that, because
all IPs support HW_AUTO, that should be used instead. This may make
sense for omap4, but many platforms, including AM43xx and DRA7x, use
these same functions. It definitely does not make sense on AM43xx
as all clockdomains are software controlled only. This means that as
of right now clockdomain handling is broken on AM43xx and no
clockdomains are actually being put into idle on this platform. Any
attempt to idle them results in the HW_AUTO value (0x3) being written
to them with no apparent effect.

This patch will allow actual idling for am43xx clockdomains however the
effects of this patch will reach beyond that. This is something that
should be corrected for AM43xx however the bigger question is about how
this change affects other non-omap4 platforms leveraging the same code.
omap4_clkdm_operations are used by omap5, omap4, dra7x and am43xx. Is
SW_SLEEP something we also want back on omap5 and dra7x?

Dave Gerlach (1):
  ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP Support

 arch/arm/mach-omap2/cminst44xx.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
1.7.9.5

