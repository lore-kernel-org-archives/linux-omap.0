From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.6
Date: Mon, 1 Oct 2012 20:12:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210011957180.2160@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210011923120.2160@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54456 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2JAUMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 16:12:10 -0400
In-Reply-To: <alpine.DEB.2.00.1210011923120.2160@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 1 Oct 2012, Paul Walmsley wrote:

> Kernel size/memory differences
> ------------------------------
> 
> vmlinux object size
> (delta in bytes from test_v3.5 (28a33cbc24e4256c143dce96c7d93bf423229f92)):
>   text    data     bss   total  kernel
> +106549 +17784   +2380  +126713 2430_testconfig
> +38971   +5296    +920  +45187  5912osk_testconfig
> +98563  +30344    -316  +128591 am33xx_testconfig
> +63542  +14584   +1992  +80118  n800_b_testconfig
> +58180  +14808   +1988  +74976  n800_multi_omap2xxx
> +39388  +15672   +1960  +57020  n800_testconfig
> +49048   +5328    +920  +55296  omap1510_defconfig
> +45816   +5264    +952  +52032  omap1_defconfig
> +42090  +15360    -156  +57294  omap2_4_testconfig
> +121890 +23480   +2884  +148254 omap2plus_defconfig
> +125042 +23624   +2884  +151550 omap2plus_defconfig_cpupm
> +54593  +21360    -380  +75573  omap2plus_no_pm
> +83137  +23760    -316  +106581 omap3_4_testconfig
> +55217  +21576   +1036  +77829  omap3_testconfig
> +62061  +18840      +4  +80905  omap4_testconfig
> +86789  +21608   +1380  +109777 rmk_omap3430_ldp_oldconfig
> +96177  -14216    +208  +82169  rmk_omap4430_sdp_oldconfig

One comment about some of these vmlinux sizes.  Due to the way the configs 
are generated, the AM33xx data is being included into some of the kernels 
that shouldn't have it.  So for configs like omap3_4_testconfig or 
omap2_4_testconfig, that AM33xx data accounts for about 12K of the 'data' 
column that wasn't intended.

Kconfig handling in the scripts here needs some work; with luck, will 
address that during this development cycle.


- Paul
