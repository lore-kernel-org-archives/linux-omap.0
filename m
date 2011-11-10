From: "Premi, Sanjeev" <premi@ti.com>
Subject: Which toolchain are we using?
Date: Thu, 10 Nov 2011 08:47:51 +0000
Message-ID: <E28AAFD00EFAA646AE3DF9B89CD24A8903B687@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58564 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab1KJIrz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 03:47:55 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAA8lq8Z010182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 02:47:54 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAA8lpdJ011098
	for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 14:17:51 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I have been running latest linux-omap/master on OMAP3EVM (boot from MMC).
When building with CodeSourcery 2011.03-41, I see frequent "hangs" just
after "Uncompressing Linux... done, booting the kernel"

However, builds with CodeSourcery 2009q1-203 boot consistently all the
time.

Before trying to investigate further, wanted to know if someone else has
seen the problem. If no, which toolchain is being used.

~sanjeev
