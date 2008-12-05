From: <Tomi.Valkeinen@nokia.com>
Subject: Setting dss1_alwon_fck rate
Date: Fri, 5 Dec 2008 11:02:38 +0200
Message-ID: <21FAA8D4A5AB5E4096AC4BE4BF42EB140154D464@vaebe104.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38224 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYLEJDY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 04:03:24 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB5934s2003203
	for <linux-omap@vger.kernel.org>; Fri, 5 Dec 2008 11:03:20 +0200
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Any comments on these two patches from Mans, that enable setting
dss1_alwon_fck? I've been using them with the new DSS, works fine for
me.

http://marc.info/?l=linux-omap&m=122454507816731&w=2

Filling the set_rate and round_rate fields of dpll4_m4_ck makes
this clock programmable through clk_set_rate().  This is needed
to give omapfb control over the dss1_alwon_fck rate.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


http://marc.info/?l=linux-omap&m=122454507816734&w=2

This makes clk_get_parent() work on OMAP2/3.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/clock.c     |    5 +++++
 arch/arm/mach-omap2/clock.h     |    1 +
 arch/arm/mach-omap2/clock24xx.c |    1 +
 arch/arm/mach-omap2/clock34xx.c |    1 +
 4 files changed, 8 insertions(+), 0 deletions(-)

 Tomi
