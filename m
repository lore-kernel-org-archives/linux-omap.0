From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP1: usb: fix sparse warnings
Date: Fri, 26 Oct 2012 21:29:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262129051.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com> <20121026212059.GV11908@atomide.com> <alpine.DEB.2.00.1210262125410.11258@utopia.booyaka.com> <20121026212841.GW11908@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41166 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025Ab2JZV3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 17:29:35 -0400
In-Reply-To: <20121026212841.GW11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On Fri, 26 Oct 2012, Tony Lindgren wrote:

> Looks like it's not urgent for the -rc series, so let's not
> introduce more self-inflicted merge conflicts. If that's OK
> with you, I can apply it to omap-for-v3.8/cleanup-headers
> without the header changes.

Yep that's fine, better to avoid creating unnecessary merge conflicts for 
sure.  Just sent the version against omap-for-v3.8/cleanup-headers...


- Paul
