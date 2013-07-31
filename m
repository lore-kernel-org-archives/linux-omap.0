From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Wed, 31 Jul 2013 00:57:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307310055090.22504@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <51EE5C13.1000004@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43932 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab3GaA5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 20:57:48 -0400
In-Reply-To: <51EE5C13.1000004@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Austin <jonathan.austin@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 23 Jul 2013, Jonathan Austin wrote:

> I've just had a quick go at booting 3.11-rc2 on an integrator-cp (1136) in the
> hope that we might be able to reproduce this on those boards, but I'm afraid
> the integrator works...
> 
> I took your config, modified it as little as possible to switch to Integrator
> and turn on earlyprintk, and then tried to boot. That *did* require switching
> away from ARCH_MULTIPLATFORM, so it isn't as similar as I'd like, though...
> 
> So I think we can at least say that this is not 1136 specific... Sorry not to
> be more helpful...

Just saw this message - thanks for the test.  What 1136 variant does the 
Integrator-CP have in it?  Would assume an r1 or later?


- Paul
