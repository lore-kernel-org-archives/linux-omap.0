From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCH 2/2] OMAP: McBSP: Do not enable or disable clocks on
 failed path
Date: Tue, 10 Mar 2009 19:43:40 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760037BE5F663@NOK-EUMSG-02.mgdnok.nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
	<12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
	<1236582316453-git-send-email-ext-eero.nurkkala@nokia.com>,<20090310163027.5444259e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37280 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbZCJSpb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 14:45:31 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2AIjN5I006184
	for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2009 20:45:26 +0200
In-Reply-To: <20090310163027.5444259e.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jarkko.nikula@nokia.com
Cc: linux-omap@vger.kernel.org


> Race here? See, McBSP is marked free before disabling the clocks and
> thus omap_mcbsp_request can start enabling them. So should you keep
> clock disabling after test for mcbsp->free as here now but mark McBSP
> free only after clocks are disabled?
> 
> I think you should send this as an separate fix since this should go to
> the upstream also.

Good comment... why do I always do everything in such a hurry, without
thinking any =) 
Either that or leave clock disabling within the spin_lock covered code?
(probably risky business)

- Eero
