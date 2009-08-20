From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv5 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 20 Aug 2009 19:15:42 +0300
Message-ID: <20090820191542.bc7b0d4d.jhnikula@gmail.com>
References: <1250774523-7950-1-git-send-email-eduardo.valentin@nokia.com>
	<20090820143017.GH12309@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:43194 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbZHTQOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 12:14:08 -0400
In-Reply-To: <20090820143017.GH12309@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Takashi Iwai <tiwai@suse.de>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thu, 20 Aug 2009 17:30:18 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Eduardo Valentin <eduardo.valentin@nokia.com> [090820 16:36]:
> > Hello guys,
> > 
> > I've updated this series after some previous confusion from my side.
> > 
> > Now that all dependencies are merged (Janusz's patches and Jarkko's patch),
> > I've based this series on Takashi's tree (master branch).
> > 
Mark: Set applies and works (with Beagle) on top of both master and
topic/asoc branches.

> > I've also talked with Tony and he agrees to have this changes merged
> > by alsa tree. And as pointed by Jarkko, the mcbsp code is currently
> > used only by Audio inside OMAP code. So, that should be safe.
> 
> You might want to merge patches 5 and 6 together as 5 adds the
> fifo, then 6 limits it's size. But in general, for patches
> 1 - 14: Acked-by: Tony Lindgren <tony@atomide.com>
>  
15-20: Acked-by: Jarkko Nikula <jhnikula@gmail.com>


-- 
Jarkko
