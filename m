From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2 00/17] OMAP3: PM: Smartreflex and voltage revamp.
Date: Thu, 18 Mar 2010 14:15:24 -0500
Message-ID: <4BA27BCC.60404@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60009 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab0CRTP0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 15:15:26 -0400
In-Reply-To: <1268903755-4151-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Gopinath, Thara had written, on 03/18/2010 04:15 AM, the following:
[..]

> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
> and is dependent on the following patches not yet applied onto this branch.
> 
> 	http://patchwork.kernel.org/patch/81504/
> 	http://patchwork.kernel.org/patch/81606/
The 2nd patch does not seem to apply anymore

see [1] - no more sysc_flags as it was queued to .34-rcX?

-- 
Regards,
Nishanth Menon
Ref:
[1] 
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=arch/arm/plat-omap/include/plat/omap_hwmod.h;h=440b4164f2f65e8557713ce9fff2636ed02fe523;hb=pm-wip-opp#l258
