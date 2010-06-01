From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/5]  OMAP/ASoC: McBSP: FIFO handling related fixes
Date: Tue, 1 Jun 2010 13:30:02 +0100
Message-ID: <20100601123002.GC863@rakim.wolfsonmicro.main>
References: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35787 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755889Ab0FAMaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 08:30:04 -0400
Content-Disposition: inline
In-Reply-To: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@gmail.com, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

On Tue, Jun 01, 2010 at 02:18:19PM +0300, Peter Ujfalusi wrote:

> Changes since RFC v2:
> - Comments added explaining the changes, and documenting the API in patch2
> - In patch5:
>  - Variable names changed in the hw_rule function
>  - hw_rule function got renamed
>  - The snd_pcm_hw_rule_add calls moved so it anly got set on OMAP3

All of these look sensible enough from an ASoC point of view, though I
can't say too much about the OMAP specifics.

Acked-by: Mark Brown <broonie@opensource.wolsfonmicro.com>
