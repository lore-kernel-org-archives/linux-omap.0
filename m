From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm: Fix mounting root on omaps with CPU_V6 and CPU_V7
Date: Wed, 17 Mar 2010 18:07:57 +0000
Message-ID: <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
References: <20100317175731.GE2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36676 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752594Ab0CQSIJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Mar 2010 14:08:09 -0400
In-Reply-To: <20100317175731.GE2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2010-03-17 at 17:57 +0000, Tony Lindgren wrote:
> Here's an updated version of this patch with more details.
> 
> Looks like VFPv3 is only available on V7:
> 
> http://www.arm.com/products/processors/technologies/vector-floating-point.php

But does it cause any problem if the feature is enabled in the kernel?
The vfp_init() code should check for its presence and set the hwcap
accordingly.

Ideally, we should fix the VFP handling code to cope with dynamic
detection.

> HAS_TLS reg is only on ARM11 starting with r1p0:
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html
> 
> So that explains why it won't work on omap2420 as it's r0p2.

Same here, would it work with dynamic detection?

I would like to get v6+v7 support working fine together on RealView
boards as well (though not much spare time) but without disabling the
features that are present on v7 if they can be detected at run-time.

-- 
Catalin

