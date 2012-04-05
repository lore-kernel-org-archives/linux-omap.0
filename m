From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Thu, 05 Apr 2012 14:21:26 -0700
Message-ID: <87y5q9kh7t.fsf@ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	<alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:48430 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752607Ab2DEVV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 17:21:27 -0400
Received: by dang27 with SMTP id g27so1968775dan.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 14:21:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 5 Apr 2012 04:07:42 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 5 Apr 2012, Paul Walmsley wrote:
>
>> I just rebased this series on top of v3.4-rc1 and built each patch in it 
>> successfully, so it sounds like there's some bisection-specific build 
>> problem?
>
> Okay, a quick update.  Just tried with a different .config, and can
> reproduce the following build problem with patch 2 of the IO wakeup
> series, in code that is later removed by patch 6:
>
> arch/arm/mach-omap2/pm34xx.c: In function 'omap_sram_idle':
> arch/arm/mach-omap2/pm34xx.c:281:4: error: implicit declaration of function 'omap3_reconfigure_io_chain'
>
> That's my mistake and I will correct it here and send a new pull request, 
> once we figure out what's going on with your boot hang.

I notcied this problem too when building an OMAP4-only .config and just
sent a patch: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build

Kevin


