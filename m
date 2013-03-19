From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc1
Date: Tue, 19 Mar 2013 05:47:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303190540130.11826@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46175 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab3CSFrC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 01:47:02 -0400
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

here's the restated delta from v3.8 -> v3.9-rc1, after some script bug 
fixes.

On Tue, 12 Mar 2013, Paul Walmsley wrote:

> vmlinux object size
> (delta in bytes from test_v3.8 (19f949f52599ba7c3f67a5897ac6be14bfcb1200)):
>    text     data      bss    total  kernel
> +195310   +37968    +1364  +234642  omap2plus_defconfig
> +185362   +37128    +1364  +223854  omap2plus_defconfig_cpupm
> +186719   +31416    +1300  +219435  omap2plus_defconfig_omap2_4_only
> +181125   +41432    +1300  +223857  omap2plus_defconfig_omap3_4_only
>  +10460   +10272    +1184   +21916  rmk_omap3430_ldp_allnoconfig
>  +40867   +14672     +972   +56511  rmk_omap4430_sdp_oldconfig
> 
> Looks like v3.9 is well on target to exceed even the previous 
> per-release bloat records.
> 
> There are some entries missing from the above table; this is probably due 
> to some bug in my scripts that needs to be dealt with.

And here's the correct results.

vmlinux object size
(delta in bytes from test_v3.8 
(19f949f52599ba7c3f67a5897ac6be14bfcb1200)):
   text     data      bss    total  kernel
-557629   +23472    -9252  -543409  n800_multi_omap2xxx
-557204   +26680    -9280  -539804  n800_only_a
 +49056    +2992     +424   +52472  omap1_defconfig_1510innovator_only
+195310   +37968    +1364  +234642  omap2plus_defconfig
+185362   +37128    +1364  +223854  omap2plus_defconfig_cpupm
+192610   +36304    +1364  +230278  omap2plus_defconfig_no_pm
+186719   +31416    +1300  +219435  omap2plus_defconfig_omap2_4_only
+181125   +41432    +1300  +223857  omap2plus_defconfig_omap3_4_only
 +10460   +10272    +1184   +21916  rmk_omap3430_ldp_allnoconfig
 +40004   +27640     +788   +68432  rmk_omap3430_ldp_oldconfig
 +10348   +10272    +1296   +21916  rmk_omap4430_sdp_allnoconfig
 +40867   +14672     +972   +56511  rmk_omap4430_sdp_oldconfig

The massive decrease in N800 kernel size is a result of an all-out attempt 
to keep the kernel booting on N800, which has a 2MB kernel size limitation 
in the bootloader.

Same crazy bloat in the OMAP2+ kernels, and it's probably due to the 
CONFIG_ARCH_MULTIPLATFORM changes.  Hey, at least we don't have to worry 
about supporting embedded use-cases any more on ARM ;-)


- Paul
