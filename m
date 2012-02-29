From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/4] ARM: OMAP4: core retention support
Date: Wed, 29 Feb 2012 17:25:02 +0200
Message-ID: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655Ab2B2PZd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 10:25:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- split out the io_chain set as a separate set
- marked patch 3 as TEMP, this is only needed until Paul's pwrdm fixes
  get merged (http://marc.info/?l=linux-omap&m=133040749621183&w=2)

Depends on the io_chain set to provide wakeup capability from
retention.

Tested with omap4430 blaze : suspend / resume works okay.

-Tero

