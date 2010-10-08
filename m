From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v6 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build
 without VRFB
Date: Fri, 08 Oct 2010 12:52:23 +0300
Message-ID: <1286531543.28499.1072.camel@tubuntu.research.nokia.com>
References: <1286520273-4892-1-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:40409 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776Ab0JHJw2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 05:52:28 -0400
In-Reply-To: <1286520273-4892-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "hvaibhav@ti.com" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2010-10-08 at 08:44 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> The changelog till v6 are:
> 	- Address Multi-omap build issue
> 	- Added a check to warn the wrong usage of vrfb 
> 	in non-vrfb omap devices.
> 	- The patch subject is as per the naming conventions
> 	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
> 	instead of omap2/Kconfig.  The functional effect remains
> 	the same, and the place of implementation is more appropriate.
> 	- Provide details of non-vrfb devices in commit description in patch 3/3
> 	- Removed extra paranthesis in cpu checks
> 

Thanks, looks fine to me. Applied to DSS2 tree.

 Tomi


