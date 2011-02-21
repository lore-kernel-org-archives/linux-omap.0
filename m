From: archit taneja <archit@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Mon, 21 Feb 2011 11:33:00 +0530
Message-ID: <4D620014.3040207@ti.com>
References: <1298268030-25936-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41541 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab1BUGBS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 01:01:18 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1L61FmG012210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 00:01:18 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1L61FQ2005207
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 11:31:15 +0530 (IST)
In-Reply-To: <1298268030-25936-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Monday 21 February 2011 11:30 AM, Taneja, Archit wrote:
> Currently, the core DSS platform device requests for an irq line for OMAP2 and
> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.
>
> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
> is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.
>
> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
> DSS_IRQSTATUS register.
>
> Hence, it makes more sense to have separate irq handlers corresponding to the
> DSS sub modules instead of having a common handler.
>
> Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
> among the IRQ handlers.
>
> The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
> hwmod databases. The Probes of DISPC and DSI now request for irq handlers.
>
> Signed-off-by: Archit Taneja<archit@ti.com>
> ---
> v3:
> -return IRQ_NONE instead of IRQ_HANDLED when interrupt is not ours
> -don't print module names wehn using DSSERR
> v2: Removed checking with DSS_IRQSTATUS.
>
> v3 tested on 3430sdp with sharp ls panel and 3430sdp with a Taal panel.
>

Minor correction: Subject should have been:

[PATCH v3] OMAP: DSS2: Have separate irq handlers for DISPC and DSI

<snip>

Regards,
Archit
