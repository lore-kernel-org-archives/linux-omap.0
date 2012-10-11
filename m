From: Venkatraman S <svenkatr@ti.com>
Subject: Error when building modules for omap2plus_defconfig in mainline
Date: Thu, 11 Oct 2012 12:32:06 +0530
Message-ID: <50766EEE.8000006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2JKHCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 03:02:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9B72ArP013433
	for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 02:02:11 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9B72941007756
	for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 12:32:10 +0530 (IST)
Received: from [172.24.81.152] (smtpvbd.itg.ti.com [172.24.170.250])	by
 dbdp33.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9B727To027153	for
 <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 12:32:08 +0530
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Daily build on Linus's tree is failing for the past 2-3 days
make "modules" with omap2plus_defconfig..

ERROR: "snd_hwparams_to_dma_slave_config" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2

Just wanted to check if a fix is already on the way for -rc1 or someone is aware of it..

Thanks,
Venkat.


