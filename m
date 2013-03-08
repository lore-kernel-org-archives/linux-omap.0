From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/5] ASoC: OMAP2+: Update Audio IP with sDMA binding for
 DT boot
Date: Fri, 8 Mar 2013 09:25:43 +0200
Message-ID: <20130308092543.c355b2c6235c297efbe162e0@bitmer.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
	<51389023.2000907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:55445 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871Ab3CHHZZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 02:25:25 -0500
In-Reply-To: <51389023.2000907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On Thu, 7 Mar 2013 14:03:31 +0100
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Hi Sebastien,
> 
> On 03/07/2013 01:43 PM, Sebastien Guiriec wrote:
> > This patch serie is converting OMAP Audio IPs in order to use OMAP sDMA DT
> > binding in case of DT boot on OMAP2+ platforms.
> 
> The content of the patches looks about right for me, however I would squash
> together the IP and platform driver patches so we avoid breakage within the
> series. Also I would put the patch for the .dtsi files as first one.
> 
Looks ok to me too at quick look. Would it be possible to avoid possible breakage if first patch is divided to omap-pcm.h change which come before audio link driver changes and do omap-pcm.c change last?

-- 
Jarkko
