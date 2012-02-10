From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: Fix build error in sound/soc/omap/n810.c
Date: Fri, 10 Feb 2012 12:10:36 +0200
Message-ID: <4F34ED1C.3010300@bitmer.com>
References: <1328856877.27353.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:44443 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758630Ab2BJKKA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 05:10:00 -0500
In-Reply-To: <1328856877.27353.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org

On 02/10/2012 08:54 AM, Axel Lin wrote:
> Fix below build error which is introduced by
> commit 022658 "ASoC: core: Add support for DAI and machine kcontrols".
> 
>   CC [M]  sound/soc/omap/n810.o
> sound/soc/omap/n810.c: In function 'n810_set_input':
> sound/soc/omap/n810.c:194: error: 'codec' undeclared (first use in this function)
> sound/soc/omap/n810.c:194: error: (Each undeclared identifier is reported only once
> sound/soc/omap/n810.c:194: error: for each function it appears in.)
> sound/soc/omap/n810.c:188: warning: unused variable 'card'
> make[3]: *** [sound/soc/omap/n810.o] Error 1
> make[2]: *** [sound/soc/omap] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/omap/n810.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
