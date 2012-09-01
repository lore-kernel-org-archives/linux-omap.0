From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: Split plat/hardware.h, introduce local
 hardware.h and soc.h for omap2+
Date: Fri, 31 Aug 2012 17:27:54 -0700
Message-ID: <20120901002753.GA21451@opensource.wolfsonmicro.com>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
 <20120901002622.23715.68557.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:32808 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755309Ab2IAA17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 20:27:59 -0400
Content-Disposition: inline
In-Reply-To: <20120901002622.23715.68557.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Fri, Aug 31, 2012 at 05:26:22PM -0700, Tony Lindgren wrote:
> As the plat and mach includes need to disappear for single zImage work,
> we need to remove plat/hardware.h.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

There's a topic/omap branch in ASoC which you can pull in to help reduce
conflicts, or I could merge this there if that's sensible.
