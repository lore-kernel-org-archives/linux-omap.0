From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/2] ARM: OMAP: move generic EMAC init to separate
 file
Date: Mon, 5 Mar 2012 10:19:32 -0800
Message-ID: <20120305181932.GC12083@atomide.com>
References: <1324423590-32489-1-git-send-email-yanok@emcraft.com>
 <1330593544-25411-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34539 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab2CESTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 13:19:35 -0500
Content-Disposition: inline
In-Reply-To: <1330593544-25411-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ilya Yanok <yanok@emcraft.com>

* Igor Grinberg <grinberg@compulab.co.il> [120301 00:47]:
> From: Ilya Yanok <yanok@emcraft.com>
> 
> AM35xx SoCs include DaVinci EMAC IP. Initialization code in
> board-am3517evm.c is pretty board independent and will work for any
> AM35xx based board so move this code to it's own file to be reused by
> other boards.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> v3:	- use DEFINE_RES_* macros
> 	- check error of platform_device_register()
> 	- introduce a default MDIO bus frequency define
> 
> Tony, this patch has been floating for about two months:
> http://www.spinics.net/lists/linux-omap/msg62160.html
> can it be applied for 3.4?

Yes sorry for the delays, applying this and the related
cm-t3517 patch to board branch.

Regards,

Tony
