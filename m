From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Wed, 6 Feb 2013 14:30:36 +0100
Message-ID: <51125AFC.10704@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60908 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab3BFNat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 08:30:49 -0500
In-Reply-To: <510F7BEB.1020408@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Salut Florian,

On 02/04/2013 10:14 AM, Florian Vaussard wrote:
> Hello Benoit,
> 
> On 01/24/2013 01:21 PM, Benoit Cousson wrote:
>> + Peter who did the original PWM
>>
>> Hi Florian,
>>
>> On 01/23/2013 06:56 PM, Florian Vaussard wrote:
>>> Hello Benoit,
>>>
>>> This patchset adds some new DT supports to the Overo products. The
>>> first patch converts the PMIC LEDB output to use the pwm-leds,
>>> newly merged in your branch for_3.9/dts. The second patch adds the
>>> audio support.
>>
>> Excellent, that looks very good to me, but I'd like to get the
>> feedback from Peter before merging it.
>>
> 
> So a patch is being merged to handle triggers in the case of pwm leds [1].
> When done, we will be able to add back the default trigger. Do you want
> to wait on it to merge this series?

What kind of dependency do we have between these two series? I mean what
will happen if the DTS is merged before the pwm subsystem?

If that does not generate any regression / crash, then it is OK, if not,
we should take care of the order.

Thanks,
Benoit

