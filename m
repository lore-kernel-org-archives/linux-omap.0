From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Thu, 28 Mar 2013 09:57:53 -0700
Message-ID: <20130328165752.GX10155@atomide.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
 <51546259.3000704@compulab.co.il>
 <51547462.3070803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13475 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab3C1Q54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 12:57:56 -0400
Content-Disposition: inline
In-Reply-To: <51547462.3070803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130328 09:53]:
> On 2013-03-28 17:31, Igor Grinberg wrote:
> > On 03/28/13 14:48, Tomi Valkeinen wrote:
> > 
> > I've missed this discussion, can you please point to it?
> 
> Well, not so much discussion, but a few mails under "Display related
> board specific boot args" subject on l-o. I proposed a board specific
> kernel argument to select the displays present, Tony was less than
> enthusiastic about that.

If we can come up with a Linux generic command line option to select
the panel that can be supported also in the long run, I have no
objections to that naturally. What I'm against is a temporary
custom cmdline option until the board-*.c files go away as we
don't want to support it in the long run.

Regards,

Tony
