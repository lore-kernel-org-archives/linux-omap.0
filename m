From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Thu, 1 Mar 2012 22:49:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203011847480.22980@utopia.booyaka.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com> <1324803628-16790-3-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1202291810230.12752@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A8317E5134@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41366 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab2CBFtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 00:49:42 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317E5134@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi

On Thu, 1 Mar 2012, Hiremath, Vaibhav wrote:

> I am not sure whether we access these bits explicitly. If I understand 
> correctly, API's which access these bits are not being called from 
> anywhere, For example,
> 
> 	omap4_pwrdm_read_mem_retst
> 	omap4_pwrdm_set_mem_retst
> 	omap4_pwrdm_set_mem_onst

They'll be needed for the functional powerstate code, device PM QoS, and 
OSWR.

> Currently the major issue would be, for PM_PER_PWRSTCTRL, where 
> LogicRETState bit has been moved to offset 3. This is being used in 
> omap4_pwrdm_set_logic_retst() api.
> 
> And in order to support weird/non-standard bit-offsets, we have to clean 
> omap2_pwrdm_get_mem_bank_onstate/retst/_mask() api and have bitshift 
> field in struct powerdomain, as you have rightly pointed out.

As you work on this, I have a request.  Please place the AM33xx 
powerdomain implementation functions into a separate file, 
powerdomain33xx.c perhaps, rather than trying to merge them with the OMAP4 
powerdomain implementation functions.

Some functions can be shared -- maybe place those into a separate file, 
powerdomain33xx_44xx.c perhaps?

> Is my all understanding correct?
> 
> If yes, do you think this patch should get blocked for above cleanup? I feel
> Cleanup can still follow, since this won't impact the AM33xx boot.
> 
> What's your opinion on this??

We can't merge patches which are known to be broken.  That's a rule from 
Linus (and a good one).  Better to try to get it right the first time it 
hits mainline.


- Paul
