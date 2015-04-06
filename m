From: Nishanth Menon <nm@ti.com>
Subject: LDP: next-20150402: twl4030 regression?
Date: Mon, 06 Apr 2015 08:21:49 -0500
Message-ID: <5522886D.5050409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

https://github.com/nmenon/kernel-test-logs/blob/next-20150401/omap2plus_defconfig/ldp.txt
looks clean, but

https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
seems to have picked up a regression in the regulator driver.

Master looks clean as well

https://github.com/nmenon/kernel-test-logs/blob/v4.0-rc6/omap2plus_defconfig/ldp.txt
