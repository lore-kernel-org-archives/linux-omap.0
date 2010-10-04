From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH] omap: devices: Avoid merge conflict
 between ASoC and OMAP hwmod changes
Date: Mon, 04 Oct 2010 20:49:24 +0100
Message-ID: <1286221764.3148.135.camel@odin>
References: <1286193893-22131-1-git-send-email-jhnikula@gmail.com>
	 <20101004150442.GC1505@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63123 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874Ab0JDTtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 15:49:25 -0400
Received: by wwj40 with SMTP id 40so4609458wwj.1
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 12:49:24 -0700 (PDT)
In-Reply-To: <20101004150442.GC1505@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Mon, 2010-10-04 at 08:04 -0700, Mark Brown wrote:
> On Mon, Oct 04, 2010 at 03:04:53PM +0300, Jarkko Nikula wrote:
> > Upcoming ASoC multi-component and OMAP hwmod changes will conflict
> > in arch/arm/mach-omap2/devices.c. Avoid this by moving a little bit
> > include statement introduced by ASoC Multi-Component Support patch.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

