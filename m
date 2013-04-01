From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Mon, 1 Apr 2013 09:13:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com> <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38896 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab3DAJNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 05:13:06 -0400
In-Reply-To: <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Mon, 1 Apr 2013, Alexey Pelykh wrote:

> Actually, I've tested my patch on DM3730,

What board, bootloader, and test steps did you use?  Can you post a dmesg?

> and, at least, can prove that original settings of UART are incorrect 
> according to TRM of processor. 

The TRM could be buggy or wrong; or your patch could be correct as far as 
the UART goes, but could be triggering a separate bug.  We're reaching the 
end of the v3.9-rc fixes period, so we need to deal with the v3.9-rc 
regression quickly so folks don't wind up with a broken v3.9 kernel.  
Then the issue can be debugged and tested, and the revised fix targeted 
for the v3.11 kernel.

> What settings of UART you were using to reproduce issue? I'd like to 
> kindly ask you to describe your test environment, since I've never 
> experiences issues that you've described nor in debug console, nor in 
> regular UART usage.

Could you be more specific about what information you're looking for, 
beyond what's in:

http://www.pwsan.com/omap/testlogs/test_v3.9-rc5/20130331205513/pm/37xxevm/37xxevm_log.txt 

?  As you can see from the log, it's using UART1 at 115kbps -- init=/bin/sh, 
so no userspace to speak of.

It's also worth mentioning that the 3730 Beagle XM here doesn't fail the 
PM test, UART3 at 230kbps in a "full" userspace:

http://www.pwsan.com/omap/testlogs/test_v3.9-rc5/20130331205513/pm/3730beaglexm/3730beaglexm_log.txt


- Paul
