From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
Date: Fri, 2 Mar 2012 05:58:47 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317E66C1@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1202291810230.12752@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A8317E5134@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1203011847480.22980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37111 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755918Ab2CBF64 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 00:58:56 -0500
In-Reply-To: <alpine.DEB.2.00.1203011847480.22980@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 02, 2012 at 11:19:40, Paul Walmsley wrote:
> Hi
> 
> On Thu, 1 Mar 2012, Hiremath, Vaibhav wrote:
> 
> > I am not sure whether we access these bits explicitly. If I understand 
> > correctly, API's which access these bits are not being called from 
> > anywhere, For example,
> > 
> > 	omap4_pwrdm_read_mem_retst
> > 	omap4_pwrdm_set_mem_retst
> > 	omap4_pwrdm_set_mem_onst
> 
> They'll be needed for the functional powerstate code, device PM QoS, and 
> OSWR.
> 
> > Currently the major issue would be, for PM_PER_PWRSTCTRL, where 
> > LogicRETState bit has been moved to offset 3. This is being used in 
> > omap4_pwrdm_set_logic_retst() api.
> > 
> > And in order to support weird/non-standard bit-offsets, we have to clean 
> > omap2_pwrdm_get_mem_bank_onstate/retst/_mask() api and have bitshift 
> > field in struct powerdomain, as you have rightly pointed out.
> 
> As you work on this, I have a request.  Please place the AM33xx 
> powerdomain implementation functions into a separate file, 
> powerdomain33xx.c perhaps, rather than trying to merge them with the OMAP4 
> powerdomain implementation functions.
> 

That was my initial code and I had submitted same to the list as an RFC, 
Request you to refer to the link - 
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58746.html


And the reason behind merging am33xx with omap4 thing was triggered
from the discussion on the above patch (between me, KevinH and RajendraNaik), 
and we all believed that, with some cleanup in OMAP4 code we can reuse it 
for am33xx.

Thanks,
Vaibhav

> Some functions can be shared -- maybe place those into a separate file, 
> powerdomain33xx_44xx.c perhaps?
> 
> > Is my all understanding correct?
> > 
> > If yes, do you think this patch should get blocked for above cleanup? I feel
> > Cleanup can still follow, since this won't impact the AM33xx boot.
> > 
> > What's your opinion on this??
> 
> We can't merge patches which are known to be broken.  That's a rule from 
> Linus (and a good one).  Better to try to get it right the first time it 
> hits mainline.
> 
> 
> - Paul
> 

