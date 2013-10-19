From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 03/11] ARM: OMAP3: McBSP: do not access CM register
 directly
Date: Sat, 19 Oct 2013 17:17:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191717050.11676@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48952 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab3JSRRT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:17:19 -0400
In-Reply-To: <1381508141-15244-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, 11 Oct 2013, Tero Kristo wrote:

> McBSP driver require special hacks to enable/disable the autoidle feature
> for its interface clock for the proper function of the sidetone hardware.
> Currently the driver just writes CM registers directly, which should be
> avoided. Thus, changed the driver to use the new deny/allow_autoidle
> clock API calls.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued.


- Paul
