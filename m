From: "Porter, Matt" <mporter@ti.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 18:18:32 +0000
Message-ID: <0C6C342C-CE82-4585-8F70-3300FA7AB826@ti.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
 <20120321181259.GJ3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50490 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440Ab2CUSSp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 14:18:45 -0400
In-Reply-To: <20120321181259.GJ3226@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <06F158BA31117B469F682E0410203C8E@owa.mail.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Dill, Russ" <russ.dill@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<tony@atomide.com>" <tony@atomide.com>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>


On Mar 21, 2012, at 2:13 PM, Mark Brown wrote:

> On Wed, Mar 21, 2012 at 10:55:54AM -0700, Russ Dill wrote:
> 
>> 
>> +	for (i = 0; i < ARRAY_SIZE(smsc911x_refs) * num; i++) {
>> +		int id;
>> +		char *name;
>> +
>> +		id = board_data[i / num].id;
>> +		if (id != -1)
>> +			name = kasprintf(GFP_KERNEL, "smsc911x.%d", id);
>> +		else
>> +			name = kstrdup("smsc911x", GFP_KERNEL);
> 
> This seems pretty much insane, it's costing a lot more to faff around
> like this than it's worth.  Just do the setup in the individual boards,
> if you really have no idea what's supplying the device (which seems a
> bit unusual, more boards like this have things coming off the PMIC than
> don't) there's now regulator_register_fixed() which cuts down on the
> boilerplate a little.
> 
> I'd have complained about the original code if I'd noticed it wasn't a
> patch for a particular board as the breakage you've found is obvious.
> The regulation constraints it adds are bogus too, it's setting
> REGULATOR_CHANGE_MODE on a regulator that doesn't support modes and
> REGULATOR_CHANGE_STATUS without supplying the enable GPIO.

The original patch for the problem was specific to the fixed regulator
on the OMAP3EVM/AMDM37xxEVM board...it was rejected. I was asked to
put something generic in gpmc-smsc911x.c like this.

-Matt

