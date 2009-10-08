From: Nishanth Menon <nm@ti.com>
Subject: FEATURES prints
Date: Thu, 8 Oct 2009 14:13:16 -0500
Message-ID: <4ACE39CC.1070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41494 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbZJHTNx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Oct 2009 15:13:53 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n98JDHBJ019999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 8 Oct 2009 14:13:17 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n98JDG4f011622
	for <linux-omap@vger.kernel.org>; Thu, 8 Oct 2009 14:13:16 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n98JDGL7024291
	for <linux-omap@vger.kernel.org>; Thu, 8 Oct 2009 14:13:16 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Folks,

With the addition of FEATURES in l-o, the following prints:
  - l2cache : Y
  - iva : Y
  - sgx : Y
  - neon : Y
  - isp : Y

comes up on SDP3430 -> now that we will introduce half a dozen features 
here and there, we will soon clutter this up. we should introduce a 
sysfs entry + remove the above noise..

any comments?

-- 
Regards,
Nishanth Menon
