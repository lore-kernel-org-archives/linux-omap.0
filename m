From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 9 Sep 2013 17:51:20 +0200
Message-ID: <BBAC0939-A4F9-4FEA-B137-0307D8787DC3@dominion.thruhere.net>
References: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net> <87zjrm81dl.fsf@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zjrm81dl.fsf@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olof@lixom.net
List-Id: linux-omap@vger.kernel.org


Op 9 sep. 2013, om 17:23 heeft Kevin Hilman <khilman@linaro.org> het volgende geschreven:

> Koen Kooi <koen@dominion.thruhere.net> writes:
> 
>> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
>> so create a common dtsi both can use.
>> 
>> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver
>> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
>> of 1.8.
>> 
>> MMC support for AM335x still isn't in, so only the LDO change has been added.
>> 
>> Cc: stable@vger.kernel.org
>> 
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> Tested-by: Tom Rini <trini@ti.com>
>> Tested-by: Matt Porter <matt.porter@linaro.org>
> 
> I guess the subject should've included v5?

Yes, I blame it on being monday :)

>  Also, if this is to be
> stable material, it will likely need rework since I don't think it will
> apply cleanly to older trees due to DT churn.

Ah right, the preprocessor changes. We'll see what happens with the stable trees. Most older kernels are useless on am335x, but the just released 3.11 is dangerous enough to get this backported.

> Anyways, for this patch...
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Even though I've probably already fried my HDMI transciever due to using
> the original DTS a lot more than a dozen times.  (and to TI: yes, I'd
> accept a new BB black as a sympathy gift.)  ;)

> Also, I tested this on both BBW and BBW:
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks!

regards,

Koen

> 
> Benoit, assuming this looks good to you, can you queue this for v3.12-rc
> please?   It applies to Linus' HEAD today (which has most of arm-soc
> merged), so it should apply cleanly on top of all your stuff.
> 
> Kevin
