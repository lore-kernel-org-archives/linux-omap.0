From: Grant Erickson <marathon96@gmail.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode
 Timers
Date: Tue, 16 Nov 2010 10:13:43 -0800
Message-ID: <C90809D7.1FED0%marathon96@gmail.com>
References: <874obhi4nb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44322 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0KPSNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 13:13:50 -0500
Received: by pzk28 with SMTP id 28so267812pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 10:13:50 -0800 (PST)
In-Reply-To: <874obhi4nb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 11/16/10 9:01 AM, Kevin Hilman wrote:
> Grant Erickson <marathon96@gmail.com> writes:
>> This patch adds support to request and use one or more of the OMAP
>> dual-mode timers as a generic PWM device compatible with other generic
>> PWM drivers such as the PWM backlight or PWM beeper driver.
> 
> How will this co-exist with the PWM on the twl6030 PMIC
> (drivers/mfd/twl6030-pwm.c.)? Both are exporting the same API.

That's an excellent question. This driver started life in the 2.6.32 tree
where twl6030-pwm.c didn't exist. Thanks for the heads-up.

The right short-term solution is to probably change the configuration from:

    config HAVE_PWM

to:

    config OMAP_PWM
        select HAVE_PWM

and then have it conflict with TWL6030_PWM if that's enabled.

> Regarding multilpe PWM drivers, there has been discussion on the
> linux-embedded list[1] regarding a more generic PWM framework, and a few
> other projects working on PWM for OMAP[2].  Someone needs to step up and
> consolidate/push this work forward as there is a clear need for a more
> generic PWM infrastructure on various SoCs.  Your work is another
> example of similar work that needs to be coordinated with the other projects.
> 
>> Boards can register such devices using platform data such as in the following
>> example:
>> 
>> static struct omap2_pwm_platform_config pwm_config = {
>>    .timer_id           = 10,   // GPT10_PWM_EVT
>>    .polarity           = 1     // Active-high
>> };
> 
> Board code should not have to know which timers are PWM capable.  This
> information is fixed at the SoC level.

Fair enough; however, board code does have to know which PWM outputs are
tied to which piece of hardware being driven by it. In the OMAP3, there
isn't an any-to-any mapping of PWM timers to PWM-capable output pins.

So, in this case, I explicitly:

1) configure that pin multiplexer as GPT10_PWM_EVT.
2) make available GPT10_PWM_EVT as a generic PWM because that's the one
   precisely tied to the display backlight.
3) ensure that the backlight driver asks for the right generic PWM
   associated with it.
  
> This information is available and is part of the in-progress conversion
> of the timers to use the omap_hwmod infrastructure.  There are subsets
> of the timers that have various features (1ms timers, PWM capable, etc.)
> Using hwmod classes, they can be grouped together such that board code
> does not have to know which timers on which SoC are PWM capable.   It
> can simply request a timer with certain capabilities.
> 
> Kevin
> 
> [1] http://marc.info/?l=linux-embedded&m=128594628918269&w=2
> [2] http://marc.info/?l=linux-embedded&m=128599642406671&w=2

I'll take a look at those references.

With the appropriate configuration change to avoid the conflict with
TWL6030-PWM, it's probably better to have this driver in-tree than not.
It'll give those working on the PWM abstraction and rework another working
use case to integrate and work from.

Thanks for the feedback and the references.

Best,

Grant


