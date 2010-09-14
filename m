From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: OMAPFB query
Date: Tue, 14 Sep 2010 19:30:18 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F70C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52507 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab0INOFc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 10:05:32 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi!

For OMAPFB we have two header files:
drivers/video/omap2/omapfb/omapfb.h
include/linux/omapfb.h

There are some definitions like: 
#define FB2OFB(fb_info) ((struct omapfb_info *)(fb_info->par))

This is not available in include/linux/omapfb.h

Can anybody help me in understanding how a user space application can use these definitions in omap2/omapfb/omapfb.h

-Thanks,
Mayuresh
