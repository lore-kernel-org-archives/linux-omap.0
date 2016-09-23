From: Jan Remmet <j.remmet@phytec.de>
Subject: [PATCH] tps65910 erratum SWCZ010
Date: Fri, 23 Sep 2016 10:51:59 +0200
Message-ID: <1474620720-1157-1-git-send-email-j.remmet@phytec.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SWCZ010 contains two erratas, one already fixed
commit be1c770028b8 ("mfd: tps65910: Work around silicon erratum SWCZ010")
and this one.

Tested on AM335x board with linux-ti v4.4 kernel. Switching cpu_freq
frequently from 300MHz to 1Ghz results in measurable voltage crashes.
This patch fix the issue.

Jan Remmet (1):
  regulator: tps65910: Work around silicon erratum SWCZ010

 drivers/regulator/tps65910-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
1.9.1
