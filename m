From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: mcbsp - add machine threshold
 callback
Date: Wed, 19 May 2010 10:37:12 +0100
Message-ID: <1274261832.3240.34.camel@odin>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	 <1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
	 <2256F256009DAA4CBE661E9F41EAC84B9145EC6A@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34033 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab0ESJhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:37:19 -0400
Received: by wwb22 with SMTP id 22so425998wwb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 02:37:17 -0700 (PDT)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B9145EC6A@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

On Tue, 2010-05-18 at 15:56 -0500, Candelaria Villarreal, Jorge wrote:
> > 
> > +int omap_bcbsp_set_threshold_func(struct snd_soc_dai *cpu_dai,
> > +             void (*mach_set_threshold)(struct
> > snd_pcm_substream *substream))
> 
> I think you meant omap_mcbsp_set_threshold_func here. 

I did indeed !

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

