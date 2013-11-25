From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
Date: Mon, 25 Nov 2013 15:15:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38675 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab3KYPPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 10:15:41 -0500
In-Reply-To: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, 25 Nov 2013, Paul Walmsley wrote:

> Boot to userspace:
>     FAIL ( 1/11): 37xxevm

An auto-bisect traced this to:

commit 95807689eab8441737572d1a9daaa1025429a908
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Oct 14 11:31:43 2013 -0700

    ARM: OMAP2+: Remove legacy booting support for omap3 EVM
    
    We now have pretty decent support with the device tree
    based booting. Patches to add more features are welcome.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>


So looks like this is due to the switchover to DT-based booting for 37xx 
EVM.  Will plug that in here and re-test.
  

- Paul
