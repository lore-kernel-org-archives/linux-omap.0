From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2] ASoC: omap-pcm: Free dma buffers in case of error.
Date: Wed, 25 Apr 2012 17:18:45 +0100
Message-ID: <1335370725.29563.0.camel@odin>
References: <1335319322-22336-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34129 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752736Ab2DYQSu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 12:18:50 -0400
Received: by wibhm17 with SMTP id hm17so245309wib.15
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 09:18:47 -0700 (PDT)
In-Reply-To: <1335319322-22336-1-git-send-email-oleg.matcovschi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Matcovschi <oleg.matcovschi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de

On Tue, 2012-04-24 at 19:02 -0700, Oleg Matcovschi wrote:
> Change-Id: I4ba9de0de4681332539246ccc5e11a7a8fb32e79
> Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> ---
> v1:
>  initial revision
> v2:
>  resending patch including maintainers
> 
>  sound/soc/omap/omap-pcm.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 

Now applied for 3.4 with change ID removed.

Thanks

Liam

