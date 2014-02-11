From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/3] ARM: dts: Fixes for Overo/Tobi against 3.14-rc1
Date: Tue, 11 Feb 2014 14:07:53 +0100
Message-ID: <52FA20A9.2060702@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch> <87d2j0rwv8.fsf@paris.lan>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:57304 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaBKNIA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Feb 2014 08:08:00 -0500
In-Reply-To: <87d2j0rwv8.fsf@paris.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi,

On 02/06/2014 06:09 PM, Kevin Hilman wrote:
> Florian Vaussard <florian.vaussard@epfl.ch> writes:
> 
>> OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc1 [1].
>> This series fixes this, by moving model-agnostic DT into a common dtsi file,
>> and creating model-specific DT files:
>>
>> - omap3-overo-tobi.dts -> older OMAP35xx Overo
>> - omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo
>>
>> People will have to use the right Overo / expansion board combination.
>>
>> (Patch 2 in an unrelated fix that was waiting in my queue.)
>>
>> omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
>> tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
>> mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
>> a missing errata.
> 
> And I tested with my 35xx/Overo with omap3-overo-tobi.dts and my
> 37xx/Overo STORM with omap3-overo-storm-tobi.dts and they're both
> working.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Tony, with your ack, I can apply these directly to arm-soc/fixes.
> 
> Florian, thanks for the fixes.
> 

This issue is still present in 3.14-rc2.

Shall I send a v2, including the suggestion of Nishanth, against 3.14-rc2?

Regards,
Florian
