From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Fix dpll4_m4_ck clk_set_rate()
Date: Thu, 11 Dec 2008 22:56:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812112255450.26754@utopia.booyaka.com>
References: <1228742209-23540-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46795 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbYLLF4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 00:56:04 -0500
In-Reply-To: <1228742209-23540-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, 8 Dec 2008, Tomi Valkeinen wrote:

> This fixes commit e42218d45afbc3e654e289e021e6b80c657b16c2. The commit
> was based on old kernel tree, and with bad luck applied ok but to wrong
> position, modifying dpll4_m6_ck instead of dpll4_m4_ck.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
