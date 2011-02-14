From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support for
 all DPLL's
Date: Mon, 14 Feb 2011 09:51:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102140950300.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com> <813a909da6bafa7ce0c15fa77d9d25b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42194 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab1BNQvL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:51:11 -0500
In-Reply-To: <813a909da6bafa7ce0c15fa77d9d25b9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> Yes, the autogen scripts are updated, however they are
> currently in a separate branch (dpll-gatectrl).
> Will merge them into master soon.

OK, great.

> No real reason for not adding OMAP2 dpll autoidle support.
> Its just that I started off trying to do this for OMAP4, and
> then found me touching some omap3 stuff and hence
> also did it for OMAP3.(For some reason I thought there
> were no DPLL's in OMAP2).

That's fine, I have some patches in progress that enable this for the 
OMAP2 DPLL and APLLs.


- Paul
