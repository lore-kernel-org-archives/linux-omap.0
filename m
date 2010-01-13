From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Wed, 13 Jan 2010 15:16:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001131515540.4769@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com> <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com> <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45015 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab0AMWQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 17:16:39 -0500
In-Reply-To: <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, 13 Jan 2010, Paul Walmsley wrote:

> Wouldn't this code need to enable interrupts before calling 
> omap3_sram_warmreset()?

Rather, this should have read, _disable_ interrupts...


- Paul
