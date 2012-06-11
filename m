From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 0/7] ARM: OMAP4: core retention support
Date: Mon, 11 Jun 2012 18:26:20 +0300
Message-ID: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53171 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab2FKP0k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:26:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- moved basic omap4 pm errata support from dev-off set to this one
- changed ordering of patches a bit (core ret enabled at last patch)
- dropped DSP reset hack patch from set, as it is no longer needed
- added arch specific hwmod_ops support, needed for proper functioning
  of the context loss support
- context offset register invalidity is now marked with USHRT_MAX
  instead of a separate flag
- patches rebased on top of Jean Pihet's functional power state code
- patches rebased on top of 3.5-rc2
- dropped debug option for enabling OSWR mode for suspend, this is now
  enabled by default

Tested with omap4 panda board + omap3 beagle (just to verify nothing
gets broken.)

Fully functioning branch available here:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.5-rc2-omap4-ret-v6

Branch contains also hwmod fixes from Paul Walmsley, functional power
state code from Jean Pihet, IO chain set and a few other needed misc
fixes to make suspend to core retention + wakeup to work properly.

-Tero

