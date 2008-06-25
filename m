From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 0/2] Dynamic allocation for mcbsp devices. and related
     changes
Date: Wed, 25 Jun 2008 20:27:07 +0530 (IST)
Message-ID: <55031.192.168.10.88.1214405827.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbYFYO5N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 10:57:13 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5PEv8dB022803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 09:57:13 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5PEv5C0022821
	for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2008 09:57:06 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch series (2 patches) provides dynamic allocation for McBSP devices.

First patch is tony's patch which uses platform_device_alloc.
i dont think  that patch is pushed, so i have added it for reference.

Second  patch provides dynamic allocation for mcbsp devices.
no. of  mcbsp for each cpu is determined at runtime and  memory is allocated
accordingly. id check macro definition has been changed.

Code is only compile tested. so if any one has test setup, please test it and
report back. some optimizations are still possible, but i am concerned about
functionality for the time being.

please review it and

Regards,
Chandra Shekhar



