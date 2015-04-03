From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] one n900 audio regression fix for v4.0-rc cycle
Date: Fri, 3 Apr 2015 16:03:44 -0700
Message-ID: <20150403230344.GA18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41739 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbbDCXHk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 19:07:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 599c376c49323127c9bdbb0fa61a3d4743819bc2:

  ARM: dts: Fix gpio interrupts for dm816x (2015-03-18 13:41:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/oamp-for-v4.0/fix-audio

for you to fetch changes up to 6f7cedbdac1278e1bacfb9ef79769178fcd6a0b3:

  ARM: dts: OMAP3-N900: Add microphone bias voltages (2015-04-01 12:32:40 -0700)

----------------------------------------------------------------
One audio regression fix for n900 that would be good to get
into v4.0 as people are already playing with audio call support
for n900 using mainline kernel.

----------------------------------------------------------------
Pavel Machek (1):
      ARM: dts: OMAP3-N900: Add microphone bias voltages

 arch/arm/boot/dts/omap3-n900.dts | 4 ++++
 1 file changed, 4 insertions(+)
