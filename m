Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC115E5DC;
	Sun, 24 May 2026 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779602557; cv=none; b=swK25bLlglLd4dECaa2G9vYhcBDC2DHG75mhTMypQo29seg+ccYPuRvrYcewN/1wMKcoweX5uEMu4ppvVoR1wkWFi+hPNFNQ4+O4HdgyhZbH3mXaw45KN2mA2S9oVya+T5rKsX4vqv/14wiZJCyGX3RkKcM9/rnKfRqgyzjAlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779602557; c=relaxed/simple;
	bh=Y/K12480Lw3U1Qcp/YL64sDFWrZspJv5mav39q01dc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB/QxWAvMrQuFOZeW5mmgaOiIBLxK6Tw7oqN+1MFKT8fdJE3cvcCSceOhS6CJW+NiP7a+GtQcpwRP5cTTU3pwavj39OKNt3YJheZn7DfsFVjuprZbFeeXYY3xZEJ1PwUNxZRblbEXSx+17libnuVisLiUr6aPBzVwc4HyLR+6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaV1zCj/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaV1zCj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779602554; x=1811138554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/K12480Lw3U1Qcp/YL64sDFWrZspJv5mav39q01dc8=;
  b=FaV1zCj/QK8/kK97r3J86nhc/j5TUcT/pJtH1iJkMUzjwsULtzn8H5WY
   Kdw/6oplvCVjX1uU3fJ8TAGK2OpPu922P6u6ho6c8raZ56UAWCYDcaBAT
   mH/KN/ZDkLpsjmCROf2nm7qjhG7txmoGRbts1Yq9V0fMi0lN6WblrYuhB
   dhGZcf7fhOL1PHT2s8QFzjZQPdfBJNfKA6/TDMwPAD+2l/xA1qutxtdBQ
   dzWLJmZhsegFBLY35DzhFB1LuTPrR5AJZqIPNiz+XjSG8U64VHXKmuaPn
   3AadgWrSrQiJBg+T15e2UvDrG6/CeIJZZwMS4ueXXaPc68dF1QzIaOOPS
   A==;
X-CSE-ConnectionGUID: YUSMOkfGQmyhAzDf7BiwBQ==
X-CSE-MsgGUID: Vb6aZZhRTBySFgzVOGIhHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="105927633"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="105927633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 23:02:33 -0700
X-CSE-ConnectionGUID: z3bZdwcWS5yUR9pJTnYVog==
X-CSE-MsgGUID: WObBaoFZRUKgB5v6k3TvLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="241161211"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 May 2026 23:02:30 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wR1us-000000000kr-3VMm;
	Sun, 24 May 2026 06:02:26 +0000
Date: Sun, 24 May 2026 14:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: Mithil Bavishi <bavishimithil@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mithil Bavishi <bavishimithil@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Message-ID: <202605241332.fXvCYBR2-lkp@intel.com>
References: <20260522233036.12277-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522233036.12277-1-bavishimithil@gmail.com>

Hi Mithil,

kernel test robot noticed the following build errors:

[auto build test ERROR on tmlind-omap/for-next]
[also build test ERROR on linus/master v7.1-rc4 next-20260522]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mithil-Bavishi/ARM-OMAP2-Add-CFI-type-for-omap4_finish_suspend/20260523-073206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
patch link:    https://lore.kernel.org/r/20260522233036.12277-1-bavishimithil%40gmail.com
patch subject: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260524/202605241332.fXvCYBR2-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260524/202605241332.fXvCYBR2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605241332.fXvCYBR2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm/mach-omap2/sleep44xx.S:61:1: error: invalid instruction
   SYM_TYPED_FUNC_START(omap4_finish_suspend)
   ^


