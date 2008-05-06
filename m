From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: public git l2 cache off.
Date: Tue, 6 May 2008 07:38:59 +0200
Message-ID: <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:45112 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbYEFFkQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2008 01:40:16 -0400
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 6 mei 2008, om 01:27 heeft Woodruff, Richard het volgende geschreven:
> Hi,
>
> Looks like a tweak from the ARM or TI tree may be needed.  Builds of  
> recent pulls of the OMAP3 kernel show L2 cache is disabled. This  
> really has a huge performance impact.
>
> I don't have time right now to suggest a patch but may look some  
> time this week.  TI internal kernels do have it enabled.
>
> A stop in Lauterbach and a look at the L2EN bit in AUX control  
> register will show it is not correct.

Enabling L2 cache was removed from proc-v7.S since was cortex specific  
instead of armv7 specific and u-boot explicitly turns of L2 before  
booting into linux. I made a reverse patch, but my omap3 board doesn't  
boot if I use it:

- --- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -665,6 +665,12 @@ config CPU_CACHE_ROUND_ROBIN
           Say Y here to use the predictable round-robin cache  
replacement
           policy.  Unless you specifically require this or are  
unsure, say N.

+config CPU_L2CACHE_DISABLE
+       bool "Disable level 2 cache"
+       depends on CPU_V7
+       help
+         Say Y here to disable the level 2 cache.  If unsure, say N.
+
  config CPU_BPREDICT_DISABLE
         bool "Disable branch prediction"
         depends on CPU_ARM1020 || CPU_V6 || CPU_XSC3 || CPU_V7
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a1d7331..432ddab 100644
- --- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -181,6 +181,16 @@ __v7_setup:
         mcr     p15, 0, r4, c2, c0, 1           @ load TTB1
         mov     r10, #0x1f                      @ domains 0, 1 =  
manager
         mcr     p15, 0, r10, c3, c0, 0          @ load domain access  
register
+#ifndef CONFIG_CPU_L2CACHE_DISABLE
+       @ L2 cache configuration in the L2 aux control register
+       mrc     p15, 1, r10, c9, c0, 2
+       bic     r10, r10, #(1 << 16)            @ L2 outer cache
+       mcr     p15, 1, r10, c9, c0, 2
+       @ L2 cache is enabled in the aux control register
+       mrc     p15, 0, r10, c1, c0, 1
+       orr     r10, r10, #2
+       mcr     p15, 0, r10, c1, c0, 1
+#endif
  #endif
         adr     r5, v7_crval
         ldmia   r5, {r5, r6}

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIH+71MkyGM64RGpERAu1EAKCLF8Id735bHUovuZzn56koZw/YywCfb31G
KiN6OiMd1EkOBPa76Ogo+zs=
=R9mv
-----END PGP SIGNATURE-----
