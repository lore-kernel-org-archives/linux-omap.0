From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 17 Feb 2012 13:23:18 -0800
Message-ID: <20120217212318.GG18185@atomide.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
 <20120216121234.GJ15338@n2100.arm.linux.org.uk>
 <4F3CF7D1.8050807@ti.com>
 <4F3D0186.2010500@ti.com>
 <20120216135151.GK15338@n2100.arm.linux.org.uk>
 <20120217091433.GL15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13205 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab2BQVXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 16:23:24 -0500
Content-Disposition: inline
In-Reply-To: <20120217091433.GL15338@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120217 00:43]:
> 
> Tony: I think there's a bug here - if the gpio-twl4030 module is inserted,
> removed and re-inserted, I think we'll end up creating the devices for MMC
> twice with the same name, resulting in sysfs complaining very loudly.

I guess you mean without splitting omap2_hsmmc_init() into two functions.
Yup that's a nasty surprise that should be fixed for the -rc series.

Regards,

Tony
