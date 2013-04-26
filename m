From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: Add muxing for wl12xx on the SDIO bus for
 blaze
Date: Fri, 26 Apr 2013 09:32:59 +0300
Message-ID: <1366957979.4029.17.camel@cumari.coelho.fi>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
	 <20130426035216.26065.32776.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab3DZGeY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 02:34:24 -0400
In-Reply-To: <20130426035216.26065.32776.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> This should work assuming the board-4430sdp.c works, but it seems
> that I don't have the "1283 PG 2.21 connectivity device" on
> my blaze. Anybody got a spare connectivity device for blaze?
> 
> Also, if somebody has the schematics, please provide a patch
> for the missing GPIO muxes for blaze, see the the panda for
> what's currently missing.
> 
> Cc: Luciano Coelho <coelho@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Tested-by: Luciano Coelho <coelho@ti.com>

-- 
Luca.

