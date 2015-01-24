From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 16/23] ARM: OMAP4: omapdss: remove legacy pad muxing
 support
Date: Sat, 24 Jan 2015 20:06:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501242005550.5450@utopia.booyaka.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-17-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44366 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbAXUGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 15:06:15 -0500
In-Reply-To: <1417103514-17027-17-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, 27 Nov 2014, Tero Kristo wrote:

> OMAP4 is DT only now, so the legacy mux support is not needed anymore.
> Padconf is used instead from the driver / DT. This removes the need
> for having the mux APIs exported from the control module driver.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Dropping since Tomi mentioned legacy mux support is still in use.


- Paul
