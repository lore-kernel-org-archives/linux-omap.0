From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP3: Initialize XCCR and RCCR McBSP registers
 for McBSP DAI driver
Date: Thu, 18 Dec 2008 15:49:16 +0200
Message-ID: <20081218154916.62f4f449.jarkko.nikula@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484A4C7@dlee07.ent.ti.com>
	<20081218134137.GD30366@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17384 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYLRNtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 08:49:42 -0500
In-Reply-To: <20081218134137.GD30366@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Thu, 18 Dec 2008 15:41:37 +0200
"ext Tony Lindgren" <tony@atomide.com> wrote:

> Hi,
> 
> * Lopez Cruz, Misael <x0052729@ti.com> [081218 12:16]:
> > This patch enables XCCR and RCCR McBSP register writing in OMAP 24xx/34xx
> > platforms. It also explicitly initializes those registers to their default
> > values in ASoC McBSP DAI driver.
> 
> Can you please describe a bit what these registers do? It's impossible
> for anybody to decipher without looking at the TRM right now.
> 
Agree.

> You can do the above with cpu_class_is_omap2() instead. Might be worth
> checking that these registers are available on 2420 too.
> 
No they are not. These are new registers found in 2430 and OMAP3.

> I agree with Jarkko's comment, the ASoC change should go via alsa list
> as a separate patch.
> 
Probably -mm tree would speed up this since it requires change both in
plat-omap and sound subsystems?


Jarkko
