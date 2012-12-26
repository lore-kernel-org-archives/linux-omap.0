From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
Date: Wed, 26 Dec 2012 20:49:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212262048470.2706@utopia.booyaka.com>
References: <20121209200108.3196.12452.stgit@dusk.lan> <20121209200327.3196.27686.stgit@dusk.lan> <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60999 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2LZUt1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 15:49:27 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, 26 Dec 2012, Bedia, Vaibhav wrote:

> In case of AM33xx, this flag should be set for PER and WKUP pwrdms also.
> EMIF, L3, L4 etc come under PER so this domain can't transition on an active
> system. PRCM and Control module come under WKUP, so the WKUP should the kernel
> should attempt to transition WKUP domain also.

Thanks - the patch has been updated to reflect this.

- Paul
