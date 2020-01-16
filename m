From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] ti-sysc driver changes for omaps for v5.6
Date: Thu, 16 Jan 2020 10:48:12 -0800
Message-ID: <pull-1579200367-372444@atomide.com-3>
References: <pull-1579200367-372444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51300 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436988AbgAPSsq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 16 Jan 2020 13:48:46 -0500
In-Reply-To: <pull-1579200367-372444@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: soc@kernel.org
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e709ed70d122e94cb426b1e1f905829eae19a009:

  bus: ti-sysc: Fix missing reset delay handling (2019-12-12 08:20:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/ti-sysc-signed

for you to fetch changes up to 3f2c420596be57e74719bd09333d3b5efe90341d:

  bus: ti-sysc: Use PTR_ERR_OR_ZERO() to simplify code (2019-12-12 09:06:40 -0800)

----------------------------------------------------------------
ti-sysc driver changes for omaps for v5.6 merge window

Few changes to implement quirk handling for cases where we need to block
clockdomain autoidle, drop old MMU specific quirks, and simplify the
return code for sysc_init_resets().

----------------------------------------------------------------
Suman Anna (1):
      bus: ti-sysc: Drop MMU quirks

Tony Lindgren (1):
      bus: ti-sysc: Implement quirk handling for CLKDM_NOAUTO

zhengbin (1):
      bus: ti-sysc: Use PTR_ERR_OR_ZERO() to simplify code

 drivers/bus/ti-sysc.c                 | 18 +++++++++---------
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)
