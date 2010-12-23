From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex modules.
Date: Thu, 23 Dec 2010 09:15:10 -0800
Message-ID: <87d3osl8bl.fsf@deeprootsystems.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>
	<1292864437-15353-5-git-send-email-thara@ti.com>
	<4D133B78.5030807@ti.com>
	<a58103fd01d89decba08fcdf282b7f70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63693 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab0LWRPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 12:15:14 -0500
Received: by pxi15 with SMTP id 15so1219155pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 09:15:14 -0800 (PST)
In-Reply-To: <a58103fd01d89decba08fcdf282b7f70@mail.gmail.com> (Vishwanath
	Sripathy's message of "Thu, 23 Dec 2010 20:58:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Anand Sawant <sawant@ti.com>, Nishanth Menon <nm@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>>
>> Please note the following log when enabling SR in Class 3 on an
>> OMAP4430/sdp:
>>
>> [    2.362182] omap2_set_init_voltage: unable to find boot up OPP for
>> vdd_mpu
>> [    2.369384] omap2_set_init_voltage: Unable to put vdd_mpu to its init
>> voltage
>> [    2.369384]
>> [    2.378875] omap2_set_init_voltage: unable to find boot up OPP for
>> vdd_iva
>> [    2.386108] omap2_set_init_voltage: Unable to put vdd_iva to its init
>> voltage
>> [    2.386108]
>> [    2.396484] Power Management for TI OMAP4.
>> [    2.401031] sr_init: No PMIC hook to init smartreflex
>> [    2.406494] smartreflex smartreflex.0: omap_sr_probe: SmartReflex
>> driver initialized
>> [    2.414825] smartreflex smartreflex.1: omap_sr_probe: SmartReflex
>> driver initialized
>> [    2.423187] smartreflex smartreflex.2: omap_sr_probe: SmartReflex
>> driver initialized
>> [    2.431732] SmartReflex Class3 initialized
>>
>> Is it expected?
>> Why do we have that blank line in-between?
>
> I think turbo OPPs are disabled by default in OPP table where as uboot is
> setting mpu and iva to turbo OPP. That's why you are getting this error.

That explains the MPU OPPs, but only raises more questions.  On what
platforms was this tested?  with *and* without turbo OPPs enabled?  Does
the voltage layer properly initialized if the boot up OPP is not found,
and the initial voltage is not set?

> You should not get this error if you enable turbo opps in opp table.

You would still get missing boot up OPP for IVA, as there are currenly
no OMAP4 OPPs for IVA.  Again, begging the question... how was this
tested.

Kevin
