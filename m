From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v2] OMAP3630: Add ES1.1 and ES1.2 detection
Date: Wed, 4 Aug 2010 14:09:48 +0300
Message-ID: <20100804110948.GC19377@nokia.com>
References: <20100803073940.GS12293@atomide.com>
 <1280865564-6456-1-git-send-email-gadiyar@ti.com>
 <20100804103029.GI9881@atomide.com>
 <20100804105138.GJ9881@atomide.com>
 <20100804110644.GK9881@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18631 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab0HDLLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 07:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20100804110644.GK9881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Manjunatha GK <manjugk@ti.com>

Hi,

>From 9c6484502a8aba4b7a0f1f3ca847557d52a9350b Mon Sep 17 00:00:00 2001
>From: Anand Gadiyar <gadiyar@ti.com>
>Date: Tue, 3 Aug 2010 19:59:24 +0000
>Subject: [PATCH] OMAP3630: Add ES1.1 and ES1.2 detection
>
>Add revision detection for ES1.1 and ES1.2. Set default
>revision as ES1.2.
>
>Add CHIP_GE_OMAP3630ES1_1 to detect revisions 1.1 and later.
>This is needed for at least one feature that is broken in
>3630ES1.0 but exists on older (3430 ES3.1) and newer revisions.
>
>Additionally, update some of the CHIP_GE_* macros to use other
>macros for ease of maintenance.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Cc: Nishanth Menon <nm@ti.com>
>Cc: Manjunatha GK <manjugk@ti.com>
>[tony@atomide.com: update fallthrough handling]
>Signed-off-by: Tony Lindgren <tony@atomide.com>

compile tested with omap3_defconfig. Builds cleanly.

-- 
balbi

DefectiveByDesign.org
