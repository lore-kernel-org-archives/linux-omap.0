From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Wed, 18 Apr 2012 12:29:40 +0200
Message-ID: <4F8E9794.5090403@ti.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com> <4F8E76C3.7080803@ti.com> <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com> <4F8E84DC.70600@ti.com> <alpine.DEB.2.00.1204180312160.29048@utopia.booyaka.com> <4F8E8FF7.4000706@ti.com> <alpine.DEB.2.00.1204180406550.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48201 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab2DRK3p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 06:29:45 -0400
In-Reply-To: <alpine.DEB.2.00.1204180406550.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 4/18/2012 12:12 PM, Paul Walmsley wrote:
> On Wed, 18 Apr 2012, Cousson, Benoit wrote:
>
>> On 4/18/2012 11:40 AM, Paul Walmsley wrote:
>>
>>> Sounds like the patch to alter the warnings should be associated with this
>>> clock cleanup series, then, since it sounds like it changes the
>>> clockdomain control model.
>>
>> It just removes the modulemode clock nodes we were using so far. And since
>> these nodes were the only ones with a clkdm on OMAP4, it is now complaining,
>> because their parents clock does not have a clkdm.
>
> If that series doesn't change the model, then maybe the right fix is just
> to associate those clocks with clockdomains in clock44xx_data.c, until the
> model changes?

But the model is already different for OMAP4. Since the clkdm is 
associated with the hwmod, we already ensure that the clkdm is properly 
enabled before enabling the modulemode.
In fact the clkdm associated with the fake modulemode clk node was 
already useless for OMAP4 as soon as we had introduced the modulemode 
support in hwmod.

The only need for that today is for the few broken drivers that does use 
the clock fmwk to enable the modulemode instead of using pm_runtime.

> I looked up some of those clocks in the OMAP4430 TRM vX.  Most of them
> would be associated with either a CM clockdomain or a PRM clockdomain. The
> TRM does actually mention these two clockdomains.  Two examples (out of
> several) that mention CD_PRM and CD_CM are Figure 3-58 "CD_L4_PER
> Overview" and Figure 3-59 "CD_L3_INIT Overview".
>
> Of course, from the software's perspective, these associations would
> effectively be no-ops, as they are on OMAP2/3; but they seem to match the
> view of the hardware as described in the TRM, so at least they make sense.

Yeah, I'm just reluctant to add some more data in an already big file, 
knowing that this information will be useless, just because a couple of 
broken drivers does need that.

What we plan to do with the migration to CCF is to keep these specific 
nodes only for the broken drivers to highlight that these ones need to 
be fixed. And thus only these nodes will need the clkdm information.

Regards,
Benoit

