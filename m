From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: OMAP4: hwmod data: do not enable or reset the
 AESS during kernel init
Date: Mon, 7 Jan 2013 08:12:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301070811140.2177@utopia.booyaka.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com> <1357304526-21557-3-git-send-email-s-guiriec@ti.com> <alpine.DEB.2.00.1301041833510.25868@utopia.booyaka.com> <50E73B3D.4010705@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3AGIMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jan 2013 03:12:50 -0500
In-Reply-To: <50E73B3D.4010705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Hi

On Fri, 4 Jan 2013, Sebastien Guiriec wrote:

> Paul,
> Do you want me to rebase this version and update the serie or are you handle
> it?

Sure, it would be great if you could take this over and test it and 
repost.

You might find the 'aess_reset_devel_3.9' branch at 
git://git.pwsan.com/linux-2.6 useful.  It's a forward port of some of the 
3.5-rc work.  It's only compile-tested, so you might need to tweak it to 
get it to work.


- Paul
