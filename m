From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] TI-SoC-thermal: Fine-tuning for two functions
Date: Wed, 26 Apr 2017 17:33:10 +0200
Message-ID: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 17:24:56 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use devm_kcalloc() in ti_bandgap_build()
  Delete error messages for failed memory allocations in ti_bandgap_build()
  Fix a typo in a comment line

 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.12.2
