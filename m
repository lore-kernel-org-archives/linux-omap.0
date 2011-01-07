From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes
Date: Fri, 07 Jan 2011 15:17:05 -0800
Message-ID: <87sjx4jocu.fsf@ti.com>
References: <1294441282-17986-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44671 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751231Ab1AGXRL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 18:17:11 -0500
Received: by mail-iy0-f176.google.com with SMTP id 26so17939489iyb.21
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 15:17:10 -0800 (PST)
In-Reply-To: <1294441282-17986-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 7 Jan 2011 17:01:19 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

Nishanth Menon <nm@ti.com> writes:

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
>   omap3: beaglexm: fix power on of DVI
>
>  arch/arm/mach-omap2/board-omap3beagle.c |   37 ++++++++++++++++++++++++++----
>  1 files changed, 32 insertions(+), 5 deletions(-)
>
> v4:
>   no functional change.
>   minor cleanups in commit logs incorporating offline feedback

Thanks for the updates.  Will queue in  my fixes queue.

Kevin

> v3: http://marc.info/?t=129434384700006&r=1&w=2
> 	split up the series, addressed review comments
>
> v2: http://marc.info/?t=129276977900002&r=1&w=2
> 	Reenable the PMU stat LED
> v1: http://marc.info/?t=129172571000001&r=1&w=2
>
> Regards,
> Nishanth Menon
