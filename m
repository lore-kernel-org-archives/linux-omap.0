From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 17/19] omap: Add DSI regulator supply to OMAP3EVM board
 file
Date: Fri, 12 Mar 2010 09:12:05 -0800
Message-ID: <20100312171204.GE2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
 <20100311234847.4500.24584.stgit@baageli.muru.com>
 <19F8576C6E063C45BE387C64729E7394044DD32D7B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63488 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245Ab0CLRKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 12:10:49 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DD32D7B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [100311 20:45]:
> [Hiremath, Vaibhav] Tony,
> Please use the patch below, I have fixed Mark's comments to use devname instead of dev.

Sorry, looks like I missed Mark's comments while reading the
thread at:

http://patchwork.kernel.org/patch/84823/

I can't get either of your patches to apply. Please just repost your
whole patch against the 2.6.34-rc1 with the Acked-by from Tomi.

Also, please read the mailing list instructions we have at:

http://www.elinux.org/Netiquette

Basically one patch per mail. In format that can be applied as it is.
Patches inlined, not quoted-printable. I don't want to manually re-edit
the patches, it's a complete waste of time.
 
> diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
> deleted file mode 100644
> index e69de29..0000000

And this part we don't want to apply, it's not related to this patch.

Regards,

Tony
