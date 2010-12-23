From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex
 modules.
Date: Thu, 23 Dec 2010 11:24:38 -0600
Message-ID: <4D1385D6.6090407@ti.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>	<1292864437-15353-5-git-send-email-thara@ti.com>	<4D133B78.5030807@ti.com>	<a58103fd01d89decba08fcdf282b7f70@mail.gmail.com> <87d3osl8bl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:48099 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281Ab0LWRYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 12:24:42 -0500
Received: by gyb11 with SMTP id 11so2605984gyb.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 09:24:41 -0800 (PST)
In-Reply-To: <87d3osl8bl.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Benoit Cousson <b-cousson@ti.com>, Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Anand Sawant <sawant@ti.com>

Kevin Hilman had written, on 12/23/2010 11:15 AM, the following:
> Vishwanath Sripathy <vishwanath.bs@ti.com> writes:
> 
> [...]
> 
>>> Please note the following log when enabling SR in Class 3 on an
>>> OMAP4430/sdp:
>>>
>>> [    2.362182] omap2_set_init_voltage: unable to find boot up OPP for
>>> vdd_mpu
>>> [    2.369384] omap2_set_init_voltage: Unable to put vdd_mpu to its init
>>> voltage
>>> [    2.369384]
>>> [    2.378875] omap2_set_init_voltage: unable to find boot up OPP for
>>> vdd_iva
>>> [    2.386108] omap2_set_init_voltage: Unable to put vdd_iva to its init
>>> voltage
>>> [    2.386108]
>>> [    2.396484] Power Management for TI OMAP4.
>>> [    2.401031] sr_init: No PMIC hook to init smartreflex
>>> [    2.406494] smartreflex smartreflex.0: omap_sr_probe: SmartReflex
>>> driver initialized
>>> [    2.414825] smartreflex smartreflex.1: omap_sr_probe: SmartReflex
>>> driver initialized
>>> [    2.423187] smartreflex smartreflex.2: omap_sr_probe: SmartReflex
>>> driver initialized
>>> [    2.431732] SmartReflex Class3 initialized
>>>
>>> Is it expected?
>>> Why do we have that blank line in-between?
>> I think turbo OPPs are disabled by default in OPP table where as uboot is
>> setting mpu and iva to turbo OPP. That's why you are getting this error.
> That explains the MPU OPPs, but only raises more questions.  On what
> platforms was this tested?  with *and* without turbo OPPs enabled?  Does
> the voltage layer properly initialized if the boot up OPP is not found,
> and the initial voltage is not set?
> 
>> You should not get this error if you enable turbo opps in opp table.
If the platform SDP4430 is capable of booting up in higher (turbo) OPP, 
that OPP should have been enabled in the board file! I have'nt seen a 
patch for that yet

> You would still get missing boot up OPP for IVA, as there are currenly
> no OMAP4 OPPs for IVA.  Again, begging the question... how was this
> tested.
Further, why is SR enabled by default on this platform if it does not 
have all domains available to be enabled (e.x. we dont have it on 
PandaBoard even though it is OMAP4 rt?)

-- 
Regards,
Nishanth Menon
