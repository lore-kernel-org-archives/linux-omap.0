From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] fix for omap sdma changes for v5.6
Date: Thu, 16 Jan 2020 10:48:10 -0800
Message-ID: <pull-1579200367-372444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51288 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436981AbgAPSsp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 16 Jan 2020 13:48:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: soc@kernel.org
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 9fc85a7124b5ff9ec24ad391f9994f89ae611313:

  Merge branch 'omap-for-v5.6/sdma' into omap-for-v5.6/ti-sysc-drop-pdata (2019-12-30 10:17:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/sdma-fix-signed

for you to fetch changes up to a25e29bd0fe9be33491b3816d2d7b1137d5eeaec:

  Merge branch 'omap-for-v5.6/sdma' into omap-for-v5.6/ti-sysc-drop-pdata (2020-01-13 09:42:55 -0800)

----------------------------------------------------------------
Fix omap sdma handling for missing auxdata for v5.6 merge window

Turns out I was overly optimistic about making platform data optional, and
we still need it to pass various quirk flags. If the platform data is missing
for whatever reason, we will currently try to access non-existing data later
on.

----------------------------------------------------------------
Colin Ian King (1):
      dmaengine: ti: omap-dma: don't allow a null od->plat pointer to be dereferenced

Tony Lindgren (1):
      Merge branch 'omap-for-v5.6/sdma' into omap-for-v5.6/ti-sysc-drop-pdata

 drivers/dma/ti/omap-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
