From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: Split plat/hardware.h, introduce local
 hardware.h and soc.h for omap2+
Date: Thu, 6 Sep 2012 15:03:46 +0800
Message-ID: <20120906070344.GB22330@opensource.wolfsonmicro.com>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
 <20120901002622.23715.68557.stgit@muffinssi.local>
 <20120901002753.GA21451@opensource.wolfsonmicro.com>
 <20120901020654.GT1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33736 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223Ab2IFHDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 03:03:53 -0400
Content-Disposition: inline
In-Reply-To: <20120901020654.GT1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Fri, Aug 31, 2012 at 07:06:54PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [120831 17:28]:

> > There's a topic/omap branch in ASoC which you can pull in to help reduce
> > conflicts, or I could merge this there if that's sensible.

> Thanks. Did not see it yet at git://opensource.wolfsonmicro.com/linux-2.6-asoc,
> maybe it's not yet pushed out?

Nobody said to apply it in ASoC and it was part of a series.  If people
want me to apply it directly to the OMAP branch please let me know (a
resend would help...).
