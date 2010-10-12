From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ASoC: OMAP4: MCPDM: Remove unnecessary include of
 plat/control.h
Date: Tue, 12 Oct 2010 09:06:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010120905570.16871@utopia.booyaka.com>
References: <1286890078-32610-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49365 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab0JLPGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 11:06:31 -0400
In-Reply-To: <1286890078-32610-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>

On Tue, 12 Oct 2010, Anand Gadiyar wrote:

> Commit 346a5c890 (OMAP: control: move plat-omap/control.h
> to mach-omap2/control.h) in the linux-omap tree removed
> plat/control.h and most of its callers. This one slipped
> through - breaking the build as below when
> CONFIG_SND_OMAP_SOC_MCPDM is defined. Fix this.
> 
>   CC      sound/soc/omap/omap-mcpdm.o
> sound/soc/omap/omap-mcpdm.c:35: fatal error: plat/control.h: No such file or directory
> compilation terminated.
> make[3]: *** [sound/soc/omap/omap-mcpdm.o] Error 1
> make[2]: *** [sound/soc/omap] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Misael Lopez Cruz <misael.lopez@ti.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> This break is reproducible on linux-next as of 20101011;
> I think it also exists in mainline, but I did not check.
> 
> Probably worth taking this through the ALSA tree with Tony
> or Paul's ack. 

Acked-by: Paul Walmsley <paul@pwsan.com>

thanks Anand,


- Paul
