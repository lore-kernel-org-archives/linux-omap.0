From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: Make VFPv3 usable on ARMv6
Date: Thu, 1 Jul 2010 15:42:53 +0300
Message-ID: <20100701124252.GR2822@atomide.com>
References: <20100621135125.24299.91290.stgit@baageli.muru.com>
 <1277211592.29532.20.camel@e102109-lin.cambridge.arm.com>
 <20100622132037.GV12255@atomide.com>
 <20100623075703.GB12255@atomide.com>
 <1277473838.13134.30.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52325 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab0GAMmt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:42:49 -0400
Content-Disposition: inline
In-Reply-To: <1277473838.13134.30.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [100625 16:44]:
> On Wed, 2010-06-23 at 08:57 +0100, Tony Lindgren wrote:
> > MVFR0 and MVFR1 are only available starting with ARM1136 r1p0 release
> > according to "B.5 VFP changes" in DDI0211F_arm1136_r1p0_trm.pdf. This is
> > also when TLS register got added, so we can use HAS_TLS also to test for
> > MVFR0 and MVFR1.
> > 
> > Otherwise VFPFMRX and VFPFMXR access fails and we get:
> > 
> > Internal error: Oops - undefined instruction: 0 [#1]
> > PC is at no_old_VFP_process+0x8/0x3c
> > LR is at __und_svc+0x48/0x80
> > ...
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> The new version looks fine to me.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks. Added your ack and posted to Russell's patch system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6203/1

Regards,

Tony
