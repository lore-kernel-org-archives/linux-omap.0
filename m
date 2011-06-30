From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Thu, 30 Jun 2011 11:55:10 +0300
Message-ID: <20110630085510.GM25912@tbergstrom-lnx.Nvidia.com>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:12998 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab1F3I4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 04:56:12 -0400
Content-Disposition: inline
In-Reply-To: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "jean.pihet@newoldbits.com" <jean.pihet@newoldbits.com>
Cc: "khilman@ti.com" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

> +/*
> + * This function implements the erratum ID i581 WA:
> + *  SDRC state restore before accessing the SDRAM
> + *
> + * Only used at return from non-OFF mode. For OFF
> + * mode the ROM code configures the SDRC and
> + * the DPLL before calling the restore code directly
> + * from DDR.
> + */
> +
> +/* Make sure SDRC accesses are ok */
> +wait_sdrc_ok:
> +
> +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures this */
> +       ldr     r4, cm_idlest_ckgen
> +wait_dpll3_lock:
> +       ldr     r5, [r4]
> +       tst     r5, #1
> +       beq     wait_dpll3_lock
> +
> +       ldr     r4, cm_idlest1_core
> +wait_sdrc_ready:
> +       ldr     r5, [r4]
> +       tst     r5, #0x2
> +       bne     wait_sdrc_ready
> +       /* allow DLL powerdown upon hw idle req */
> +       ldr     r4, sdrc_power
> +       ldr     r5, [r4]
> +       bic     r5, r5, #0x40
> +       str     r5, [r4]
> +
> +/*
> + * PC-relative stores lead to undefined behaviour in Thumb-2: use a r7 as a
> + * base instead.
> + * Be careful not to clobber r7 when maintaing this code.
> + */
> +
> +is_dll_in_lock_mode:
> +       /* Is dll in lock mode? */
> +       ldr     r4, sdrc_dlla_ctrl
> +       ldr     r5, [r4]
> +       tst     r5, #0x4
> +       bne     exit_nonoff_modes       @ Return if locked
> +       /* wait till dll locks */
> +       adr     r7, kick_counter
> +wait_dll_lock_timed:
> +       ldr     r4, wait_dll_lock_counter
> +       add     r4, r4, #1
> +       str     r4, [r7, #wait_dll_lock_counter - kick_counter]
> +       ldr     r4, sdrc_dlla_status
> +       /* Wait 20uS for lock */
> +       mov     r6, #8

This was once calibrated using a scope on 3430 running from uncached
SRAM, maybe this needs to verified for 3630 or other newer OMAP3 variants.

Cheers,

Peter.
