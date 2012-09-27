From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: ARM: OMAP: fix new sparse warnings
Date: Thu, 27 Sep 2012 15:38:32 +0200
Message-ID: <506456D8.7020704@compulab.co.il>
References: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:45413 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab2I0NjL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 09:39:11 -0400
In-Reply-To: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 09/25/12 01:09, Paul Walmsley wrote:
> 
> Commit e54adb1e79762d3591459e5b0e9b9ff578e33fdb ("ARM: OMAP: omap3evm:
> cleanup revision bits") adds a new sparse[1] warning:
> 
> arch/arm/mach-omap2/board-omap3evm.c:90:4: warning: symbol 'get_omap3_evm_rev' was not declared. Should it be static?
> 
> This symbol no longer appears to be used outside this file, so mark it
> static and remove the export.
> 
> Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> debug_card_init() function") results in the following new sparse[1]
> warning:
> 
> arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> 
> Fix by including the proper header file.
> 
> ...
> 
> 1. https://sparse.wiki.kernel.org/index.php/Main_Page

Yeah, my compiler did not emit those... Thanks for the fix!

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
