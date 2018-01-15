From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] mfd/omap-usb-tll: Adjustments for usbtll_omap_probe()
Date: Mon, 15 Jan 2018 14:14:15 +0100
Message-ID: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jan 2018 14:09:28 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete two error messages for a failed memory allocation
  Improve a size determination
  Return an error code only as a constant

 drivers/mfd/omap-usb-tll.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

-- 
2.15.1
