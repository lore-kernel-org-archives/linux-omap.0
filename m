From: Paul Walmsley <paul@pwsan.com>
Subject: Re: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Wed, 27 Jun 2012 13:27:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271318070.27496@utopia.booyaka.com>
References: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43313 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586Ab2F0T1v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 15:27:51 -0400
In-Reply-To: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, govindraj.raja@ti.com

On Wed, 27 Jun 2012, Paul Walmsley wrote:

> Looks like something broke between v3.5-rc3 and v3.5-rc4 with dynamic 
> idle on 3530ES3 Beagle.  37xx EVM doesn't seem to be affected.
> 
> Taking a closer look now.

Reverting commit 91930652a23de0873a157aa1d9962cb878d64451 ("OMAP2+: UART: 
Add mechanism to probe uart pins and configure rx wakeup") makes wakeup 
from dynamic retention idle work again.


- Paul
