From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer when device is present
Date: Thu, 10 Nov 2011 10:33:48 -0800
Message-ID: <8762irg73n.fsf@ti.com>
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41374 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753694Ab1KJSd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 13:33:57 -0500
Received: by mail-qy0-f171.google.com with SMTP id 36so7288049qyg.16
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 10:33:55 -0800 (PST)
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
	(Sanjeev Premi's message of "Wed, 9 Nov 2011 10:11:03 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

"Premi, Sanjeev" <premi@ti.com> writes:

>> Current code registers voltage layer details for TWL PMIC even when a
>> TWL has not been registered.  Fix this to only register the TWL with
>> voltage layer when the TWL PMIC is initialized by board-level code.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>

[...]

> I have been out-of-loop from PM for some time. So my query may be
> redundant:
>
> 1) What happens when different PMIC (not TWL series) is registered
>    for AM35x? e.g. TPS65023
>    http://www.spinics.net/lists/linux-omap/msg48630.html
>
> 2) Wouldn't we still fall back into omap3_twl_init()?

I'm not sure I follow the question.

If you're not using a TWL PMIC (or similar derivative) then
omap*_twl_init() should not be called.

If you are using a TWL PMIC, then no, the omap*_twl_init functions
should not be called.

Kevin
