From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] mfd/tps65910: Adjustments for four function
 implementations
Date: Tue, 16 Jan 2018 12:57:45 +0100
Message-ID: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jan 2018 12:54:32 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in tps65910_parse_dt()
  Delete an unnecessary variable initialisation in four functions
  Delete an unnecessary variable initialisation in tps65910_sleepinit()
  Move an assignment in tps65910_sleepinit()

 drivers/mfd/tps65910.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.15.1

