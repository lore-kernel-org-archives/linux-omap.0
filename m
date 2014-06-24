From: Jyri Sarha <jsarha@TI.COM>
Subject: Re: [PATCH 3/3] ASoC: simple-card: Add system-clock-id DT parameter
 to dai nodes
Date: Tue, 24 Jun 2014 12:59:20 +0300
Message-ID: <53A94BF8.4090808@ti.com>
References: <cover.1402653217.git.jsarha@ti.com> <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com> <20140621100959.GC5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46816 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbaFXJ72 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 05:59:28 -0400
In-Reply-To: <20140621100959.GC5099@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@TI.COM, liam.r.girdwood@linux.intel.com, detheridge@TI.COM

On 06/21/2014 01:09 PM, Mark Brown wrote:
> On Fri, Jun 13, 2014 at 01:04:38PM +0300, Jyri Sarha wrote:
>> Select clk_id parameters for set_sysclk calls in the card init phase.
>
> This is making the ID defined by the drivers into ABI.  It's not clear
> that this is something we want to do, and we certainly don't want to do
> it without updating the driver bindings.  In principle what we want to
> do here is have our clocks handled by the clock API, though that's not
> trivial work.
>

I see, actually this is not something I would need anytime soon, but
how about the previous "Add system-clock-direction DT parameter to dai 
nodes" patch?

There is a clear common definitions for clock direction, so this should 
be ok, right?

If the clock direction patch would go in I would not need to add more 
stuff to already quite messy davinci-evm driver.

Best regards,
Jyri
