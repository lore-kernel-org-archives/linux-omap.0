From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 0/4] Add PWM polarity flag macro for DT
Date: Thu, 18 Jul 2013 10:55:56 -0600
Message-ID: <51E81E1C.20708@wwwdotorg.org>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34261 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166Ab3GRQ4A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jul 2013 12:56:00 -0400
In-Reply-To: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Tomasz Figa <t.figa@samsung.com>

On 07/17/2013 04:54 PM, Laurent Pinchart wrote:
> Hello,
> 
> Here's a small patch set that replaces PWM polarity numerical constants with
> macros in DT.

The series,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

I'm (very very) slightly hesitant about patch 3/4, since it's moving
towards all PWMs having to use the same specifier format, whereas
specifiers are at least potentially binding-specific, not
device-type-specific. However, consistency is good; there's no need to
do something different just for the heck of it. Equally, there's nothing
actually stopping a new binding from defining its own format rather than
simply deferring to pwm.txt if it absolutely has to, so I think this
will turn out fine.
