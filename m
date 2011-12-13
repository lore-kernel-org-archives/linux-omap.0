From: Gary Thomas <gary@mlbassoc.com>
Subject: sys_clkout2
Date: Tue, 13 Dec 2011 14:28:45 -0700
Message-ID: <4EE7C38D.8020501@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:44773 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab1LMVg3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 16:36:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

What's the best way to enable sys_clkout2 (DM3730, latest kernel)?
I've managed to set it up properly and it runs in U-Boot, but the
kernel is disabling it.  It's a bit of a tangle trying to figure out
not only what piece of code is undoing my work, but how to get the
clock to keep running.  I want the clkout_cntrl register set to 0x8a,
so any guidance on how to make this happen would be greatly appreciated.

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
