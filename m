From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
Date: Wed, 7 Nov 2012 01:53:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211070150100.8758@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com> <20121106220833.GQ6801@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45104 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2KGBxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 20:53:08 -0500
In-Reply-To: <20121106220833.GQ6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 6 Nov 2012, Tony Lindgren wrote:

> ..now wondering which configs do not build for you at 7fc54fd3?
> 
> It builds at least all my test configs. Well at least the ones
> I have recovered after accidentally deleting some files yesterday,
> did not have a back up copy of two of them.
> 
> However if I pull your branch in, build breaks for me for
> with the rmk-omap3430-ldp-noconfig and rmk-omap4430-sdp-noconfig:
> 
> arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x48): undefined reference to `omap44xx_restart'

They all build successfully here.  Here are the rmk config results:

rmk-omap3430-ldp:
http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap3430_ldp_oldconfig/

rmk-omap4430-sdp:
http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap4430_sdp_oldconfig/

Maybe the versions of the rmk configs you're using are different than 
mine?  The ones here were updated during the v3.6 -> v3.7-rc1 transition.
You can find mine at:

http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap3430_ldp_oldconfig/rmk_omap3430_ldp_oldconfig

http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap4430_sdp_oldconfig/rmk_omap4430_sdp_oldconfig


- Paul
