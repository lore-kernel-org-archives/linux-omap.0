From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] musb regression on omap4 for v3.9
Date: Tue, 23 Apr 2013 14:45:45 -0700
Message-ID: <20130423214544.GN10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59565 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab3DWVpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 17:45:50 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc6/fixes-signed

for you to fetch changes up to f4d7a536faa43f30d87f701268db76b8433a2a8b:

  ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m" as the main clock (2013-04-10 13:26:07 -0700)

----------------------------------------------------------------
One MUSB regression fix that I forgot to send earlier. Without
this MUSB no longer works on omap4 based devices.

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m" as the main clock

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
