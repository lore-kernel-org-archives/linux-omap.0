From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2]  McBSP preamble patch for 34xx support,
Date: Fri, 8 Aug 2008 13:05:52 +0300
Message-ID: <20080808100551.GQ24923@atomide.com>
References: <63331.192.168.10.89.1218175375.squirrel@dbdmail.itg.ti.com> <20080808125301.9b18c596.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56123 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbYHHKF5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 06:05:57 -0400
Content-Disposition: inline
In-Reply-To: <20080808125301.9b18c596.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext chandra shekhar <x0044955@ti.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080808 12:54]:
> On Fri, 8 Aug 2008 11:32:55 +0530 (IST)
> "ext chandra shekhar" <x0044955@ti.com> wrote:
> 
> > Hi,
> > 
> > This a preamble patch series for McBSP support on OAMP34xx. it adds
> > few register definitions and and base addresses for all the McBSP
> > instances. It also modifies read/write functions to do 16/32 ops
> > depending on CPU. It doesn't add any functionality.
> > 
> Hi
> 
> There's line wrapping on these two patches:
> 
> Subject: [PATCH 1/2]  McBSP preamble patch for 34xx support,
> Subject:  [ Resending PATCH 2/2]  McBSP preamble patch for 34xx support
> 
> patching file arch/arm/mach-omap2/mcbsp.c
> patching file include/asm-arm/arch-omap/mcbsp.h
> patch: **** malformed patch at line 182: defined(CONFIG_ARCH_OMAP730)
> 
> patching file arch/arm/plat-omap/mcbsp.c
> patching file include/asm-arm/arch-omap/mcbsp.h
> patch: **** malformed patch at line 117: OMAP_MCBSP_REG_##reg)
> 
> They apply by correcting them manually and don't break ASoC on N810 :-)

OK, pushing today after manually editing them to apply. BTW, Chandra,
can you start sending your patches in format that apply directly with
git-am? That way I don't have to edit each patch manually to remove
the mail body.

You can easily generate patches in the right format from your git branch
with git-show --pretty=email some_commit_id.

Thanks,

Tony
