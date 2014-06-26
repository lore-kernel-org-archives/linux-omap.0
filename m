From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/7] mailbox/omap: remove OMAP1 mailbox driver
Date: Fri, 27 Jun 2014 00:24:02 +0300
Message-ID: <20140626212402.GA6377@drone.musicnaut.iki.fi>
References: <1403657023-53897-1-git-send-email-s-anna@ti.com>
 <1403657023-53897-3-git-send-email-s-anna@ti.com>
 <20140626102814.GI28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:47040 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaFZVYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 17:24:10 -0400
Content-Disposition: inline
In-Reply-To: <20140626102814.GI28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Jun 26, 2014 at 03:28:14AM -0700, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [140624 17:45]:
> > There are no existing users for OMAP1 mailbox driver
> > in kernel. Commit ab6f775 "Removing dead OMAP_DSP"
> > has cleaned up all the dead code related to the only
> > possible user, including the creation of the mailbox
> > platform device.
> > 
> > Remove this stale driver so that the OMAP mailbox
> > driver can be simplified and streamlined better for
> > converting to mailbox framework.
> > 
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> For the omap1_defconfig change:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

I'm also OK with this change.

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
