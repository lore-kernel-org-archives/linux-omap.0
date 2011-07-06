From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 00/20] GPIO: OMAP: driver cleanup and fixes
Date: Wed, 6 Jul 2011 10:07:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BD02914@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
 <87liwcp9z0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab1GFEh1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 00:37:27 -0400
In-Reply-To: <87liwcp9z0.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

[...]
> 
> > Test Details:
> > - Compile tested for omap1_defconfig and omap2plus_defconfig.
> > - OMAP1710-H3: Bootup test.
> > - OMAP2430-SDP, OMAP3430-SDP, OMAP4430-SDP: Functional testing.
> 
> Looks like the functional tests need to be expanded to set different
> triggering modes, since they're failing above.
I will include Zoom3 platform as well before sending out the v4.

> 
> > - PM Testing on OMAP3430-SDP: retention, off_mode, system_wide
> >   suspend and gpio wakeup.
> >
> > Following patch is required for testing retention and off-mode:
> > https://patchwork.kernel.org/patch/834372/
> > OMAP: PM: omap_device: fix device power domain callbacks
> 
> FYI... for my testI applied your series on top of my
> for_3.1/gpio-cleanups branch and then merged in my for_3.0/pm-fixes
> branch (which includes the above fix/dependency).
Ok, thanks.
--
Tarun
> 
> Kevin
