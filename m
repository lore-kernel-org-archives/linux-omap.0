From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/5] Split powerdomain framework into plat
 specific/independent
Date: Wed, 1 Dec 2010 13:09:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012011254460.2515@utopia.booyaka.com>
References: <1291131848-31640-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52758 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab0LAUJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 15:09:30 -0500
In-Reply-To: <1291131848-31640-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com


Hi,

thanks for making the requested changes.  However, this series results in 
compilation warnings:

  CC      arch/arm/mach-omap2/powerdomain2xxx_3xxx.o
arch/arm/mach-omap2/powerdomains.h:116: warning: 'powerdomains_omap' 
defined but not used
  CC      arch/arm/mach-omap2/powerdomain44xx.o
arch/arm/mach-omap2/powerdomains.h:116: warning: 'powerdomains_omap' 
defined but not used


and sparse warnings:


WARNING: externs should be avoided in .c files
#115: FILE: arch/arm/mach-omap2/powerdomain-common.c:50:
+int _get_mem_bank_onstate_mask(u8 bank);

WARNING: externs should be avoided in .c files
#116: FILE: arch/arm/mach-omap2/powerdomain-common.c:51:
+int _get_mem_bank_retst_mask(u8 bank);

WARNING: externs should be avoided in .c files
#117: FILE: arch/arm/mach-omap2/powerdomain-common.c:52:
+int _get_mem_bank_stst_mask(u8 bank);


Please fix these and re-send.


regards

- Paul
