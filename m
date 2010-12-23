From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex
 modules.
Date: Thu, 23 Dec 2010 15:05:03 +0100
Message-ID: <4D13570F.9050503@ti.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com> <1292864437-15353-5-git-send-email-thara@ti.com> <4D133B78.5030807@ti.com> <AANLkTi=P-3aQSk3Q2WyAAp-8WwwtxC_aOGLW+7WGd4mj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab0LWOFN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 09:05:13 -0500
In-Reply-To: <AANLkTi=P-3aQSk3Q2WyAAp-8WwwtxC_aOGLW+7WGd4mj@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

On 12/23/2010 2:25 PM, Menon, Nishanth wrote:
> On Thu, Dec 23, 2010 at 06:07, Cousson, Benoit<b-cousson@ti.com>  wrote:
>
>>
>> Please note the following log when enabling SR in Class 3 on an OMAP4430/sdp:
>>
>> [    2.362182] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
>> [    2.369384] omap2_set_init_voltage: Unable to put vdd_mpu to its init voltage
>> [    2.369384]
>> [    2.378875] omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
>> [    2.386108] omap2_set_init_voltage: Unable to put vdd_iva to its init voltage
>> [    2.386108]
>> [    2.396484] Power Management for TI OMAP4.
>> [    2.401031] sr_init: No PMIC hook to init smartreflex
>> [    2.406494] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
>> [    2.414825] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
>> [    2.423187] smartreflex smartreflex.2: omap_sr_probe: SmartReflex driver initialized
>> [    2.431732] SmartReflex Class3 initialized
>>
> Dumb question: how are you testing this? just boot log? or additional
> patch for DVFS?

Unfortunately, it is just a boot log since I do not have any DVFS code 
on top of it :-(

That's why I was not expecting any errors at that time.

Benoit

