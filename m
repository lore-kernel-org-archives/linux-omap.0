From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/2]  McBSP preamble patch for 34xx support,
Date: Fri, 8 Aug 2008 12:53:01 +0300
Message-ID: <20080808125301.9b18c596.jarkko.nikula@nokia.com>
References: <63331.192.168.10.89.1218175375.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62977 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYHHJxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 05:53:22 -0400
In-Reply-To: <63331.192.168.10.89.1218175375.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 8 Aug 2008 11:32:55 +0530 (IST)
"ext chandra shekhar" <x0044955@ti.com> wrote:

> Hi,
> 
> This a preamble patch series for McBSP support on OAMP34xx. it adds
> few register definitions and and base addresses for all the McBSP
> instances. It also modifies read/write functions to do 16/32 ops
> depending on CPU. It doesn't add any functionality.
> 
Hi

There's line wrapping on these two patches:

Subject: [PATCH 1/2]  McBSP preamble patch for 34xx support,
Subject:  [ Resending PATCH 2/2]  McBSP preamble patch for 34xx support

patching file arch/arm/mach-omap2/mcbsp.c
patching file include/asm-arm/arch-omap/mcbsp.h
patch: **** malformed patch at line 182: defined(CONFIG_ARCH_OMAP730)

patching file arch/arm/plat-omap/mcbsp.c
patching file include/asm-arm/arch-omap/mcbsp.h
patch: **** malformed patch at line 117: OMAP_MCBSP_REG_##reg)

They apply by correcting them manually and don't break ASoC on N810 :-)


Jarkko
