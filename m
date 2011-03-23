From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets into VDD structure
Date: Wed, 23 Mar 2011 07:16:27 -0700
Message-ID: <87r59x9b2c.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-3-git-send-email-khilman@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3B8CA7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:52881 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753340Ab1CWOQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 10:16:31 -0400
Received: by mail-pz0-f45.google.com with SMTP id 36so1347195pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 07:16:30 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C3B8CA7@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Mon, 21 Mar 2011 16:23:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Premi, Sanjeev" <premi@ti.com> writes:

[...]

>
>> diff --git a/arch/arm/mach-omap2/voltage.h 
>> b/arch/arm/mach-omap2/voltage.h
>> index e9f5408..44edc1e 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -133,6 +133,9 @@ struct omap_vdd_info {
>>  	struct dentry *debug_dir;
>>  	u32 curr_volt;
>>  	bool vp_enabled;
>> +
>> +	s16 prm_mod;
>> +	s16 prm_irqst_mod;
>
> [sp] Can we match the type with the functions these are eventually
>      passed to?

Looking closer at this, the functions that these values are passed to
actually take s16 values, so I will leave them as s16.

For example, for OMAP2/3, see prm2xxx_3xxx.h:

extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);

The reason this is important is that on 3430, these module offsets might
actually be negative (c.f. OMAP3430_IVA2_MOD in prcm-common.h)

Kevin
