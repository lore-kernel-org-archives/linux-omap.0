From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2 3/4] ARM: OMAP3: Switch to use the unified audio driver
 (omap-twl4030) for selected boards
Date: Thu, 16 Aug 2012 09:21:22 +0300
Message-ID: <502C9162.4020801@compulab.co.il>
References: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com> <1344935279-32364-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:48547 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab2HPGVa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 02:21:30 -0400
In-Reply-To: <1344935279-32364-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Benoit Cousson <b-cousson@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 08/14/12 12:07, Peter Ujfalusi wrote:
> These boards have similar audio setup and they can all use the same driver
> for audio support if it is enabled in the kernel config.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks Peter!


-- 
Regards,
Igor.
