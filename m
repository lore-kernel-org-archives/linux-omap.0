From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ASoC: omap-pcm: Free dma buffers in case of error.
Date: Wed, 25 Apr 2012 11:55:39 +0300
Message-ID: <4F97BC0B.1030508@ti.com>
References: <1335319322-22336-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:45784 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753932Ab2DYIzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 04:55:31 -0400
Received: by lahj13 with SMTP id j13so1389924lah.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 01:55:29 -0700 (PDT)
In-Reply-To: <1335319322-22336-1-git-send-email-oleg.matcovschi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Matcovschi <oleg.matcovschi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, jarkko.nikula@bitmer.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de

On 04/25/2012 05:02 AM, Oleg Matcovschi wrote:
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

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
