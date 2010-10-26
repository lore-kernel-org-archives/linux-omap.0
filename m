From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] tidspbridge: convert OMAP3430 adaptation layer to
 use new SCM DSP boot control fns
Date: Mon, 25 Oct 2010 23:43:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010252339340.12449@utopia.booyaka.com>
References: <1287795901-28613-1-git-send-email-omar.ramirez@ti.com> <1287795901-28613-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54700 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab0JZFnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 01:43:07 -0400
In-Reply-To: <1287795901-28613-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, fernando.lugo@ti.com

Hi Omar,

On Fri, 22 Oct 2010, Omar Ramirez Luna wrote:

>  arch/arm/mach-omap2/dsp.c                     |    4 ++++
>  arch/arm/plat-omap/include/plat/dsp.h         |    4 ++++
>  drivers/staging/tidspbridge/core/tiomap3430.c |   13 ++++++-------

Could you please split the tiomap3430.c change into a separate patch?  
That should go in via the staging tree once this series is accepted.  The 
rest should go in via Tony.  Patch two needs to be acked by Kevin.


- Paul
