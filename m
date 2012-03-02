From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 0/6] ARM: OMAP3+: IO daisychain support fixes
Date: Fri, 2 Mar 2012 17:17:49 +0200
Message-ID: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359Ab2CBPSN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 10:18:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- patch2:
 * changed timeout value to 100us (from 1000)
 * added poll for the IO status == 0 at the end of trigger sequence
- patch4:
 * omap3: global wakeup done in PRM init instead of OMAP3 PM init
 * omap4: moved global wakeup enable from trigger func to PRM init

Tested on omap3beagle / omap4blaze, suspend / resume works with io chain.

-Tero

