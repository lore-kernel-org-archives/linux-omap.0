From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: OMAPDSS: remove dispc's dependency to VENC/HDMI
Date: Tue, 27 Aug 2013 04:20:16 +0300
Message-ID: <20130827012016.GE17061@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33977 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab3H0BU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Aug 2013 21:20:26 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org

Hello Tomi Valkeinen,

This is a semi-automatic email about new static checker warnings.

The patch 5391e87d1259: "OMAPDSS: remove dispc's dependency to 
VENC/HDMI" from May 16, 2013, leads to the following Smatch complaint:

drivers/video/omap2/dss/hdmi.c:672 omapdss_hdmi_display_set_timing()
	 error: we previously assumed 't' could be null (see line 669)

drivers/video/omap2/dss/hdmi.c
   668		t = hdmi_get_timings();
   669		if (t != NULL)
                    ^^^^^^^^^
Existing check.

   670			hdmi.ip_data.cfg = *t;
   671	
   672		dispc_set_tv_pclk(t->timings.pixel_clock * 1000);
                                  ^^^^^^^^^^^^^^^^^^^^^^
Patch added a dereference.

   673	
   674		mutex_unlock(&hdmi.lock);

regards,
dan carpenter
