From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 1/4] arch: arm: gpmc: gpmc migration support
Date: Wed, 6 Feb 2013 11:38:57 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA6E6A3@DBDE01.ent.ti.com>
References: <1358933176-12409-1-git-send-email-avinashphilip@ti.com>
 <1358933176-12409-2-git-send-email-avinashphilip@ti.com>
 <20130201220510.GY22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56633 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab3BFLkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 06:40:09 -0500
In-Reply-To: <20130201220510.GY22517@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Sat, Feb 02, 2013 at 03:35:10, Tony Lindgren wrote:
> * Philip Avinash <avinashphilip@ti.com> [130123 01:28]:
> > With recent GPMC driver conversion, usage of gpmc_save/restore_context
> > can done from gpmc driver itself. Hence removes the usage from pm34xx.c.
> > Also removes the conditional compilation primitives ARCH_OMAP3 for
> > gpmc_save/restore_context.
> 
> Hmm I think this will break GPMC for deeper idle modes. Note that we
> need to save and restore the context every time hitting off-idle, not
> just for suspend and resume. Or am I missing something here?

I understand dependency on idle modes. So I will send a second version
with this patch eliminated so that user initiated suspend/resume work
for am335x platforms.

Thanks
Avinash

> 
> Regards,
> 
> Tony
> 

