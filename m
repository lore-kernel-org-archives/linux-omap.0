From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Mon, 19 Jan 2009 09:54:29 +0200
Message-ID: <20090119095429.629b2606.jarkko.nikula@nokia.com>
References: <1231921649.13843.171.camel@eenurkka-desktop>
	<20090114152806.GP29324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41979 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZASHyo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 02:54:44 -0500
In-Reply-To: <20090114152806.GP29324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>, linux-omap@vger.kernel.org, "ext Lopez Cruz, Misael" <x0052729@ti.com>

On Wed, 14 Jan 2009 17:28:07 +0200
"ext Tony Lindgren" <tony@atomide.com> wrote:

> > You need to have the counterpart (in /sound/soc/omap/omap-mcbsp.c) for
> > that patch, othwerwise there's no chance to hear any DMA transferred
> > audio.
> 
> Jarkko, can you post the patch queued up for alsa? We might want to
> have that in linux-omap too.
> 
Patch was made by Misael and I think he is waiting until the plat-omap
part goes into mainline. And which means that OMAP3 audio is broken
until sound/soc/omap/omap-mcbsp.c is patched.

I would say that we wouldn't want to hack with sound/ directory in
linux-omap. Especially code which is not in Takashi's tree since then
we have yet another conflict point if one wants to merge from his tree
on top of linux-omap.

Probably we should revert the patch and split it into three
separate patches:

1. Header change in linux-omap adding those registers (and queue it)
2. Patch to alsa-devel setting default values to those registers
3. Patch to linux-omap writing those registers

Or better: send those two patches to LKML, cc linux-omap and alsa-devel
and let it fall down from -mm or linux-next tree.


Jarkko
