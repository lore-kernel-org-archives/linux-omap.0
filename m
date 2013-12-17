From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for
 v3.14
Date: Tue, 17 Dec 2013 07:14:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170707140.14039@utopia.booyaka.com>
References: <pull-1386643347-596413> <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com> <20131210185902.GO13171@atomide.com> <20131210192726.GR13171@atomide.com> <20131210230722.GZ13171@atomide.com> <20131213192622.GI28184@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53641 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3LQHO6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 02:14:58 -0500
In-Reply-To: <20131213192622.GI28184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, 13 Dec 2013, Tony Lindgren wrote:

> OK posted a patch for the SBC-T3730 with minimal support also for
> SBC-3530 and SBC-3517 that should boot far enough to start adding
> more devices. Paul, care to try it on the CM-T3517, the patch is:
> 
> [PATCH] ARM: dts: Add support for sbc-3xxx with cm-t3730

Didn't get anything out of the serial port:

http://www.pwsan.com/omap/testlogs/test_tonys_conversion_v3.14/20131215235827/boot/cmt3517/cmt3517_log.txt

As a partial sanity check, AM3517 EVM was included as part of the run 
(with a separate uImage+dtb of course) and that seems to boot OK:

http://www.pwsan.com/omap/testlogs/test_tonys_conversion_v3.14/20131215235827/boot/3517evm/3517evm_log.txt

In case it's useful, here's a CM-T3517 boot log from v3.13-rc4:

http://www.pwsan.com/omap/testlogs/test_v3.13-rc4/20131215195251/boot/cmt3517/cmt3517_log.txt


- Paul
