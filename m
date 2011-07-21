From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] mfd: twl4030: Fix mismatch in mutex lock-unlock
Date: Thu, 21 Jul 2011 16:14:28 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DC71247@dbde02.ent.ti.com>
References: <1310397631-1596-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53406 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1GUKoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 06:44:34 -0400
In-Reply-To: <1310397631-1596-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, July 11, 2011 8:51 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev; J, KEERTHY; Samuel Ortiz
> Subject: [PATCHv2] mfd: twl4030: Fix mismatch in mutex lock-unlock
> 
> A mutex is locked on entry into twl4030_madc_conversion().
> Immediate return on some error conditions leaves the
> mutex locked.
> 
> This patch ensures that mutex is always unlocked before
> leaving the function.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Samuel, Keerthy,

Just wanted to ping both of you on this patch.

~sanjeev
