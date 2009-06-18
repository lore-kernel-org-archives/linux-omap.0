From: "Hemanth V" <hemanthv@ti.com>
Subject: L-O master branch broken ?
Date: Thu, 18 Jun 2009 15:05:11 +0530
Message-ID: <00eb01c9eff8$13dba760$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41082 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242AbZFRJfQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2009 05:35:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5I9ZCJG020967
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 04:35:18 -0500
Received: from wipultra793 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with SMTP id n5I9ZCdG018176
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 15:05:12 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I get the below error while compiling 3430SDP. I see below commit  as the 
latest one.

Hemanth

commit 3dc15d62d3f8e85d74dcbabc234585cb8dbc2194
Author: Tony Lindgren <tony@atomide.com>
Date:   Thu Jun 18 08:59:09 2009 +0300

    Fix iommu.c file permissions

    Commit c8c8bfc4c3664317441b0037040c9bdea210fba1 changed the
    permissions, so undo that. Also checked the other files with:

    $ find arch/arm/*omap* -type f -perm 755

    Signed-off-by: Tony Lindgren <tony@atomide.com>


arch/arm/plat-omap/sram.c: In function 'omap_detect_sram':
arch/arm/plat-omap/sram.c:139: error: expected expression before 'else'
arch/arm/plat-omap/sram.c:190: warning: ISO C90 forbids mixed declarations 
and code
arch/arm/plat-omap/sram.c:347: error: invalid storage class for function 
'omap242x_sram_init'
arch/arm/plat-omap/sram.c:368: error: invalid storage class for function 
'omap243x_sram_init'
arch/arm/plat-omap/sram.c:433: error: expected declaration or statement at 
end of input
make[1]: *** [arch/arm/plat-omap/sram.o] Error 1
make: *** [arch/arm/plat-omap] Error 2

