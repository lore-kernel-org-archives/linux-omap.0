From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP4: hwmod data: do not enable or reset the
 AESS during kernel init
Date: Fri, 4 Jan 2013 18:35:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301041833510.25868@utopia.booyaka.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com> <1357304526-21557-3-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46961 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab3ADSfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 13:35:47 -0500
In-Reply-To: <1357304526-21557-3-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Hi Sebastien

On Fri, 4 Jan 2013, Sebastien Guiriec wrote:

> The AESS on OMAP4 has additional register on top of SYS_CONFIG for
> auto gatting configuration. In order to avoid running clock after
> boot up we should avoid to enable and reset the module during boot up.
> 
> Audio driver will be in charge of configuring the addition register.
> 
> At its core, this patch is a workaround for an OMAP hardware problem.
> It should be possible to configure the OMAP with good default reset
> configuration of AESS IP for auto gatting mode.
> 
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>

What do you think about a slightly modified and updated version of:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69853.html

?  That way we can reset the IP block at startup, like most of our other 
IP blocks, to avoid previous OS and bootloader dependencies.


- Paul
