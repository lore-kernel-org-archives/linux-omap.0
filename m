From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] mailbox/omap: remove OMAP1 mailbox driver
Date: Thu, 26 Jun 2014 03:28:14 -0700
Message-ID: <20140626102814.GI28884@atomide.com>
References: <1403657023-53897-1-git-send-email-s-anna@ti.com>
 <1403657023-53897-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40562 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbaFZK2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 06:28:15 -0400
Content-Disposition: inline
In-Reply-To: <1403657023-53897-3-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>

* Suman Anna <s-anna@ti.com> [140624 17:45]:
> There are no existing users for OMAP1 mailbox driver
> in kernel. Commit ab6f775 "Removing dead OMAP_DSP"
> has cleaned up all the dead code related to the only
> possible user, including the creation of the mailbox
> platform device.
> 
> Remove this stale driver so that the OMAP mailbox
> driver can be simplified and streamlined better for
> converting to mailbox framework.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Suman Anna <s-anna@ti.com>

For the omap1_defconfig change:

Acked-by: Tony Lindgren <tony@atomide.com>
