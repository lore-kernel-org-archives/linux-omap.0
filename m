From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Fri, 17 Aug 2012 16:14:36 +0300
Message-ID: <502E43BC.30708@bitmer.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com> <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com> <20120817130723.GZ11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46111 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2HQNOu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 09:14:50 -0400
In-Reply-To: <20120817130723.GZ11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

On 08/17/2012 04:07 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
>> On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
>> the FIFO for the audio stack.
> Is this the case also for 2420? I thought some only had a FIFO at
> one port?
> 
IRCC (I don't have specs), nope. Only 2430 (as noted by Peter) and
onwards have FIFO.

But that's true that FIFO sizes differ between the ports. E.g. only
ports 2 and 3 have 1024+128 deep FIFOs in OMAP3.

-- 
Jarkko
