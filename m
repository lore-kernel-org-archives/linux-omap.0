From: Gary Thomas <gary@mlbassoc.com>
Subject: X-loader / U-Boot query
Date: Thu, 08 Oct 2009 06:58:07 -0600
Message-ID: <4ACDE1DF.1010303@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:44757 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158AbZJHNIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:08:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have a new board - OMAP 3530 with 512MB DRAM & NAND
I've build X-loader and U-Boot for it and it mostly comes
up.  The sources I used (based on recommendations from the
BeagleBoard pages) were:
   http://git.gitorious.org/x-load-omap3/mainline.git
   git://git.denx.de/u-boot.git

I had to make a small change to get it to recognize the
larger NAND FLASH device.

The problem I have now is that it's only seeing 1/2 (256MB)
of the available DRAM.

* Does anyone know how to get it to see all 512MB?
* Is there a better place to ask/discuss these questions?
   A cursory look around did not point to anything fresh (most
   of the web pages & Wikis I looked are are _years_ old)

Thanks for any help/pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
