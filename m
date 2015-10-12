From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 00/37] ARM: dts: Fix fixed regulators enable GPIO polarity
Date: Tue, 13 Oct 2015 00:19:20 +0200
Message-ID: <561C31E8.6000408@osg.samsung.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20151012214654.GE23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012214654.GE23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

On 10/12/2015 11:46 PM, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [151012 14:17]:
>> Hello,
>>
>> While working on regulators, GPIOs and DT I noticed that many of our DT source
>> files incorrectly describe fixed regulators. The common error patterns are
>>
>> - Usage of the undefined (and never parsed) enable-active-low property
>> - Usage of the enable-active-high property without specifying an enable GPIO
>> - Typos in the enabl GPIO property name (gpios instead of gpio)
>> - Mismatch between the enable-active-high property (or the lack thereof) and
>>   the enable GPIO flags
>>
>> This patch series fixes those issues in all the DT sources after locating the
>> errors using the following script.
>>
>> ------------------------------------------------------------------------------
>> #!/bin/sh
>>
>> echo $1
>> cat $1 | awk '
>> BEGIN {
>> 	open_drain = 0;
>> 	active_high = 0;
>> 	gpio = 0;
>> 	flags = 0;
>> }
>>
>> match($0, /([a-zA-Z0-9@_-]*) {/, ary) {
>> 	name = ary[1];
>> }
>>
>> /compatible.*"regulator-fixed"/ {
>> 	found = 1;
>> }
>>
>> /enable-active-high/ {
>> 	active_high = 1;
>> }
>>
>> /gpio-open-drain/ {
>> 	open_drain = 1;
>> }
>>
>> match($0, /gpio += <.* ([^ ]*)>/, ary) {
>> 	gpio = 1;
>> 	flags = ary[1];
>> 	if (flags == 0)
>> 		flags = "GPIO_ACTIVE_HIGH";
>> }
>>
>> /}/ {
>> 	if (found) {
>> 		if (gpio) {
>> 			print "\t" name ": active high " active_high " " flags " open drain " open_drain;
>> 			if ((active_high && flags == "GPIO_ACTIVE_LOW") ||
>> 			    (!active_high && flags == "GPIO_ACTIVE_HIGH"))
>> 				print "WARNING: enable-active-high and flags do not match"
>> 		} else {
>> 			if (active_high)
>> 				print "WARNING: active high without GPIO"
>> 			if (open_drain)
>> 				print "WARNING: open drain without GPIO"
>> 		}
>> 	}
>>
>> 	gpio = 0;
>> 	found = 0;
>> 	active_high = 0;
>> 	open_drain = 0;
>> 	flags = 0;
>> }
>> '
>> ------------------------------------------------------------------------------
>>
>> All patches except for the ones touching omap3-beagle-xm and omap3-overo-base
>> are untested as I lack test hardware.
>>
>> As there's no dependency between the patches touching different source files
>> the appropriate maintainers could take their share of the patches in their
>> tree. Alternatively I could send a single pull request after collecting all
>> acks but that might be more complex.
> 
> Nice clean-up. For omaps, there's an earlier patch posted by
> Javier Martinez Canillas <javier@osg.samsung.com> as "[PATCH] ARM: dts: Use
> defined GPIO constants in flags cell for OMAP2+ boards". Can you guys do some
> cross checking and let me know which combination I should appluy for omaps?
>

Since Laurent's changes for OMAP are part of a bigger series and my patch
was only for OMAP, probably makes sense for you to pick his patches and I
can re-spin mine on top of that.

BTW, I posted as a single patch since the changes were trivial but maybe
that made handling these conflicts harder and I should split the changes
instead, since I'll resend anyways.

What do you prefer? a patch per SoC family (i.e: OMAP{2,3,4,5}) or patch
per board DTS?
 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
