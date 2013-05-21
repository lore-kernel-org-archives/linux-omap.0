From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 6/6] ARM: OMAP2+: Remove omap4 ocp2scp pdata
Date: Tue, 21 May 2013 17:23:46 +0530
Message-ID: <519B604A.9040300@ti.com>
References: <20130517191304.468.73487.stgit@localhost> <20130517191803.468.32800.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47706 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab3EULya (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 May 2013 07:54:30 -0400
In-Reply-To: <20130517191803.468.32800.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>

On Saturday 18 May 2013 12:48 AM, Tony Lindgren wrote:
> This is omap4+ only and no longer needed as omap4+ can be booted
> using device tree.
>
> Also remove the related pdata handling from the driver and the
> now unneeded platform_data/omap_ocp2scp.h.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
