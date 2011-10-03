From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 03/30] video/omap: fix build dependencies
Date: Mon, 03 Oct 2011 11:51:49 +0200
Message-ID: <6628015.ZCJR4R4V8E@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de> <1317566760-25681-4-git-send-email-arnd@arndb.de> <1317625175.2026.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57567 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1JCJv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 05:51:56 -0400
In-Reply-To: <1317625175.2026.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 03 October 2011 09:59:35 Tomi Valkeinen wrote:
> On Sun, 2011-10-02 at 16:45 +0200, Arnd Bergmann wrote:
> > Four of the LCD panel drivers depend on the backlight class,
> > so add the dependency in Kconfig.
> > Selecting the BACKLIGHT_CLASS_DEVICE symbol does not generally
> > work since it has other dependencies.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> This looks ok to me. If it's fine to you, I'll queue this patch in my
> DSS tree to prevent possible conflicts.

Yes, that's good.

Thanks,

	Arnd
