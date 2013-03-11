From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to
 generic DMA DT binding
Date: Mon, 11 Mar 2013 09:27:00 -0700
Message-ID: <20130311162700.GI26093@atomide.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
 <20130311143303.GC10617@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16175 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753530Ab3CKQ1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 12:27:06 -0400
Content-Disposition: inline
In-Reply-To: <20130311143303.GC10617@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [130311 07:37]:
> On Mon, Mar 11, 2013 at 08:50:22AM +0100, Sebastien Guiriec wrote:
> > Update OMAP2+ driver in order to use OMAP DMA DT binding for OMAP2+.
> > In case of DT boot snd_dmaengine_generic_pcm_open function is used.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> or I can apply to ASoC if people prefer, I don't think it makes much
> difference either way.

I suggest you take the driver changes and Benoit takes the .dts
changes as those should be queued separately to avoid unnecessary
merge conflicts with the .dts files.

Regards,

Tony
