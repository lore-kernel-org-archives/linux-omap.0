From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Sun, 19 Aug 2012 23:57:41 -0700
Message-ID: <20120820065740.GK11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
 <20120817130723.GZ11011@atomide.com>
 <502E43BC.30708@bitmer.com>
 <502E4F2B.6060403@ti.com>
 <20120818060810.GH11011@atomide.com>
 <CAPo=G1w5N5GVra7TK=En9xnaFmNNP1Zb7g2tZSjg8CO8wewOwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25880 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2HTG5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Aug 2012 02:57:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPo=G1w5N5GVra7TK=En9xnaFmNNP1Zb7g2tZSjg8CO8wewOwA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Ujfalusi, Peter <peter.ujfalusi@ti.com> [120818 08:58]:
> Hi Tony,
> 
> On Sat, Aug 18, 2012 at 8:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Thanks, is this patch still correct so it does not try to enable FIFO
> > for 2420?
> 
> Yes it only enables the FIFO for 2430, 2420 is not affected.

OK thanks for the clarification.

Tony
