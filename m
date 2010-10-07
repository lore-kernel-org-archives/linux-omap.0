From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v4 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build
 without VRFB
Date: Thu, 7 Oct 2010 14:56:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA21D050@dbde02.ent.ti.com>
References: <1286442535-28308-1-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55365 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760135Ab0JGJ0a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 05:26:30 -0400
In-Reply-To: <1286442535-28308-1-git-send-email-svadivu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Guruswamy, Senthilvadivu
> Sent: Thursday, October 07, 2010 2:39 PM
> To: tomi.valkeinen@nokia.com; Hiremath, Vaibhav; linux-
> omap@vger.kernel.org
> Cc: Guruswamy, Senthilvadivu
> Subject: [PATCH v4 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build
> without VRFB
> 
> From: Senthilvadivu Guruswamy  <svadivu@ti.com>
> 
> Please ignore the previous v3 and consider v4.
> 
> The changelog till v4 are:
> 	- Address Multi-omap build issue
> 	- Added a check to warn the wrong usage of vrfb
> 	in non-vrfb omap devices.
> 	- The patch subject is as per the naming conventions
> 	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
> 	instead of omap2/Kconfig.  The functional effect remains
> 	the same, and the place of implementation is more appropriate.
> 
Senthil,

Just a suggestion not related to patch series, you can use create this 0/x patch using git format-patch command itself, no need to manually create one.

# git format-patch --cover-letter


Thanks,
Vaibhav

> 
> Thanks,
> Senthil
