From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: Error when building modules for omap2plus_defconfig in mainline
Date: Thu, 11 Oct 2012 13:29:05 +0530
Message-ID: <50767C49.8080304@ti.com>
References: <50766EEE.8000006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48277 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897Ab2JKH7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 03:59:11 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9B7x9gc022193
	for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 02:59:10 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9B7x8eZ025697
	for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 13:29:09 +0530 (IST)
In-Reply-To: <50766EEE.8000006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, peter.ujfalusi@ti.com

Hi Venkat,

On Thursday 11 October 2012 12:32 PM, Venkatraman S wrote:
> Daily build on Linus's tree is failing for the past 2-3 days
> make "modules" with omap2plus_defconfig..
>
> ERROR: "snd_hwparams_to_dma_slave_config"
> [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko]
> undefined!
> ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko]
> undefined!
> ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko]
> undefined!
> ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko]
> undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make: *** [sub-make] Error 2
>
> Just wanted to check if a fix is already on the way for -rc1 or someone
> is aware of it..

This is already fixed by Peter. Here is the patch
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-October/055902.html

Thanks
Lokesh
>
> Thanks,
> Venkat.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

