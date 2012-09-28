From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: linux-next ASOC build break ? (Was... Re: Help needed with remaining
 plat headers)
Date: Fri, 28 Sep 2012 12:37:06 +0530
Message-ID: <CAMQu2gzPC62SWn+aVPpEc6vngF=m5fofPxwgECAtWURoSLDiCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45348 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751134Ab2I1HH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 03:07:28 -0400
Received: by vcbfo13 with SMTP id fo13so2986313vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 00:07:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, "Vutla, Lokesh" <lokeshvutla@ti.com>

+ Peter, Liam in case they haven't seen the issue yet.

On Fri, Sep 28, 2012 at 12:28 PM, Vutla, Lokesh <lokeshvutla@ti.com> wrote:
> Hi,
> I see a module build failure in linux-next tree.
> Any one else facing this issue or I am missing something.
> Using master branch on
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> Below is the log .
>
> $ make modules -j 10
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   LD [M]  drivers/video/omap2/dss/omapdss.o
>   Building modules, stage 2.
[..]

>   MODPOST 45 modules
> ERROR: "snd_hwparams_to_dma_slave_config"
> [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>
