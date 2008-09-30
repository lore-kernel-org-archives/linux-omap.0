From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 20/23] twl4030-gpio: irq and other cleanup
Date: Mon, 29 Sep 2008 19:36:06 -0700
Message-ID: <200809291936.06611.david-b@pacbell.net>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <200809291730.46154.david-b@pacbell.net> <20080930003900.GK2445@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:20689 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750889AbYI3CgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 22:36:09 -0400
In-Reply-To: <20080930003900.GK2445@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Monday 29 September 2008, Felipe Balbi wrote:
> couldn't this be done by set_type() so you could use
> set_irq_type(irq, IRQF_VALID); ?

No; type is for trigger modes (edges, levels).

