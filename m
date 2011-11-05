From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: PRCM/SCM/hwmod miscellaneous fixes for
 3.2
Date: Fri, 4 Nov 2011 17:40:24 -0700
Message-ID: <20111105004024.GO31337@atomide.com>
References: <alpine.DEB.2.00.1110070318120.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53539 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751561Ab1KEAk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 20:40:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110070318120.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111007 01:45]:
> Hi Tony,
> 
> The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> 
>   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 prcm_scm_misc_fixes_3.2

Pulling into fixes.

Tony
 
> Abhilash K V (1):
>       ARM: OMAP: AM35x: remove hwmods that aren't generic
> 
> Archit Taneja (1):
>       ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields
> 
>  .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   13 ++++++++-----
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> 
> - Paul
