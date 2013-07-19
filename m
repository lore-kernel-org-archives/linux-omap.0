From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/4] Add PWM polarity flag macro for DT
Date: Fri, 19 Jul 2013 13:29:13 +0200
Message-ID: <10033310.z2U2FSCElN@avalon>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51E81E1C.20708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46601 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab3GSL21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 07:28:27 -0400
In-Reply-To: <51E81E1C.20708@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Tomasz Figa <t.figa@samsung.com>

Hi Stephen,

On Thursday 18 July 2013 10:55:56 Stephen Warren wrote:
> On 07/17/2013 04:54 PM, Laurent Pinchart wrote:
> > Hello,
> > 
> > Here's a small patch set that replaces PWM polarity numerical constants
> > with macros in DT.
> 
> The series,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> I'm (very very) slightly hesitant about patch 3/4, since it's moving towards
> all PWMs having to use the same specifier format, whereas specifiers are at
> least potentially binding-specific, not device-type-specific. However,
> consistency is good; there's no need to do something different just for the
> heck of it. Equally, there's nothing actually stopping a new binding from
> defining its own format rather than simply deferring to pwm.txt if it
> absolutely has to, so I think this will turn out fine.

Exactly, that's why I don't think it's an issue. pwm.txt defines a common 
format, individual bindings are free to use it or not.

Thierry, if you're fine with the patches, could you take them in your tree 
with Stephen's Reviewed-by, or should I report them and send you a pull 
request ?

-- 
Regards,

Laurent Pinchart

