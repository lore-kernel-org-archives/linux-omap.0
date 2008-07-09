From: Josh Karabin <gkarabin@vocollect.com>
Subject: BDI3000 JTAG debug on OMAP3
Date: Wed, 09 Jul 2008 19:38:08 -0400
Message-ID: <48754BE0.3070904@vocollect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx4.vocollect.com ([64.212.175.114]:2241 "EHLO
	mx4.vocollect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbYGJAOT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 20:14:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Is anyone using a BDI3000 JTAG debugger for kernel debug on an OMAP3 
board? An engineer on my team is evaluating the hardware, but running 
into some problems. A tip or two would be appreciated from anyone who's 
got the hardware working. We've already got a separate evaluation of a 
Lauterbach JTAG debugger working, but the BDI seems to be giving us some 
trouble. Nothing in the docs or faqs seems relevant.

He can set breakpoints in the kernel and step through code at least 
halfway through the power up printks sent to the console, but at some 
point (he's still bisecting the debug) he can no longer interactively 
halt the kernel, and his breakpoints stop getting hit. The kernel runs 
just fine, GDB is able to talk to the BDI3000 just fine, but the BDI3000 
seems like it's no longer talking to the OMAP (since halt requests timeout).

Any ideas?


Thanks,

- Josh

