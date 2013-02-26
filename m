From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Tue, 26 Feb 2013 17:07:36 +0100
Message-ID: <512CDDC8.6030307@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch> <51125AFC.10704@ti.com> <51135EAC.7010406@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:39785 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758595Ab3BZQHl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 11:07:41 -0500
In-Reply-To: <51135EAC.7010406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi,

On 02/07/2013 08:58 AM, Peter Ujfalusi wrote:
> Hi,
>
> On 02/06/2013 02:30 PM, Benoit Cousson wrote:
>>> So a patch is being merged to handle triggers in the case of pwm leds [1].
>>> When done, we will be able to add back the default trigger. Do you want
>>> to wait on it to merge this series?
>>
>> What kind of dependency do we have between these two series? I mean what
>> will happen if the DTS is merged before the pwm subsystem?
>>
>> If that does not generate any regression / crash, then it is OK, if not,
>> we should take care of the order.
>
> In this series the 'linux,default-trigger' property is not added to the
> pwm-leds node, so it is safe to take this series.
> I'm sure Florian will send the update to add this flag back for 3.10 or for
> 3.9-rc (the needed patches for PWM and leds-pwm will be in 3.9).
>

Yes, it is safe to take this series. I will provide a patch to add back
the trigger when it is safe to.

Regards,

Florian
