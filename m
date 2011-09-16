From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 03/11] DT: regulator: Helper routine to extract regulator_init_data
Date: Fri, 16 Sep 2011 12:45:55 +0530
Message-ID: <4E72F7AB.3030801@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <1316085727-15023-4-git-send-email-rnayak@ti.com> <20110915134427.GJ7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54048 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752712Ab1IPHQB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 03:16:01 -0400
Received: by mail-gx0-f175.google.com with SMTP id 4so3711237gxk.20
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 00:16:00 -0700 (PDT)
In-Reply-To: <20110915134427.GJ7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thursday 15 September 2011 07:14 PM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:51:59PM +0530, Rajendra Nayak wrote:
>
>>   .../devicetree/bindings/regulator/regulator.txt    |   37 +++++++++
>>   drivers/of/Kconfig                                 |    6 ++
>>   drivers/of/Makefile                                |    1 +
>>   drivers/of/of_regulator.c                          |   85 ++++++++++++++++++++
>>   include/linux/of_regulator.h                       |   23 +++++
>
> Don't go hiding the bindings for things away from the code they're
> binding.  Bindings for the regualtor API are a regulator API thing and
> should be part of the regulator API code.

Sure, Grant seems to think so too, so I'll just move these into
drivers/regulator/

>
>> +Required properties:
>> +- compatible: Must be "regulator";
>
> Is this idiomatic or should we just have a helper that parses a big list
> of properties from the device node?

I will just be dropping this and use compatible
to specify the specific device type like "regulator-twl" or 
"regulator-fixed".

>
>> +- mode-fast: boolean, Can handle fast changes in its load
>> +- mode-normal: boolean, Normal regulator power supply mode
>> +- mode-idle: boolean, Can be more efficient during light loads
>> +- mode-standby: boolean, Can be most efficient during light loads
>
> I guess these are actually permissions to set the given modes?  The
> documentation should be clearer.

Ok

>
>> +- apply-uV: apply uV constraint if min == max
>
> This seems a bit Linux/runtime policy specific (especially the last
> bit).

So these bindings should be defined differently?
