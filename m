From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] omapfb: copy omapdss & displays for omapfb
Date: Tue, 4 Feb 2020 15:39:09 +0300
Message-ID: <20200204123909.3gyarjvlyz6yl4d6@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:53284 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgBDMjT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 4 Feb 2020 07:39:19 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org

Hello Tomi Valkeinen,

The patch f76ee892a99e: "omapfb: copy omapdss & displays for omapfb"
from Dec 9, 2015, leads to the following static checker warning:

	drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c:336 display_uninit_sysfs()
	warn: passing freed memory 'dssdev'

drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
   332  void display_uninit_sysfs(struct platform_device *pdev)
   333  {
   334          struct omap_dss_device *dssdev = NULL;
   335  
   336          for_each_dss_dev(dssdev) {
   337                  if (kobject_name(&dssdev->kobj) == NULL)
   338                          continue;
   339  
   340                  kobject_del(&dssdev->kobj);
   341                  kobject_put(&dssdev->kobj);
   342  
   343                  memset(&dssdev->kobj, 0, sizeof(dssdev->kobj));

Depending on the config options kobject_release() might delay clean up
for 1-4 seconds so this memset() could lead to bugs.

   344          }
   345  }

regards,
dan carpenter
