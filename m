From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] tlv320aic31xx PLL programming fix and cleanup
Date: Wed, 3 Sep 2014 16:13:36 +0300
Message-ID: <54071400.7070408@ti.com>
References: <cover.1409747234.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385AbaICNNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 09:13:49 -0400
In-Reply-To: <cover.1409747234.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com

On 09/03/2014 03:52 PM, Jyri Sarha wrote:
> The first patch is the fix and the second is only a cleanup.
> 
> Jyri Sarha (2):
>   ASoC: tlv320aic31xx: Fix 24bit samples with I2S format and 12MHz mclk
>   ASoC: tlv320aic31xx: Choose PLL p divider automatically
> 
>  sound/soc/codecs/tlv320aic31xx.c |  128 +++++++++++++++++++++++---------------
>  1 file changed, 77 insertions(+), 51 deletions(-)

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

