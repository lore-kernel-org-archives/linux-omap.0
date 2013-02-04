From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Mon, 04 Feb 2013 10:14:19 +0100
Message-ID: <510F7BEB.1020408@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <5101273A.9090800@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:60191 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754323Ab3BDJOY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 04:14:24 -0500
In-Reply-To: <5101273A.9090800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello Benoit,

On 01/24/2013 01:21 PM, Benoit Cousson wrote:
> + Peter who did the original PWM
>
> Hi Florian,
>
> On 01/23/2013 06:56 PM, Florian Vaussard wrote:
>> Hello Benoit,
>>
>> This patchset adds some new DT supports to the Overo products. The
>> first patch converts the PMIC LEDB output to use the pwm-leds,
>> newly merged in your branch for_3.9/dts. The second patch adds the
>> audio support.
>
> Excellent, that looks very good to me, but I'd like to get the
> feedback from Peter before merging it.
>

So a patch is being merged to handle triggers in the case of pwm leds [1].
When done, we will be able to add back the default trigger. Do you want
to wait on it to merge this series?

Regards,

Florian

[1] https://patchwork.kernel.org/patch/2056191/
