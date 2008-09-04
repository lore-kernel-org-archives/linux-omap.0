From: "Premi, Sanjeev" <premi@ti.com>
Subject: OMAP3EVM : Doesn't resume after suspend
Date: Fri, 5 Sep 2008 02:08:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A03B16D8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41379 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759932AbYIDUie convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 16:38:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m84KcOwC003247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Sep 2008 15:38:32 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m84KcN8A005205
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 02:08:24 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I am building off the tag v2.6.26-omap2. While trying the suspend/resume, i noticed that suspend succeeds; but the resume doesn't happen.
Did anyone else notice this behavior?

Best regards,
Sanjeev