vim +61 arch/arm/mach-omap2/sleep44xx.S

    33	
    34	/*
    35	 * =============================
    36	 * == CPU suspend finisher ==
    37	 * =============================
    38	 *
    39	 * void omap4_finish_suspend(unsigned long cpu_state)
    40	 *
    41	 * This function code saves the CPU context and performs the CPU
    42	 * power down sequence. Calling WFI effectively changes the CPU
    43	 * power domains states to the desired target power state.
    44	 *
    45	 * @cpu_state : contains context save state (r0)
    46	 *	0 - No context lost
    47	 * 	1 - CPUx L1 and logic lost: MPUSS CSWR
    48	 * 	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
    49	 *	3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
    50	 * @return: This function never returns for CPU OFF and DORMANT power states.
    51	 * Post WFI, CPU transitions to DORMANT or OFF power state and on wake-up
    52	 * from this follows a full CPU reset path via ROM code to CPU restore code.
    53	 * The restore function pointer is stored at CPUx_WAKEUP_NS_PA_ADDR_OFFSET.
    54	 * It returns to the caller for CPU INACTIVE and ON power states or in case
    55	 * CPU failed to transition to targeted OFF/DORMANT state.
    56	 *
    57	 * omap4_finish_suspend() calls v7_flush_dcache_all() which doesn't save
    58	 * stack frame and it expects the caller to take care of it. Hence the entire
    59	 * stack frame is saved to avoid possible stack corruption.
    60	 */
  > 61	SYM_TYPED_FUNC_START(omap4_finish_suspend)
    62		stmfd	sp!, {r4-r12, lr}
    63		cmp	r0, #0x0
    64		beq	do_WFI				@ No lowpower state, jump to WFI
    65	
    66		/*
    67		 * Flush all data from the L1 data cache before disabling
    68		 * SCTLR.C bit.
    69		 */
    70		bl	omap4_get_sar_ram_base
    71		ldr	r9, [r0, #OMAP_TYPE_OFFSET]
    72		cmp	r9, #0x1			@ Check for HS device
    73		bne	skip_secure_l1_clean
    74		mov	r0, #SCU_PM_NORMAL
    75		mov	r1, #0xFF			@ clean seucre L1
    76		stmfd   r13!, {r4-r12, r14}
    77		ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
    78		DO_SMC
    79		ldmfd   r13!, {r4-r12, r14}
    80	skip_secure_l1_clean:
    81		bl	v7_flush_dcache_all
    82	
    83		/*
    84		 * Clear the SCTLR.C bit to prevent further data cache
    85		 * allocation. Clearing SCTLR.C would make all the data accesses
    86		 * strongly ordered and would not hit the cache.
    87		 */
    88		mrc	p15, 0, r0, c1, c0, 0
    89		bic	r0, r0, #(1 << 2)		@ Disable the C bit
    90		mcr	p15, 0, r0, c1, c0, 0
    91		isb
    92	
    93		bl	v7_invalidate_l1
    94	
    95		/*
    96		 * Switch the CPU from Symmetric Multiprocessing (SMP) mode
    97		 * to AsymmetricMultiprocessing (AMP) mode by programming
    98		 * the SCU power status to DORMANT or OFF mode.
    99		 * This enables the CPU to be taken out of coherency by
   100		 * preventing the CPU from receiving cache, TLB, or BTB
   101		 * maintenance operations broadcast by other CPUs in the cluster.
   102		 */
   103		bl	omap4_get_sar_ram_base
   104		mov	r8, r0
   105		ldr	r9, [r8, #OMAP_TYPE_OFFSET]
   106		cmp	r9, #0x1			@ Check for HS device
   107		bne	scu_gp_set
   108		mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
   109		ands	r0, r0, #0x0f
   110		ldreq	r0, [r8, #SCU_OFFSET0]
   111		ldrne	r0, [r8, #SCU_OFFSET1]
   112		mov	r1, #0x00
   113		stmfd   r13!, {r4-r12, r14}
   114		ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
   115		DO_SMC
   116		ldmfd   r13!, {r4-r12, r14}
   117		b	skip_scu_gp_set
   118	scu_gp_set:
   119		mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
   120		ands	r0, r0, #0x0f
   121		ldreq	r1, [r8, #SCU_OFFSET0]
   122		ldrne	r1, [r8, #SCU_OFFSET1]
   123		bl	omap4_get_scu_base
   124		bl	scu_power_mode
   125	skip_scu_gp_set:
   126		mrc	p15, 0, r0, c1, c1, 2		@ Read NSACR data
   127		tst	r0, #(1 << 18)
   128		mrcne	p15, 0, r0, c1, c0, 1
   129		bicne	r0, r0, #(1 << 6)		@ Disable SMP bit
   130		mcrne	p15, 0, r0, c1, c0, 1
   131		isb
   132		dsb
   133	#ifdef CONFIG_CACHE_L2X0
   134		/*
   135		 * Clean and invalidate the L2 cache.
   136		 * Common cache-l2x0.c functions can't be used here since it
   137		 * uses spinlocks. We are out of coherency here with data cache
   138		 * disabled. The spinlock implementation uses exclusive load/store
   139		 * instruction which can fail without data cache being enabled.
   140		 * OMAP4 hardware doesn't support exclusive monitor which can
   141		 * overcome exclusive access issue. Because of this, CPU can
   142		 * lead to deadlock.
   143		 */
   144		bl	omap4_get_sar_ram_base
   145		mov	r8, r0
   146		mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
   147		ands	r5, r5, #0x0f
   148		ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]	@ Retrieve L2 state from SAR
   149		ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]	@ memory.
   150		cmp	r0, #3
   151		bne	do_WFI
   152	#ifdef CONFIG_PL310_ERRATA_727915
   153		mov	r0, #0x03
   154		mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
   155		DO_SMC
   156	#endif
   157		bl	omap4_get_l2cache_base
   158		mov	r2, r0
   159		ldr	r0, =0xffff
   160		str	r0, [r2, #L2X0_CLEAN_INV_WAY]
   161	wait:
   162		ldr	r0, [r2, #L2X0_CLEAN_INV_WAY]
   163		ldr	r1, =0xffff
   164		ands	r0, r0, r1
   165		bne	wait
   166	#ifdef CONFIG_PL310_ERRATA_727915
   167		mov	r0, #0x00
   168		mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
   169		DO_SMC
   170	#endif
   171	l2x_sync:
   172		bl	omap4_get_l2cache_base
   173		mov	r2, r0
   174		mov	r0, #0x0
   175		str	r0, [r2, #L2X0_CACHE_SYNC]
   176	sync:
   177		ldr	r0, [r2, #L2X0_CACHE_SYNC]
   178		ands	r0, r0, #0x1
   179		bne	sync
   180	#endif
   181	
   182	do_WFI:
   183		bl	omap_do_wfi
   184	
   185		/*
   186		 * CPU is here when it failed to enter OFF/DORMANT or
   187		 * no low power state was attempted.
   188		 */
   189		mrc	p15, 0, r0, c1, c0, 0
   190		tst	r0, #(1 << 2)			@ Check C bit enabled?
   191		orreq	r0, r0, #(1 << 2)		@ Enable the C bit
   192		mcreq	p15, 0, r0, c1, c0, 0
   193		isb
   194	
   195		/*
   196		 * Ensure the CPU power state is set to NORMAL in
   197		 * SCU power state so that CPU is back in coherency.
   198		 * In non-coherent mode CPU can lock-up and lead to
   199		 * system deadlock.
   200		 */
   201		mrc	p15, 0, r0, c1, c0, 1
   202		tst	r0, #(1 << 6)			@ Check SMP bit enabled?
   203		orreq	r0, r0, #(1 << 6)
   204		mcreq	p15, 0, r0, c1, c0, 1
   205		isb
   206		bl	omap4_get_sar_ram_base
   207		mov	r8, r0
   208		ldr	r9, [r8, #OMAP_TYPE_OFFSET]
   209		cmp	r9, #0x1			@ Check for HS device
   210		bne	scu_gp_clear
   211		mov	r0, #SCU_PM_NORMAL
   212		mov	r1, #0x00
   213		stmfd   r13!, {r4-r12, r14}
   214		ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
   215		DO_SMC
   216		ldmfd   r13!, {r4-r12, r14}
   217		b	skip_scu_gp_clear
   218	scu_gp_clear:
   219		bl	omap4_get_scu_base
   220		mov	r1, #SCU_PM_NORMAL
   221		bl	scu_power_mode
   222	skip_scu_gp_clear:
   223		isb
   224		dsb
   225		ldmfd	sp!, {r4-r12, pc}
   226	SYM_FUNC_END(omap4_finish_suspend)
   227	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
