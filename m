From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/2] arm: Make VFPv3 usable on ARMv6
Date: Fri, 25 Jun 2010 14:50:38 +0100
Message-ID: <1277473838.13134.30.camel@e102109-lin.cambridge.arm.com>
References: <20100621135125.24299.91290.stgit@baageli.muru.com>
	 <1277211592.29532.20.camel@e102109-lin.cambridge.arm.com>
	 <20100622132037.GV12255@atomide.com>  <20100623075703.GB12255@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33001 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753750Ab0FYNup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 09:50:45 -0400
In-Reply-To: <20100623075703.GB12255@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, 2010-06-23 at 08:57 +0100, Tony Lindgren wrote:
> MVFR0 and MVFR1 are only available starting with ARM1136 r1p0 release
> according to "B.5 VFP changes" in DDI0211F_arm1136_r1p0_trm.pdf. This is
> also when TLS register got added, so we can use HAS_TLS also to test for
> MVFR0 and MVFR1.
> 
> Otherwise VFPFMRX and VFPFMXR access fails and we get:
> 
> Internal error: Oops - undefined instruction: 0 [#1]
> PC is at no_old_VFP_process+0x8/0x3c
> LR is at __und_svc+0x48/0x80
> ...
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

The new version looks fine to me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

