From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer when device is present
Date: Wed, 16 Nov 2011 15:54:36 -0800
Message-ID: <874ny37hdv.fsf@ti.com>
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
	<8762irg73n.fsf@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A8903E1A5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:43216 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753962Ab1KPXyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 18:54:41 -0500
Received: by mail-gx0-f182.google.com with SMTP id k3so479292ggn.13
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 15:54:40 -0800 (PST)
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A8903E1A5@DBDE01.ent.ti.com>
	(Sanjeev Premi's message of "Fri, 11 Nov 2011 10:21:44 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

"Premi, Sanjeev" <premi@ti.com> writes:

>  
>
>> -----Original Message-----
>> From: Hilman, Kevin 
>> Sent: Friday, November 11, 2011 12:04 AM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org; 
>> linux-arm-kernel@lists.infradead.org; Koyamangalath, Abhilash
>> Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with 
>> voltage layer when device is present
>> 
>> "Premi, Sanjeev" <premi@ti.com> writes:
>> 
>> >> Current code registers voltage layer details for TWL PMIC 
>> even when a
>> >> TWL has not been registered.  Fix this to only register 
>> the TWL with
>> >> voltage layer when the TWL PMIC is initialized by board-level code.
>> >> 
>> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> 
>> [...]
>> 
>> > I have been out-of-loop from PM for some time. So my query may be
>> > redundant:
>> >
>> > 1) What happens when different PMIC (not TWL series) is registered
>> >    for AM35x? e.g. TPS65023
>> >    http://www.spinics.net/lists/linux-omap/msg48630.html
>> >
>> > 2) Wouldn't we still fall back into omap3_twl_init()?
>> 
>> I'm not sure I follow the question.
>> 
>> If you're not using a TWL PMIC (or similar derivative) then
>> omap*_twl_init() should not be called.
>> 
>> If you are using a TWL PMIC, then no, the omap*_twl_init functions
>> should not be called.
>
> When I read this function (in the patch), if pmic_i2c_board_info.irq
> is non-zero, omap3_twl_init() and omap4_twl_init() are called.
>
> So my question was, for the case when PMIC is not TWL family. Then,
> is checking ".irq" sufficient to prevent the execution of twl specific
> functions.

If PMIC is not TWL family, then I don't expect any functions in
twl_common.c to be called.

Kevin
