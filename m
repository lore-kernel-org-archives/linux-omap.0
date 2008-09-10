From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] This patch fixes the typo which breaks the build on
 OMAP1
Date: Wed, 10 Sep 2008 10:18:42 +0300
Message-ID: <20080910101842.1cd49bb6.jarkko.nikula@nokia.com>
References: <dfeb90390809090040r59b401eciafb005f7d31cd398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55542 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYIJHTS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 03:19:18 -0400
In-Reply-To: <dfeb90390809090040r59b401eciafb005f7d31cd398@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <arunks@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 9 Sep 2008 13:10:59 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index a217cf2..3a4cc4b 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -96,7 +96,7 @@ static const int omap24xx_dma_reqs[][2] = {
>  #endif
>  };
>  #else
> -static const int omap2420_dma_reqs[][2] = {};
> +static const int omap24xx_dma_reqs[][2] = {};
>  #endif
> 
Thanks, this is true. Is it ok if I add this fix directly in my
original patch when I have chance to send it to alsa-devel?

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
