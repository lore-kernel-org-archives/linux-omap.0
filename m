From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] sound: omap: n810: fix init with DT boot
Date: Mon, 03 Mar 2014 20:41:07 +0200
Message-ID: <5314CCC3.3020604@bitmer.com>
References: <1393697317-16733-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49659 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbaCCSlU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 13:41:20 -0500
In-Reply-To: <1393697317-16733-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 03/01/2014 08:08 PM, Aaro Koskinen wrote:
> Since 3.14-rc1 only DT boot has been supported on N810. Make a minimal
> fix to retain functionality. This file should be properly converted
> to DT in longer term.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  sound/soc/omap/n810.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Right, so there is actually regression. Can you get codec to probe? I
get this when drivers are modules:

	tlv320aic3x-codec: probe of 1-0018 failed with error -16

I don't see quickly from where this -EBUSY comes but
arch/arm/mach-omap2/board-n8x0.c seems to register it since module is
loaded.

With your patch basic n810 machine driver probing works again although
audio card is not registered for me due failing codec probe.

Please resend you fix and cc maintainers Mark Brown <broonie@kernel.org>
and Liam Girdwood <lgirdwood@gmail.com>. You can add my ack

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
