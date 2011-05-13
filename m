From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: set the core dpll clk rate in its set_rate
 function.
Date: Thu, 12 May 2011 20:17:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105122015550.26192@utopia.booyaka.com>
References: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46492 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1EMCRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 22:17:18 -0400
In-Reply-To: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shweta Gulati <shweta.gulati@ti.com>, Rajendra Nayak <rnayak@ti.com>, tony@atomide.com

On Mon, 9 May 2011, Avinash.H.M wrote:

> The debug l3_ick/rate is not displaying the actual rate of the clock in
> hardware. This is because, the core dpll set_rate function doesn't update the
> clk.rate. After fixing, the l3_ick/rate is displaying proper values.
> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Wamsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Thanks, let's see if we can get this into an -rc.


- Paul
