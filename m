From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Mon, 22 Jul 2013 20:07:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48217 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab3GVUHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 16:07:06 -0400
In-Reply-To: <20130722184325.GA21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 22 Jul 2013, Russell King - ARM Linux wrote:

> Bear in mind that I'm almost at the point of not boot-testing anything
> I sent to Linus because of the uselessness of the SDP4430 board now
> that it's DT only - the only platform which boot-tests anything I send
> is the 3430LDP board now.  If people care about that, maybe they can
> assist with sorting out the issues I've raised on these lists about
> the SDP4430 - and why the SDP4430 build remains disabled in my build
> and boot system.

I understand completely...

> Looking at the boot log, it just stops after uboot hands over control.
> With the lack of output from the decompressor, it's not possible to
> tell whether it's a decompressor problem or a kernel problem.
> 
> I think you need to turn on the LL_DEBUG option, select the appropriate
> output option, and also get the decompressor to use the kernel's debug
> io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).

OK, will dig deeper here at the next opportunity.


- Paul
