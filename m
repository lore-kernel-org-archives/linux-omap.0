From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: AM57xx/DRA7: Update SoC voltage rail limits to
 match data sheet
Date: Tue, 26 Apr 2016 12:05:21 -0500
Message-ID: <571F9FD1.2020404@ti.com>
References: <1461140319-32026-1-git-send-email-nm@ti.com>
 <20160426170300.GC5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160426170300.GC5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/26/2016 12:03 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160420 01:20]:
>> As per the data sheet starting from SPRUHQ0H (Nov 2015 - Latest[1]),
>> VDD_CORE can vary from 0.85v to 1.15v for AVS class0. VDD GPU/DSP
>> et.al. can range from 0.85v to 1.25V with AVS class0
>>
>> Since dynamic voltage scaling is disabled for DRA7/AM57xx SoCs for
>> all SoC rails other than MPU, the bootloader is responsible for
>> setting up the AVS class0 voltage, however, with wrong voltage machine
>> constraints in dtb, regulator framework will lower the voltage below
>> the required voltage levels for certain samples in production flow.
>> This can cause catastrophic failures which can be pretty hard to
>> identify.
>>
>> Update board files which don't match required specification.
>>
>> [1] http://www.ti.com/product/AM5728/datasheet/specifications#SPRT637-7340
> 
> Applying into omap-for-v4.7/dt thanks. This does not apply to
> v4.6-rc, so assuming this is not an urgent fix.

Thanks. Yep, it is not an emergency regression fix since most of the
platforms out in the field are not impacted.


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
