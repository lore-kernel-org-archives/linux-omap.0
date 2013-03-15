From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/8] ARM: dts: OMAP446x: move CPU OPP tables to device
 tree
Date: Fri, 15 Mar 2013 09:08:04 -0500
Message-ID: <20130315140804.GB2939@kahuna>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <1363294695-658-7-git-send-email-nm@ti.com>
 <514245EE.6090906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34933 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3COOIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 10:08:15 -0400
Content-Disposition: inline
In-Reply-To: <514245EE.6090906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 16:49-20130314, Jon Hunter wrote:
> 
> On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> > OMAP4430 and 4460 have different OPP definitions. So, create an SoC
> > variant dtsi file for 4460 and move the OPP definitions to it.
> 
> FYI, I had to create a similar file for PMU [1]. However, I called it
> omap4460.dtsi and not omap446x.dtsi as there is only one omap446x
Hmm, guess I was paranoid about marketing folks spinning off another
omap446x variant out into the market. Since it is not yet done, nor
known if they will ever do it, am OK with 4460 convention.
> device. That should go into to v3.10 and so may be worth basing this on
> top. I do like your omap4-panda-common.dtsi that is a nice clean-up.
Thanks on the tip - Sounds good, since this series is based on DT, I
will base my changes on top of for_3.10 branch.
> 
> Cheers
> Jon
> 
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/commit/?h=for_3.10/dts&id=5e64b6b1137a54f353528d6da60071c1ef0043ba

-- 
Regards,
Nishanth Menon
