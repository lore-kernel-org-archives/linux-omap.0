From: Scott Ellis <scott@jumpnowtek.com>
Subject: Re: How to (get a struct device* to) map a DMA buffer for McBSP?
Date: Sun, 28 Nov 2010 11:00:55 +0000 (UTC)
Message-ID: <loom.20101128T114509-177@post.gmane.org>
References: <AANLkTimuvMArMjGqVAfHLyh-eE0f9Un03UMHZHyP=_N1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38133 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab0K1LZH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Nov 2010 06:25:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1PMfNR-00047r-D4
	for linux-omap@vger.kernel.org; Sun, 28 Nov 2010 12:25:05 +0100
Received: from 173-162-152-37-NewEngland.hfc.comcastbusiness.net ([173.162.152.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 28 Nov 2010 12:25:05 +0100
Received: from scott by 173-162-152-37-NewEngland.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 28 Nov 2010 12:25:05 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I had exactly the same problem. It looks like the struct omap_mcbsp array was
intended to be accessible

>From include/plat/mcbsp.h
extern struct omap_mcbsp **mcbsp_ptr;

I couldn't get access to mcbsp_ptr in an out of tree module. So I added this

arch/arm/plat-omap/include/plat/mcbsp.h
+struct omap_mcbsp* omap_mcbsp_get_mcbsp_ptr(u8 id);

arch/arm/plat-omap/mcbsp.c
+struct omap_mcbsp* omap_mcbsp_get_mcbsp_ptr(u8 id)
+{
+	if (!omap_mcbsp_check_valid_id(id))
+		return NULL;
+
+	return id_to_mcbsp_ptr(id);
+}
+EXPORT_SYMBOL(omap_mcbsp_get_mcbsp_ptr);
+

This was to could get access to .phys_base and .dma_rx_sync for my own DMA ops.

Is there a better way?


