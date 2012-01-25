From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: HWMOD: split omap2/3 dispc hwmod class
Date: Wed, 25 Jan 2012 12:02:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251202250.5324@utopia.booyaka.com>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com> <1327320930-14550-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40502 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab2AYTCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 14:02:39 -0500
In-Reply-To: <1327320930-14550-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk

On Mon, 23 Jan 2012, Tomi Valkeinen wrote:

> Currently OMAP2 and 3 share the same omap_hwmod_class and
> omap_hwmod_class_sysconfig for dispc. However, OMAP3 has sysconfig
> bits that OMAP2 doesn't have, so we need to split those structs into
> OMAP2 and OMAP3 specific versions.
> 
> This patch only splits the structs, without changing the contents.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for 3.3-rc.


- Paul
