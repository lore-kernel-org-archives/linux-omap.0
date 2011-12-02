From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 2 Dec 2011 15:59:01 +0100
Message-ID: <4ED8E7B5.2010209@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com> <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com> <20111202122558.GM8245@opensource.wolfsonmicro.com> <4ED8C57B.2000503@ti.com> <20111202130242.GO8245@opensource.wolfsonmicro.com> <4ED8D321.7030904@ti.com> <20111202140044.GS8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39658 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756656Ab1LBO7W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 09:59:22 -0500
In-Reply-To: <20111202140044.GS8245@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 12/2/2011 3:00 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 02:31:13PM +0100, Cousson, Benoit wrote:
>
>> Even if the reg-names and interrupts-names are accepted, which is
>> still not obvious due to a little bit of resistance, we still do not
>
> Yeah, it seems like there's very little traction on any of the problems
> with legacy bindings that device tree has.
>
>> have dma request bindings, nor clock bindings, nor pin mux.
>> All these information are provided today by hwmod, so it will still
>> be there for a couple of more merge windows.
>
> At least the DMA bindings seem fairly well sorted - we just merged the
> Tegra audio bindings which define a Tegra property for the DMA request
> signal.  There's a reasonable amount of variation in how these things
> get plumbed together.

Mmm, I missed that series, but I'm not sure it is doing the right thing.
- First the name is missing :-(
- Secondly a dma-channel is not a dma-request... So I'm not sure what 
that series is supposed to add...
I should reply on that, thanks for pointing this series.

>> The important point for me, it to avoid having to change the driver
>> whenever these bindings will be there. This will be OK today for reg
>> and interrupts since they both go through Linux resources.
>
> This is also OK for clocks since they'll go through the clock API so
> nothing needs doing there either.

Yep, my point was about the DT churn that this will generate.

>>> Could we define and implement the "real" version now (it should be reasonable to
>>> code blind except possibly for the DMA channel as it's such a direct
>>> mapping) with hwmod left in there as something that's legacy for old
>>> kernels?
>
>> I think DT churn is unavoidable due to the ongoing effort to add
>> clock, regulator, dma, pin mux into DT core.
>> I don't think we should wait to have all that ready to start
>> migrating to DT.
>
> Well, it does make the whole process a bit silly.  If we're planning to
> discard hwmod it seems like we shouldn't be transitioning it into device
> tree in the first place and instead just add the new properties to the
> bindings as we go.  If hwmod must go into the device tree somehow is it
> not possible to keep the hwmod data in its own binding (referencing the
> nodes it affects rather than being in their bindings).

Yeah, maybe, but it was done like that due to a bunch of constraints and 
mainly because a lot a binding were missing. The other issue is that we 
still do not know what will remain in the hwmod data and where it should go.
So this idea was to do that in several phases in order to allow people 
adapting their drivers without having to wait the DT + OMAP core stuff 
to completely sorted out.

At the end, the effort should be only at OMAP core level, so the driver 
should not be affected if we decide to move hwmod stuff into DT or not.

At least, that's the idea.

Regards,
Benoit
