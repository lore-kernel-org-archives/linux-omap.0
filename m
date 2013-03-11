From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to generic
 DMA DT binding
Date: Mon, 11 Mar 2013 20:29:23 +0200
Message-ID: <513E2283.5000100@bitmer.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com> <1362988223-22455-3-git-send-email-s-guiriec@ti.com> <513DE7BB.90303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:55487 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149Ab3CKS3m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 14:29:42 -0400
In-Reply-To: <513DE7BB.90303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-1?Q?Beno=EE?= =?ISO-8859-1?Q?t_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 03/11/2013 04:18 PM, Peter Ujfalusi wrote:
> On 03/11/2013 08:50 AM, Sebastien Guiriec wrote:
>> Update OMAP2+ driver in order to use OMAP DMA DT binding for OMAP2+.
>> In case of DT boot snd_dmaengine_generic_pcm_open function is used.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
