From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes
Date: Thu, 6 Jan 2011 20:57:45 +0100
Message-ID: <57D491AC-1370-455D-B425-FB047EB70634@beagleboard.org>
References: <1294343679-10605-1-git-send-email-nm@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46261 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab1AFT6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 14:58:09 -0500
Received: by wwi17 with SMTP id 17so17371747wwi.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 11:58:07 -0800 (PST)
In-Reply-To: <1294343679-10605-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>

Thanks for splitting it up! Now I can work on the patches for xM rev C where the pins changed again :)

Op 6 jan 2011, om 20:54 heeft Nishanth Menon het volgende geschreven:

> Hi,
> As discussed in the threads:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
> http://marc.info/?t=121540030800004&r=1&w=2
> 
> here is the split up series with commit message after discussion:
> http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21
> 
> Koen Kooi (3):
>  omap3: beaglexm: fix EHCI power up GPIO dir
>  omap3: beaglexm: fix DVI reset GPIO
>  omap3: beaglexm: power on DVI
> 
> arch/arm/mach-omap2/board-omap3beagle.c |   37 ++++++++++++++++++++++++++----
> 1 files changed, 32 insertions(+), 5 deletions(-)
> 
> v3:
> 	split up the series, addressed review comments
> 
> v2: http://marc.info/?t=129276977900002&r=1&w=2
> 	Reenable the PMU stat LED
> v1: http://marc.info/?t=129172571000001&r=1&w=2
> 
> Regards,
> Nishanth Menon

