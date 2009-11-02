From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Update DSS2 patches for latest kernel changes
Date: Mon, 2 Nov 2009 20:32:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436EEB692@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41477 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbZKBPCX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 10:02:23 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Tomi,

(Tomi, Sorry for resending it again, somehow last mail did not reach to list, so sending it again by removing patches attached.)

DSS2 patches needs to be updated against the latest kernel changes, especially after commit "omap: headers: Move remaining headers from include/mach to include/plat"

Since this patch has already merged to "for-next", I have done required modification to your commits (for both master and pm branch), keeping rest of the stuff as is. 
I could able to validate it only on OMAP3EVM (since I don't have other EVMs) with DPI/Venc interface. 

If you could validate rest of the interfaces then we can update the DSS2 branch with latest kernel.

You can access the patches from the repository - 

http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=shortlog;h=refs/heads/ti_display


Thanks,
Vaibhav

