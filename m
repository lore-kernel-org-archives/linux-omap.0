From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: AM3517 EVM
Date: Thu, 6 Feb 2014 15:44:49 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE09A5BCEE9@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpout13.bt.lon5.cpcloud.co.uk ([65.20.0.133]:5166 "EHLO
	smtpout13.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756084AbaBFPoy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 10:44:54 -0500
Received: from MARCM-SBS2011.marcmltd.local (31.185.139.65) by smtpout13.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as marcmltd@btinternet.com)
        id 52F028960029CCF1 for linux-omap@vger.kernel.org; Thu, 6 Feb 2014 15:44:52 +0000
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have been trying to get the WFI working on my AM3517 and wondering about the nohlt command I have in the boot args and wondering if I should be able to boot 3.6.11 kernel on the AM3517EVM without the nohlt arg ?

What config should I use (omap2plus_defconfig and then select the AM3517EVM option) ?

I would like to get the EVM system working properly with the sleep and wake before I apply the changes to my AM3517 system.

Thanks for any feedback

Marc





