From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH 03/11] DT: regulator: Helper routine to extract regulator_init_data
Date: Thu, 15 Sep 2011 13:17:32 -0500
Message-ID: <4E72413C.7020508@gmail.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <1316085727-15023-4-git-send-email-rnayak@ti.com> <20110915134427.GJ7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50745 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab1IOSRf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 14:17:35 -0400
Received: by iaqq3 with SMTP id q3so1408564iaq.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 11:17:35 -0700 (PDT)
In-Reply-To: <20110915134427.GJ7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On 09/15/2011 08:44 AM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:51:59PM +0530, Rajendra Nayak wrote:
> 
>>  .../devicetree/bindings/regulator/regulator.txt    |   37 +++++++++
>>  drivers/of/Kconfig                                 |    6 ++
>>  drivers/of/Makefile                                |    1 +
>>  drivers/of/of_regulator.c                          |   85 ++++++++++++++++++++
>>  include/linux/of_regulator.h                       |   23 +++++
> 
> Don't go hiding the bindings for things away from the code they're
> binding.  Bindings for the regualtor API are a regulator API thing and
> should be part of the regulator API code.
> 

Agreed, but FYI not all subsystem maintainers agree. Moving of_i2c.c
into i2c was rejected.

Rob

>> +Required properties:
>> +- compatible: Must be "regulator";
> 
> Is this idiomatic or should we just have a helper that parses a big list
> of properties from the device node?
> 
>> +- mode-fast: boolean, Can handle fast changes in its load
>> +- mode-normal: boolean, Normal regulator power supply mode
>> +- mode-idle: boolean, Can be more efficient during light loads
>> +- mode-standby: boolean, Can be most efficient during light loads
> 
> I guess these are actually permissions to set the given modes?  The
> documentation should be clearer.
> 
>> +- apply-uV: apply uV constraint if min == max
> 
> This seems a bit Linux/runtime policy specific (especially the last
> bit).
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

