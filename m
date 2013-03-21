From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 0/8]: omap4: clk: move clock data under drivers/clk
Date: Thu, 21 Mar 2013 19:35:39 +0200
Message-ID: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3CURg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Mar 2013 13:36:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This is an RFC version of the clock data move under drivers/clk.
Tested under 3.8 and boots fine, but don't try this out unless
you are experimental sort (I quickly tried with 3.9-rc3 and it failed to
boot with that.)

The approach taken here has minimal impact on the clock data
and should make it easy to transfer clock data for omap2 / omap3 and
omap5 also. omap4 was only done as a proof of concept.

Any comments appreciated.

-Tero

