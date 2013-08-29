From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/3] ARM: AM33xx: hwmod: Add RNG module data
Date: Thu, 29 Aug 2013 14:52:18 +0530
Message-ID: <521F12CA.8010608@ti.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com> <1375777984-6267-2-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33290 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384Ab3H2JWv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 05:22:51 -0400
In-Reply-To: <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org, rob@landley.net, rnayak@ti.com, benoit.cousson@linaro.org

Hi Paul,
On Thursday 29 August 2013 12:18 AM, Paul Walmsley wrote:
> Hi
> 
> On Tue, 6 Aug 2013, Lokesh Vutla wrote:
> 
>> Add RNG hwmod data for AM33xx SoC.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> I tried to queue this one, but it caused AM33xx boots to hang.  
> Thought it might be related to the patch ordering -- seems to me that 
> the clock change patch needed to come before this patch -- but if I 
> recall correctly, both BeagleBone and BeagleBone-LT still hung. 
This is because register address space is not passed in hwmod_data as it
is passed from dt. So we need to include 3/3 patch in this series to boot.

Ill fix this sparse warning and post a v2.

PS: Probe for this driver will be failed even after this. Support for this version
of rng ip is already posted and pushed into cryptodev-2.6 tree.

Thanks and regards,
Lokesh
> 
> Also, this patch created a sparse warning.
> 
> Could you take another look at this patch?  Maybe try basing off of this 
> tag:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/omap-prcm-hwmod
> 
> Fix the sparse problem, and see if the patch boots for you?
> 
> thanks
> 
> 
> - Paul
> 

