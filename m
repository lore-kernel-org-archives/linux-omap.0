From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: SRF Fixes
Date: Wed, 29 Oct 2008 10:30:14 +0200
Message-ID: <1225269015-19064-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32624 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYJ2I3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 04:29:14 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi,

We have been testing the SRF patches (sent by Rajendra on 16th-Oct) now,
and some issues were found. The following patch corrects some of them,
these issues remain:      

1. Handling enable_off_mode sysfs switches is not supported in this patch.
I'm planning to add a new interface into the generic shared resource fw 
to enable refreshing power domain states, when such changes take place.

2. Non platform devices won't be able to add power domain wake-up latency 
requirements. The srf interface has a device pointer parameter, which the
following patch uses to get platform_device pointer. This pdev is required
by the omapdev interface for finding the respective power domain. The 
aquisition of platform_device pointer is done via container_of macro, which
may cause crashes if the device pointer does not have a platform device
container.

Any comments on how to make this better are welcome. I think that if   
the SRF interface would accept a platform_device pointer instead of
device pointer the problem would solve. I have a check in my patch that 
checks for NULL pointer in pdev->name, but this won't work always. 

3. Seems that device hangs if MPU, NEON and CORE power domains hit OFF
mode, while other power domains are in retention. We suspect PER in 
retention + CORE in OFF would be the most likely cause of trouble,
this is being looked into.

regards,
Kalle Jokiniemi



