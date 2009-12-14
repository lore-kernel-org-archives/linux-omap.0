From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Padconf not working on pm_defconfig?
Date: Mon, 14 Dec 2009 15:36:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F0F@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33421 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755399AbZLNKGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 05:06:10 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Gupta, Ajay Kumar wrote:
> > 
> > I'm seeing some strange behavior with linux-omap-pm branch
> > and possibly with linux-omap master as well. I booted up
> > a 3430 SDP with an image built using omap3_pm_defconfig.
> > (I enabled EHCI in the menuconfig).
> 
> Check if CONFIG_OMAP_MUX=y set.
> 

It's set.

Also, dumping the registers just after the usb-echi.c makes
these mux calls shows they are okay.

Something seems to be changing these later - debugging now.

- Anand
