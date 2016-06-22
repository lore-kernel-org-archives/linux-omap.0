From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 1/9] regulator: tps65217: Enable suspend configuration
Date: Wed, 22 Jun 2016 15:44:02 +0530
Message-ID: <576A64EA.4000607@ti.com>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
 <20160621190848.GF28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621190848.GF28202@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org



On Wednesday 22 June 2016 12:38 AM, Mark Brown wrote:
> On Mon, Jun 20, 2016 at 02:13:30PM +0530, Keerthy wrote:
>
>> +static struct tps65217_regulator_data regulator_data[TPS65217_NUM_REGULATOR];
>
> Why is this a static global?
>
>> +		/* Store default strobe info */
>> +		ret = tps65217_reg_read(tps, regulators[i].bypass_reg, &val);
>> +
>> +		regulator_data[i].strobe = val & regulators[i].bypass_mask;
>> +
>
> Not sure what this is doing...  I think this needs splitting up a bit,
> it looks like it's a bit more than just adding the ops (which should be
> generic things), that bit seems OK but there's these other bits in
> there as well.

Okay. Let me explain a bit more here:

The TPS65217 has a pre-defined power-up / power-down sequence which in a 
typical application does not need
to be changed. However, it is possible to define custom sequences under 
I2C control. The power-up sequence is
defined by strobes and delay times. Each output rail is assigned to a 
strobe to determine the order in which the
rails are enabled.

Every regulator of tps65217 PMIC has sequence registers and every 
regulator has a default strobe value
and gets disabled when a particular power down sequence occurs.

So as to keep it on during suspend we write value 0 to strobe so that 
the regulator is out of all sequencers and is not impacted by any power 
down sequence. We are saving the default strobe value during probe so 
that when we want to regulator to be enabled during suspend we write 0 
to strobe and when we want it to get disabled during suspend we write 
the default saved strobe value.

Hence saving it in a static array and using it later in the ops 
functions to disable or enable regulator during suspend.

>
