From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 1/1] OMAP: voltage: add a hook for normal regulator calls
Date: Mon, 05 Dec 2011 11:07:38 -0800
Message-ID: <87sjkykfb9.fsf@ti.com>
References: <1321547303-21807-1-git-send-email-vaibhav.bedia@ti.com>
	<B5906170F1614E41A8A28DE3B8D12143032D30@DBDE01.ent.ti.com>
	<87iplymwwi.fsf@ti.com>
	<B5906170F1614E41A8A28DE3B8D121430391C2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39363 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932069Ab1LETHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 14:07:43 -0500
Received: by mail-vx0-f176.google.com with SMTP id fl13so5886607vcb.35
        for <linux-omap@vger.kernel.org>; Mon, 05 Dec 2011 11:07:42 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121430391C2@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Mon, 5 Dec 2011 16:02:52 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kattekola, Ravikumar" <rk@ti.com>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> Hi Kevin,
>
> On Sat, Dec 03, 2011 at 03:57:57, Hilman, Kevin wrote:
> [...]
>> >
>> > Any comments on this approach? 
>> 
>> Sorry, I didn't see this patch before, and I don't see it in the
>> linux-omap archives either.  Not sure what happened there...
>> 
>> > This enables us to make use of generic regulators calls from the
>> > voltage layer. 
>> 
>> From this patch, I don't see how the regulator API is being used from
>> the voltage layer, so I don't fully understand what you're trying to
>> achieve.
>> 
>> IOW, why should the voltagedomain code be calling the regulator API?
>> 
>> The voltage domain code was designed with the opposite goal: namely,
>> that a regulator driver would be calling the voltage domain layer, not
>> vice versa.
>
> Sorry, I should have posted more detail on how we are making use of the 
> change proposed here and how it helps in getting cpufreq and DVFS working.
>
> We want to use the existing OMAP implementation of cpufreq (and DVFS) on 
> the devices which do not have VC/VP.
>
> The current OMAP cpufreq code under drivers/ invokes clk_set_rate().
>
> We had a look at the future DVFS implementation for OMAP[1] and merged in 
> the relevant patches (hope this is close to what's planned).

Unfortunately, that implementation is not what's planned, and in fact
was rejected some time ago.

> After this change, cpufreq invokes omap_device_scale(). The DVFS code
> makes use of the OPP layer and adds a request for voltage and frequency
> change. However, the voltage change request expects the scaling to be done
> in scaling functions defined in the voltage layer (vc->scale or vp->scale)
>
> On devices which do not have VC/VP, instead of just hacking the current
> implementation to get the voltage scaling done, we thought of adding
> a separate path.

A much better path for SoCs without VC/VP is to simply modify the
CPUfreq driver to use the regulator API to scale voltage before calling
clk_set_rate() (if scaling up) and after scaling the frequency (if
scaling down.)

In fact, that is the direction we're going for DVFS, even for VC/VP
platforms.  There will be a regulator driver which will call the
voltagedomain/VC/VP calls to scale the voltage when needed, so from a
DVFS perspective, you use the clock API to change frequency, and the
regulator API to change voltages.

This should be a much simpler approach for you, and much easier to
understand.

Kevin
