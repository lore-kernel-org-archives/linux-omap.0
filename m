From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/26] ARM: OMAP2+: add omapdss_init_of()
Date: Fri, 13 Dec 2013 09:07:39 -0800
Message-ID: <20131213170739.GB28184@atomide.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1386160133-24026-6-git-send-email-tomi.valkeinen@ti.com>
 <2199639.FbGhznOLP9@avalon>
 <52A96603.5030709@ti.com>
 <52AAC615.504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61658 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752119Ab3LMRHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 12:07:42 -0500
Content-Disposition: inline
In-Reply-To: <52AAC615.504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

* Archit Taneja <archit@ti.com> [131213 00:33]:
> 
> I have seen other OMAP drivers passing control module register info
> to their DT node. Instead of having a pinmux driver for a single
> register, we might want to consider just passing the control module
> register, and take care of the reg fields and masks in the OMAP DSI
> driver itself.

See the PBIAS control module patches and their comments from Balaji.

We can map the misc registers of SCM using drivers/mfd/syscon.c and
that way drivers can access them via syscon.

Regards,

Tony
