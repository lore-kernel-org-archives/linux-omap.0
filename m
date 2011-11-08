From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: omap2: fix build failure
Date: Tue, 08 Nov 2011 11:24:11 -0800
Message-ID: <87mxc61kpw.fsf@ti.com>
References: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59501 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753211Ab1KHTYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 14:24:17 -0500
Received: by mail-qw0-f46.google.com with SMTP id 25so825685qao.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 11:24:16 -0800 (PST)
In-Reply-To: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com> (tom
	leiming's message of "Tue, 8 Nov 2011 12:34:09 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

tom.leiming@gmail.com writes:

> From: Ming Lei <tom.leiming@gmail.com>
>
> The patch fixes the compile failure:
>
>   CC      arch/arm/mach-omap2/cpuidle34xx.o
> arch/arm/mach-omap2/cpuidle34xx.c:317:12: error: 'THIS_MODULE'
> undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> make: *** Waiting for unfinished jobs....
>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

FYI...

Tony has already queued fix for this in his fixes branch.

     http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

Kevin
