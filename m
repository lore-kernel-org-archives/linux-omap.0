From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 1/3] DSPBRIDGE: fix cpufreq_register_notifier usage
Date: Fri, 11 Jun 2010 00:18:45 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CD93F@dlee03.ent.ti.com>
References: <1271895479-27744-1-git-send-email-nm@ti.com>
 <1271895479-27744-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456Ab0FKFSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 01:18:51 -0400
In-Reply-To: <1271895479-27744-2-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From: Deepak Chitriki <deepak.chitriki@ti.com>
>
>cpufreq_register_notifier() function calls
>srcu_notifier_chain_register() which always returns 0  on success and
>dspbridge throws the error message "clk_notifier_register failed for
>iva2_ck". Fix the faulty ! in if logic and the faulty error message
>we report to log.
>
>Cc: Ameya Palande <ameya.palande@nokia.com>
>Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>Cc: Deepak Chitriki <deepak.chitriki@ti.com>
>Cc: Fernando Guzman Lugo <x0095840@ti.com>
>Cc: Felipe Contreras <felipe.contreras@nokia.com>
>Cc: Hari Kanigeri <h-kanigeri2@ti.com>
>Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
>Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
>Cc: Ramesh Gupta <grgupta@ti.com>
>
>Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
>
>---
> drivers/dsp/bridge/rmgr/drv_interface.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)
>

Pushed to dspbridge.

- Omar
