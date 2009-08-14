From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: DSPBRIDGE: Tie Resource accounting to Process Context
Date: Fri, 14 Aug 2009 14:08:51 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D1A@dlee06.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50050 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbZHNTJC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:09:02 -0400
In-Reply-To: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


Hi Ameya,

	I have tested your patches, and the first tests run very well and also the memory leaks due to we had only one hprocessor and we lost the other ones disappeared. Thank you so much for the patches; just a few comments please see my comments on the patches. It would be great if you could divide the patches in functional patches and not divided in module patches. Something like one patch for the Wrappers, other for the change of bridge cleanup and other one by the list of processor object.

Regards,
Fernando.

-----Original Message-----
From: Ameya Palande [mailto:ameya.palande@nokia.com] 
Sent: Monday, August 10, 2009 8:22 PM
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando; Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
Subject: DSPBRIDGE: Tie Resource accounting to Process Context

This patch series uses filp->private data to get access to a PROCESS_CONTEXT
pointer which in turn tracks all the resources tied to an open file handle.

This will help in:
1. Implementation of clean resource accounting.
2. Proper resource cleanup irrespective of multithreading or multitasking in
   user space applications.


