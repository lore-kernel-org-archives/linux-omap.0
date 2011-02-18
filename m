From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Fri, 18 Feb 2011 11:50:50 +0200
Message-ID: <1298022650.24062.20.camel@deskari>
References: <1297952702-13419-1-git-send-email-archit@ti.com>
	 <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com>
	 <4D5E3D35.9000902@ti.com>
	 <AANLkTik119ZB8+mR-MzXHUbZdxDo966HWehE8LeCxpWZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41885 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab1BRJ4N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 04:56:13 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1I9uDPL013710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 03:56:13 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1I9uCa6002689
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 03:56:13 -0600 (CST)
In-Reply-To: <AANLkTik119ZB8+mR-MzXHUbZdxDo966HWehE8LeCxpWZ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, 2011-02-18 at 03:45 -0600, Turquette, Mike wrote:

<snip>

> PRM_IRQSTATUS_* registers will have status bits set even when the
> corresponding PRM_IRQENABLE_* bits are not set.  The common assumption
> was that status bits would not be set if interrupts weren't enabled
> and this caused us some issues in prcm_interrupt_handler some time
> back.  I don't know how DSS_IRQSTATUS works under the hood, but be
> careful of such assumptions :-)

That's how DISPC_IRQ* and DSI_IRQ* also works. But that's not what this
discussion was about =). DISPC and DSI have a shared interrupt line, and
there's a DSS_IRQSTATUS register with two bits, telling if the interrupt
was for DISPC or DSI.

 Tomi


