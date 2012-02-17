From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv9 3/5] arm: omap3: add common twl configurations for vdd1
 and vdd2
Date: Fri, 17 Feb 2012 17:49:02 +0100
Message-ID: <4F3E84FE.3060407@ti.com>
References: <1329388073-17879-1-git-send-email-t-kristo@ti.com> <1329388073-17879-4-git-send-email-t-kristo@ti.com> <CAOMWX4d8C4pjYSr+i3qmqfJHDsHQdtRkvfbGR29U7hXf0SkVZg@mail.gmail.com> <1329476814.4102.433.camel@sokoban> <CAOMWX4cmwFKsQ9SV-9c=tfCEqdQ9N2TcJUJ+Sh=syBgOSPz1gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49377 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2BQQtL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 11:49:11 -0500
In-Reply-To: <CAOMWX4cmwFKsQ9SV-9c=tfCEqdQ9N2TcJUJ+Sh=syBgOSPz1gg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

On 2/17/2012 4:22 PM, Menon, Nishanth wrote:
> On Fri, Feb 17, 2012 at 05:06, Tero Kristo<t-kristo@ti.com>  wrote:
>> On Thu, 2012-02-16 at 12:23 -0600, Menon, Nishanth wrote:
>>> On Thu, Feb 16, 2012 at 04:27, Tero Kristo<t-kristo@ti.com>  wrote:
>>>> VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
>>>> to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
>>>> are needed by DVFS.
>>>>
>>>> Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manual.
>>>
>>> Please provide documentation version referenced, else we will loose
>>> track of details at a later point of time.
>>
>> How should this be marked down? There are too many naming conventions
>> for the TI docs, and I couldn't find any example from kernel commit logs
>> for this. Personally I was using twl5030 es1.2 DM rev E / twl4030 es3.1
>> DM rev L. Or should the literature code be used? Or is there also some
>> numerical version info available somewhere?
> Literature code is the best one. Adding, along with it, a human
> readable "TWL4030 ES3.1 DM rev L"
> is even better :)
>
>>> Also should we rename VDD1 with vdd_mpu_iva and VDD2 as vdd_core to be readable?
>>
>> This can be changed if needed, it is just a name.
>> regulator/twl-regulator.c is using vdd1 / vdd2 though, and also
>> pmic_data struct uses these. All the other regulators use Vxx type
>> naming also. These are the names I see on my board through
>> sys/class/regulator:
>>
>> dummy
>> VDD1
>> VDD2
>> VMMC1
>> VDAC
>> VDVI
>> VSIM
>
> no strong opinions on this - thinking from OMAP perspective, I read
> vdd_mpu,core,iva. from TWL perspective,
> 4030/5030 - VDD1,2
> 6030: VCORE1,2,3
> 6032: SMPS1...5
> so I guess it is fine as long as it is in context.

Yes, you should take care of using the proper name depending of the context.

For TWL point of view this is just 2 generic SMPS outputs so VDD1 and 
VDD2 are the only relevant name you can use.

As far as OMAP3 is concern, the power rails were named as well vdd1 and 
vdd2, but it was so confusing that we changed that on OMAP4 and maybe on 
3630 to vdd_mpu, vdd_iva and vdd_core.

So using this terminology for OMAP power rails is strongly recommended.

Regards,
Benoit

