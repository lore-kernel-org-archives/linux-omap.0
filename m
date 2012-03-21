From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x devices.
Date: Wed, 21 Mar 2012 13:45:49 -0700
Message-ID: <CA+Bv8XYXhKfuFiib6cRtX9tS_QoRBN+=OOBrKoLzMwe5u6Aghg@mail.gmail.com>
References: <4F6324D5.9010106@uni-dortmund.de>
	<1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
	<20120321181259.GJ3226@opensource.wolfsonmicro.com>
	<A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
	<20120321183957.GM9859@atomide.com>
	<20120321190028.GK3226@opensource.wolfsonmicro.com>
	<20120321193046.GN9859@atomide.com>
	<20120321193839.GM3226@opensource.wolfsonmicro.com>
	<20120321194133.GP9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58442 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760232Ab2CUUpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 16:45:49 -0400
Received: by dajr28 with SMTP id r28so2073708daj.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 13:45:49 -0700 (PDT)
In-Reply-To: <20120321194133.GP9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Porter, Matt" <mporter@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>

On Wed, Mar 21, 2012 at 12:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [120321 12:41]:
>> On Wed, Mar 21, 2012 at 12:30:47PM -0700, Tony Lindgren wrote:
>> > * Mark Brown <broonie@opensource.wolfsonmicro.com> [120321 12:03]:
>>
>> > > That should be changed to pass in a boolean flag rather than a pointer
>> > > to platform device - the board may not have direct access to the
>> > > relevant regulator (eg, if it's part of a MFD) or the regulator may be
>> > > on another bus like I2C (for simpler regulator only devices).
>>
>> > Hmm I see. This means that we need to patch some board files anyways
>> > for the boolean flag to use the fixed regulator. This is because for
>> > some cases vddvario and vdd33a regulators can come from the mfd/tps/twl
>> > chip and it's unsafe to assume that gpmc-smsc911x.c can set up these
>> > regulators automatically. Passing a boolean flag to not set up the
>> > default regulator would work too, but we'd rather eventually see
>> > the real board specific regulators being patched in.
>>
>> Yes, ideally the boards would do everything and gpmc-smsc911x.c should
>> be able to completely ignore regulators.
>
> OK, great, let's do that then.
>
>> > So if that's the case, we might as well patch the board files
>> > to add the fixed regulators for each one and drop all the regulator
>> > code from gpmc-smsc911x.c.
>>
>> That's my preferred option, hopefully with the helpers we have for
>> regulator registration we shouldn't need to add device specific helpers.
>
> Russ, care to update your patch accordingly? Those helpers are queued
> in linux-next.
>

No problem.
