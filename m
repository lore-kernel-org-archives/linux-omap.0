From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
Date: Mon, 25 Nov 2013 08:30:31 -0800
Message-ID: <20131125163031.GQ10023@atomide.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64451 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753453Ab3KYQai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 11:30:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [131125 07:16]:
> On Mon, 25 Nov 2013, Paul Walmsley wrote:
> 
> > Boot to userspace:
> >     FAIL ( 1/11): 37xxevm
> 
> An auto-bisect traced this to:
> 
> commit 95807689eab8441737572d1a9daaa1025429a908
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Mon Oct 14 11:31:43 2013 -0700
> 
>     ARM: OMAP2+: Remove legacy booting support for omap3 EVM
>     
>     We now have pretty decent support with the device tree
>     based booting. Patches to add more features are welcome.
>     
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> 
> So looks like this is due to the switchover to DT-based booting for 37xx 
> EVM.  Will plug that in here and re-test.

Yes. Also there's the patch missing to enable wake-up interrupts, but
that has a dependency to populating IRQ resources dynamically to avoid
nasty warnings. Both should get fixed during the -rc cycle though.

Regards,

Tony
