From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] driver core: Check if r->name is valid in platform_get_resource_byname()
Date: Thu, 23 Aug 2012 17:10:00 +0300
Message-ID: <1345731000-12768-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53432 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932725Ab2HWOKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 10:10:12 -0400
Received: by obhx4 with SMTP id x4so2038310obh.14
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 07:10:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

Safety check for the validity of the resource name before calling strcmp().
If the resource name is NULL do not compare it, just skip it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Greg,

I have experienced with a kernel crash because the r->name was NULL when booting
OMAP4+ kernel with devicetree.
I have sent a separate patch for the OMAP specific root (with analysis of the
issue):
http://marc.info/?l=linux-omap&m=134573006327647&w=2

I agree that it is unlikely to have the name NULL, but I think it does not hurt
if we do a safety check before comparing the strings.

Best Regards,
Peter

 drivers/base/platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a1a7225..d717c2b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -99,6 +99,9 @@ struct resource *platform_get_resource_byname(struct platform_device *dev,
 	for (i = 0; i < dev->num_resources; i++) {
 		struct resource *r = &dev->resource[i];
 
+		if (unlikely(!r->name))
+			continue;
+
 		if (type == resource_type(r) && !strcmp(r->name, name))
 			return r;
 	}
-- 
1.7.8.6

