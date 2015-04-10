From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
Date: Fri, 10 Apr 2015 13:37:30 -0700
Message-ID: <20150410133730.8f84b2894efcf1bde075048f@linux-foundation.org>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com>
	<20150324155916.cfd1b7ab442271466160283f@linux-foundation.org>
	<55234F25.5060708@ti.com>
	<5523820C.2010709@compulab.co.il>
	<5527894E.9000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49281 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbbDJUhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2015 16:37:31 -0400
In-Reply-To: <5527894E.9000807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, rtc-linux@googlegroups.com, Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, 10 Apr 2015 13:56:54 +0530 Keerthy <a0393675@ti.com> wrote:

> >>> How do we know that all systems have this external clock and that it
> >>> works OK?
> >>>
> >>
> >> AM335 and AM43X have the external clock feature which we choose using
> >> RTC_OSC_REG. I verified it works OK by seeing the RTC seconds ticking
> >> even after switching the source to the external 32k Clock.
> >
> > AFAIU, this is related to the external (outside of SoC) oscillator, right?
> > If so, there is a possibility to not assemble it on the board (at least
> > on AM335) and use the internal clock source instead.
> 
> Yes. The register 'OMAP_RTC_OSC_REG' is part of the RTC IP register set
> so i assumed that it would be with the RTCs of those particular SoCs.

I'm a bit lost here.  AFAICT there's a risk that some manufacturers
have not wired up the external oscillator, so this patch will break
those systems.  Do we know for sure that this cannot be the case?

Is there any way in which we can get all systems working properly?  If
there's no way of auto-detecting an external oscillator then perhaps a
module parameter is needed.  If so, it would be better if the driver
were to default to internal oscillator (ie: current behaviour), and the
module parameter selects the external oscillator.  This way, existing
systems are unaffected by the kernel upgrade.

