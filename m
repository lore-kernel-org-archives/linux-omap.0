From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Legacy support for wl12xx when booted
 with devicetree
Date: Fri, 26 Apr 2013 09:32:40 +0300
Message-ID: <1366957960.4029.16.camel@cumari.coelho.fi>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
	 <20130426035210.26065.39995.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60740 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622Ab3DZGeH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 02:34:07 -0400
In-Reply-To: <20130426035210.26065.39995.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> Without WLAN we cannot switch omap4 to use device tree
> only booting. This patch can be reverted when the
> binding for wl12xx is added.
> 
> Cc: Luciano Coelho <coelho@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Tested-by: Luciano Coelho <coelho@ti.com>

-- 
Luca.

