From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH 2/2] OMAP: McBSP: Do not enable or disable clocks on
 failed path
Date: Wed, 11 Mar 2009 19:28:04 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760037BE5F679@NOK-EUMSG-02.mgdnok.nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
	<12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
	<1236582316453-git-send-email-ext-eero.nurkkala@nokia.com>
	<20090310163027.5444259e.jarkko.nikula@nokia.com>
	<1FFEF31EBAA4F64B80D33027D4297760037BE5F663@NOK-EUMSG-02.mgdnok.nokia.com>,<20090311130316.fb9ef9c1.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41333 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbZCKS2P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 14:28:15 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2BISBxe020862
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 13:28:12 -0500
In-Reply-To: <20090311130316.fb9ef9c1.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jarkko.nikula@nokia.com
Cc: linux-omap@vger.kernel.org


> Didn't check any deeply can clk_disable sleep in any case but anyway
> there is no need to cover it with spinlock so better to not hold the
> lock while disabling.
> 
> 
> Jarkko

Actually, is there any room for the race? I remember someone saying
the clk:s have counters, so:

1. If mcbsp is "taken", clks on;
- and at the same time, the previous mcbsp has been released, leaving clks off
, clk counter decrements, nothing bad happens..


- Eero