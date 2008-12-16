From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fix dpll4_m4_ck clk_set_rate()
Date: Mon, 15 Dec 2008 16:27:57 -0800
Message-ID: <20081216002757.GJ19551@atomide.com>
References: <1228742209-23540-1-git-send-email-tomi.valkeinen@nokia.com> <alpine.DEB.2.00.0812112255450.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58299 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbYLPA17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 19:27:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812112255450.26754@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [081211 21:56]:
> On Mon, 8 Dec 2008, Tomi Valkeinen wrote:
> 
> > This fixes commit e42218d45afbc3e654e289e021e6b80c657b16c2. The commit
> > was based on old kernel tree, and with bad luck applied ok but to wrong
> > position, modifying dpll4_m6_ck instead of dpll4_m4_ck.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing to l-o tree today.

Tony
