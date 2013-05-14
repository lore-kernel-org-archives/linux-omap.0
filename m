From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.9
Date: Tue, 14 May 2013 14:13:29 -0700
Message-ID: <20130514211328.GC5600@atomide.com>
References: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51072 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab3ENVNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 May 2013 17:13:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

Hi,

* Paul Walmsley <paul@pwsan.com> [130508 12:45]:
> 
> PM off, dynamic idle:
>     FAIL ( 2/ 5): 4430es2panda, 4460pandaes
>     Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm

Looking at your pm logs, 3730beaglexm won't hit off-idle.
I've pasted the relevant lines from your logs below.

Is this a known issue?

Regards,

Tony


3530es3beagle hits OFF:
core_pwrdm (ON),OFF:24,RET:41,INA:0,ON:66,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

3730beaglexm won't hit OFF:
core_pwrdm (ON),OFF:0,RET:88,INA:0,ON:89,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

37xxevm hits OFF:
core_pwrdm (ON),OFF:8,RET:10,INA:0,ON:19,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
