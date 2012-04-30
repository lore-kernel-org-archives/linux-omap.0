From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Mon, 30 Apr 2012 14:51:48 -0700
Message-ID: <87wr4wriq3.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
	<20120427175657.GP18260@opensource.wolfsonmicro.com>
	<87397o3n4y.fsf@ti.com>
	<20120430095429.GB3170@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:54841 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756606Ab2D3Vv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 17:51:56 -0400
Received: by pbcxa12 with SMTP id xa12so4344047pbc.23
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 14:51:55 -0700 (PDT)
In-Reply-To: <20120430095429.GB3170@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Mon, 30 Apr 2012 10:54:29 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com, durgadoss.r@intel.com

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Fri, Apr 27, 2012 at 02:01:17PM -0700, Kevin Hilman wrote:
>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> > But presumably these things should integrate somehow - for example,
>> > should devfreq and cpufreq be providing inputs into what AVS is doing,
>> > and if so how?
>
>> The way it is currently designed, cpufreq/devfreq/regulator layers don't
>> need to know about AVS.
>
> Yes, and that was a part of my concern, but see below.
>
>> The higher-level layers only know about the "nominal" voltage.  AVS
>> hardware does automatic, adaptive, micro-adjustments around that nominal
>> voltage, and these micro-adjustments are managed by the AVS hardware
>> sending commands to the PMIC.  (specifically, on OMAP, the AVS sensors
>> provide inputs to the voltage processor (VP) which provide inputs to the
>> voltage controller (VC) which sends commands to the PMIC[1].)
>
> Right, that's what I'd understood it to be.  
>
>> The driver proposed here is primarily for initializing the various
>> parameters/sensitivity/etc. of the AVS hardware, but the actual voltage
>> adjustments are done in hardware by VC/VP.
>
> It's not just a driver, though - it's also creating this power/avs
> thing, though now I look at the code rather than just its shape there's
> not actually an abstraction being added here, it's mostly just straight
> code motion of the arch/arm code that's there already.  The changelog
> and the shape of the code make it sound like this is intended to be
> somewhat generic when really it's providing some OMAP specific tuning
> for the device which is much less of a concern.
>
> I guess for now it's probably OK to just clarify in the documentation
> and say that whoever adds the second driver has to work on making this
> generic :)

Agreed.

In a different thread (which I can't seem to find now) we discussed this
as well, so it just sounds like the changelog should clarify this a bit
better.

Kevin

> This does also sound rather like it's in a similar area to the current
> management work which Durgadoss R (CCed) was working on, though with a
> slightly different application and in the OMAP case it's pretty much all
> hidden in the external processor.

