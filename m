From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: TWL4030: Only update the needed bits in
 *set_dai_sysclk
Date: Mon, 19 Oct 2009 13:55:08 +0100
Message-ID: <20091019125507.GA1417@rakim.wolfsonmicro.main>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
 <1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
 <1255956140-4829-3-git-send-email-peter.ujfalusi@nokia.com>
 <1255956140-4829-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33354 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751389AbZJSMzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Oct 2009 08:55:05 -0400
Content-Disposition: inline
In-Reply-To: <1255956140-4829-4-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, tony@atomide.com

On Mon, Oct 19, 2009 at 03:42:19PM +0300, Peter Ujfalusi wrote:

> +	apll_ctrl = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
> +	apll_ctrl &= ~TWL4030_APLL_INFREQ;
>  	switch (freq) {

I'll apply this - it's idiomatic for the current driver - but you might
want to look at snd_soc_update_bits() which does a read/modify/write
cycle for you.
