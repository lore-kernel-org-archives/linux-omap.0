From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/1] OMAP: I2C: Add mpu wake up latency constraint
Date: Thu, 17 Sep 2009 19:28:42 +0300
Message-ID: <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:14399 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbZIQQ2i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Sep 2009 12:28:38 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: jhnikula@gmail.com, linux-omap@vger.kernel.org

Sending this patch that fixes a problem where I2C transfers get stalled
because MPU can hit off mode while i2c is waiting for transfer
completion.

There are some changes on how clkrate is passed to i2c-omap bus
driver, as I needed to pass also the constraint setting function.
So review comments are most welcome.

Applies on top of pm-branch. Just build tested for
omap3_pm_defconfig. Could not get linux-omap to boot
on my rx-51, so it's only tested with our internal tree.

- Kalle


