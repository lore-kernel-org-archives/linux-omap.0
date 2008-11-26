From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: ARM : OMAP: Pass logical DMA channel number always to callback
 handlers
Date: Wed, 26 Nov 2008 14:43:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02936BEAED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38966 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYKZJNQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 04:13:16 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jarkko\Tony ,

Recently during some debugging, I observed this patch.
http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=538528de0cb256f65716ab2e9613d9e920f97fe2;hp=29e8c3c304b62f31b799565c9ee85d42bd163f80

As per your description,it improves the debugging. Can you elaborate more on this ?

For users this change is little confusing, if they go as per the signatures of the 'omap_request_dma_chain' and 'omap_request_dma' APIs. Also separating the callbacks for chained and non-chained transfers seems to be the practical usage in most of the cases. Also users would be only interested in 'chain_id' and not 'channel number' in case of chaining.  

So if it improves only debugging and some what complicates the usage, I suggest we should revert this patch.

Regards,
Santosh Shilimkar
