From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 07/11] ARM: OMAP2+: CM: AM43x clockdomain data
Date: Mon, 30 Sep 2013 11:09:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309301107150.17980@utopia.booyaka.com>
References: <cover.1380179370.git.afzal@ti.com> <a6758751113ef93bc912ccefb9cdb0ba383f19d5.1380179370.git.afzal@ti.com> <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com> <52495B03.3050006@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44159 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab3I3LJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Sep 2013 07:09:45 -0400
In-Reply-To: <52495B03.3050006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Ambresh K <ambresh@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>

Hi

On Mon, 30 Sep 2013, Afzal Mohammed wrote:

> > The references to "wkup_pwrdm" on some of these clockdomains don't 
> > look right to me.  For example, this clockdomain is listed as being in 
> > AM43XX_CM_WKUP_INST, but its enclosing powerdomain is listed as being in 
> > AM43XX_PRM_WKUP_INST.  Looks to me like it's best to have two different 
> > wakeup powerdomains: one CM_WKUP, and one PRM_WKUP.
> 
> On AM43x, prcm is a single block as in AM335x and is part of wakeup
> domain. This is different from OMAP4 that had separate prm and cm
> blocks. Script also generated the same output.

Why are there two different address offsets for CM_WKUP and PRM_WKUP?  
>From another patch in the series:

+#define AM43XX_PRM_WKUP_INST                           0x2000

...

+#define AM43XX_CM_WKUP_INST                            0x2800



- Paul
