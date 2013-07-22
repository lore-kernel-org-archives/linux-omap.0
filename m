From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Mon, 22 Jul 2013 19:43:26 +0100
Message-ID: <20130722184325.GA21614@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38112 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629Ab3GVSne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 14:43:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jul 22, 2013 at 06:07:47PM +0000, Paul Walmsley wrote:
> After Linus's commit fb2af0020a51709ad87ea8055c325d3fbde04158 ("Merge 
> branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm"), the 
> OMAP2430 SDP here stopped booting.
> 
> Here's the bootlog at the commit before the merge, commit 790eac5640:
> 
> http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130722015454/
> 
> and here's a log at commit fb2af0020a5:
> 
> http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130722005921/
> 
> Any ideas as to what might have caused this?

Bear in mind that I'm almost at the point of not boot-testing anything
I sent to Linus because of the uselessness of the SDP4430 board now
that it's DT only - the only platform which boot-tests anything I send
is the 3430LDP board now.  If people care about that, maybe they can
assist with sorting out the issues I've raised on these lists about
the SDP4430 - and why the SDP4430 build remains disabled in my build
and boot system.

Looking at the boot log, it just stops after uboot hands over control.
With the lack of output from the decompressor, it's not possible to
tell whether it's a decompressor problem or a kernel problem.

I think you need to turn on the LL_DEBUG option, select the appropriate
output option, and also get the decompressor to use the kernel's debug
io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).
