From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] ARM: AM33xx: hwmod: Add INIT_NO_IDLE flag for debugss
 hwmod
Date: Mon, 14 Apr 2014 13:59:26 +0530
Message-ID: <534B9C66.9020007@ti.com>
References: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1404111800430.14347@utopia.booyaka.com> <alpine.DEB.2.02.1404111807210.14347@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53055 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbaDNIaD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Apr 2014 04:30:03 -0400
In-Reply-To: <alpine.DEB.2.02.1404111807210.14347@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, rnayak@ti.com

Hi Paul,
On Friday 11 April 2014 11:39 PM, Paul Walmsley wrote:
> On Fri, 11 Apr 2014, Paul Walmsley wrote:
> 
>> On Wed, 9 Apr 2014, Lokesh Vutla wrote:
>>
>>> During boot, when hwmod tries to cut clocks for debugss it always
>>> gets stuck in transition state and throws the following warning:
>>>
>>> [    0.139581] omap_hwmod: debugss: _wait_target_disable failed
>>>
>>> As per the information provided by folks, clocks to debugss cannot be cut.
>>> So adding HWMOD_INIT_NO_IDLE flag to debugss hwmod.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Thanks, queued for v3.15-rc.
> 
> Hmmm.  On second thought, this doesn't look like the right fix.  Could 
> you please comment on the issues raised here:
> 
> https://patchwork.kernel.org/patch/2212111/
Yes, I initially created a driver for enabling and disabling clocks for DEBUGSS.
But I always see that DEBUGSS is always stuck in transition whenever clocks are cut
to DEBUGSS. 
During boot also when hwmod tries to cut clocks the following warning comes:
  [    0.139581] omap_hwmod: debugss: _wait_target_disable failed.

As confirmed by the hardware team that this is a bug in silicon that clocks cannot
be cut to DEBUGSS.
So I am just adding HWMOD_INIT_NO_IDLE flag to debugss hwmod. 

I have also tested suspend-resume with $subject patch with TI internal tree.

Please let me know if I am not clear.

Thanks and regards,
Lokesh

> 
> Looks to me like there should be at least one device driver, either for 
> the entire DEBUGSS, or for the individual IP blocks inside the DEBUGSS.
> 
> Dropping this patch for now.
> 
> 
> - Paul
> 

