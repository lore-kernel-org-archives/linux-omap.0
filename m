From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] OMAP3 PM: enable hardware SAR for USBHOST, USBTLL modules
Date: Wed, 25 Jun 2008 18:09:41 -0600
Message-ID: <20080626000940.18779.94992.stgit@localhost.localdomain>
References: <20080626000415.18779.25924.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36927 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbYFZAQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 20:16:43 -0400
In-Reply-To: <20080626000415.18779.25924.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, r-woodruff2@ti.com

Enable hardware save-and-restore for the CORE and USBHOST powerdomains
during PM layer initialization.  On OMAP3, this only affects the
USBTLL and USBHOST modules.

There is probably a sleep and wakeup latency penalty with these
enabled.  No one seems to have quantified it yet.  If the added
latency is measurable, an alternate approach would be to only enable
hardware save-and-restore if there are USB devices attached.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c7493f5..202c269 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -357,6 +357,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	pwrst->pwrdm = pwrdm;
 	pwrst->next_state = PWRDM_POWER_RET;
 	list_add(&pwrst->node, &pwrst_list);
+
+	if (pwrdm_has_hdwr_sar(pwrdm))
+		pwrdm_enable_hdwr_sar(pwrdm);
+
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 


