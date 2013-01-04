From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: hwmod: rename flag to prevent hwmod
 code from touching IP block during init
Date: Fri, 4 Jan 2013 18:19:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301041817460.25868@utopia.booyaka.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com> <1357304526-21557-2-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46910 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab3ADSTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 13:19:55 -0500
In-Reply-To: <1357304526-21557-2-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Hi Sebastien

On Fri, 4 Jan 2013, Sebastien Guiriec wrote:

> Rename HWMOD_EXT_OPT_MAIN_CLK flag to indicate that this IP block is
> dependent on an off-chip functional clock that is not guaranteed to
> be present during initialization. Same flag can be use for IP with
> additional HW registers to control Auto IDLE mode.
> 
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>

We already have the HWMOD_NO_INIT_RESET flag.  Wouldn't that accomplish 
the same goal?

Also I think we can reset the AESS during init.  I posted a patch for this 
a few months ago, but looks like it got lost.  Will reply to one of your 
other patches with more details.


- Paul
