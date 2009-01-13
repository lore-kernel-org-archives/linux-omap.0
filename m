From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Tue, 13 Jan 2009 08:06:05 +0200
Message-ID: <1231826765.13843.105.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31972 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZAMGIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 01:08:32 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D68SQF024884
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 08:08:29 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0D68D3N008065
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 08:08:14 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Feel free to revert this patch.

There appears to be problems with the noised filters
not obeying the i2c standard.

I will come up with a new patch in the future.


