From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] mfd: twl-core: Fine-tuning for add_numbered_child()
Date: Sun, 15 May 2016 20:11:15 +0200
Message-ID: <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160111082922.GB14104@x1>
Sender: kernel-janitors-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 May 2016 19:55:30 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed platform_device_alloc() in add_numbered_child()
  Refactoring for add_numbered_child()

 drivers/mfd/twl-core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
2.8.2

