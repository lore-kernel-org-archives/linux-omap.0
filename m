From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.2-rc1 boot broken on OMAP1 / Amstrad E3
Date: Wed, 9 Nov 2011 15:19:00 -0800
Message-ID: <20111109231900.GS31337@atomide.com>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26105 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab1KIXTF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 18:19:05 -0500
Content-Disposition: inline
In-Reply-To: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [111109 14:19]:
> Hi,
> 
> Has anyone managed to boot 3.2-rc1 on OMAP1?
> 
> On Amstrad E3 it seems to hang at very early on the boot (below
> output is
> with earlyprintk enabled):
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.2.0-rc1-e3 (aaro@dell) (gcc version
> 4.6.1 (GCC) ) #1 PREEMPT Thu Nov 10 00:23:15 EET 2011
> [    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Amstrad E3 (Delta)
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writethrough
> [    0.000000] OMAP1510
> [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16
> 
> Then it prints just some random garbage and hangs.

Hmm looks like it needs a custom map_io, posting a patch just
a sec..

Tony
