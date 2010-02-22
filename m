From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv5 0/2] McBSP: OMAP3: Add sidetone feature
Date: Mon, 22 Feb 2010 14:39:28 +0000
Message-ID: <20100222143928.GA2133@rakim.wolfsonmicro.main>
References: <1266841272-13135-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60468 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752955Ab0BVOja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Feb 2010 09:39:30 -0500
Content-Disposition: inline
In-Reply-To: <1266841272-13135-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, tony@atomide.com, eduardo.valentin@nokia.com, ext-Eero.Nurkkala@nokia.com

On Mon, Feb 22, 2010 at 02:21:10PM +0200, Ilkka Koskinen wrote:
> The first patch implements McBSP sidetone feature on OMAP3 while the second
> one provides ALSA interface for using it.
> 
> The patch set is based on the patch Eduardo Valentin sent to alsa-devel
> mailing list in October 2009. Channel gain control and enabling the sidetone
> have been moved to ALSA interface as suggested in comments. 
> 
> These patches apply on top of Janusz Krzysztofik's McBSP register cache
> patches in linux-omap-2.6.git

Both patches

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

too.
