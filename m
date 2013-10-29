From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap4-panda: add DPI pinmuxing
Date: Tue, 29 Oct 2013 14:25:05 -0700
Message-ID: <20131029212505.GJ15154@atomide.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <526F8ADA.3030003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65026 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab3J2VZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 17:25:10 -0400
Content-Disposition: inline
In-Reply-To: <526F8ADA.3030003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131029 03:16]:
> Hi Tony,
> 
> On 25/10/13 13:07, Tomi Valkeinen wrote:
> > New u-boot versions no longer set the pinmuxing for Panda's DPI output,
> > and the muxing has to be done in the .dts file.
> > 
> > Add pinmuxing for DPI and TFP410. Without these, the DVI output on Panda
> > does not work with recent u-boot.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> The two latter patches in this series needs more work and can be
> dropped, but this one should be applied to make Panda work properly with
> new u-boots.

OK I'll pick this patch into omap-for-v3.13/dt.

Regards,

Tony
