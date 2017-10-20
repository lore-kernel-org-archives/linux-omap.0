From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ARM-OMAP3: Fine-tuning for omap3xxx_hwmod_init()
Date: Fri, 20 Oct 2017 17:15:08 +0200
Message-ID: <ad74497a-9516-8a98-8deb-e6d5b752a898@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Oct 2017 17:08:09 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code
  Delete an unnecessary variable initialisation

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.14.2
