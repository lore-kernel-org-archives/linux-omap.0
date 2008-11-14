From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc2-omap] H4 stops using gpio_expander_omap
Date: Thu, 13 Nov 2008 16:22:06 -0800
Message-ID: <200811131622.06269.david-b@pacbell.net>
References: <200810291443.52865.david-b@pacbell.net> <20081113211041.GD3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:32493 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754594AbYKNAWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 19:22:08 -0500
In-Reply-To: <20081113211041.GD3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 13 November 2008, Tony Lindgren wrote:
> Pushing today.

Great ... although I may send a cleanup patch, all the
definitions in this file:

> > =A0arch/arm/plat-omap/include/mach/board-h4.h | =A0 42 ++++++

can live in board-h4.c and that would improve goodness.

- dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
