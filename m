From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 0/6] ARM: OMAP3+: minor PM core code cleanup
Date: Fri, 13 Jul 2012 19:37:33 +0300
Message-ID: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41487 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030721Ab2GMQjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 12:39:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Following set moves some PRM related code away from PM core code to
PRM / HWMOD. This requires the hwmod cleanup set from Paul that
implements the setup_preprogram hooks for hwmods. Sending as RFC for
initial commenting.

This set does following:
- gets rid of the prcm interrupt handler from pm34xx.c
- removes iva_idle from pm34xx.c
- removes d2d_idle from pm34xx.c

There are some side-effects though, it looks like the reset statuses
for iva / d2d modules are rather flaky, and some failed hardreset
warnings are generated during boot. PM works fine though and the
modules are put to idle properly. Could use some ideas how to handle
this, maybe add a flag for ignoring the hardreset status completely...?

-Tero

