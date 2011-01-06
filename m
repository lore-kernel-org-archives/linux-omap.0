From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes
Date: Thu, 06 Jan 2011 14:15:23 -0800
Message-ID: <8739p5u1ac.fsf@ti.com>
References: <1294343679-10605-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37381 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754232Ab1AFWP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 17:15:29 -0500
Received: by gwaa20 with SMTP id a20so8312631gwa.21
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 14:15:28 -0800 (PST)
In-Reply-To: <1294343679-10605-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 6 Jan 2011 13:54:36 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>

Nishanth Menon <nm@ti.com> writes:

> Hi,
> As discussed in the threads:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/47807/
> http://marc.info/?t=121540030800004&r=1&w=2
>
> here is the split up series with commit message after discussion:
> http://www.beagleboard.org/irclogs/index.php?date=2011-01-06#T19:12:21
>
> Koen Kooi (3):
>   omap3: beaglexm: fix EHCI power up GPIO dir
>   omap3: beaglexm: fix DVI reset GPIO
>   omap3: beaglexm: power on DVI
>
>  arch/arm/mach-omap2/board-omap3beagle.c |   37 ++++++++++++++++++++++++++----
>  1 files changed, 32 insertions(+), 5 deletions(-)
>
> v3:
> 	split up the series, addressed review comments

Thanks, queueing for the .38-rc cycle.

Kevin

> v2: http://marc.info/?t=129276977900002&r=1&w=2
> 	Reenable the PMU stat LED
> v1: http://marc.info/?t=129172571000001&r=1&w=2
>
> Regards,
> Nishanth Menon
