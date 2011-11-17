From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer when device is present
Date: Thu, 17 Nov 2011 11:20:39 -0800
Message-ID: <878vne5zeg.fsf@ti.com>
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
	<8762irg73n.fsf@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A8903E1A5@DBDE01.ent.ti.com>
	<874ny37hdv.fsf@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A8904BF32@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:39197 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755232Ab1KQTUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 14:20:50 -0500
Received: by mail-ey0-f172.google.com with SMTP id 24so2786035eyg.3
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 11:20:49 -0800 (PST)
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A8904BF32@DBDE01.ent.ti.com>
	(Sanjeev Premi's message of "Thu, 17 Nov 2011 13:20:04 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

"Premi, Sanjeev" <premi@ti.com> writes:

[...]

>> 
>> If PMIC is not TWL family, then I don't expect any functions in
>> twl_common.c to be called.
>
> This is the reason I wanted to know if the check on ".irq" in the
> patch is sufficient. If any PMIC requires & sets "pmic_i2c_board_info.irq"
> then both omap3_twl_init() and omap4_twl_init() will be called.

Only TWL PMICs should be calling these functions, as they are in code
for TWL PMICs *only*.

If you have a non-TWL PMIC, then you should not be using the omap_pmic_*
functions.

Admittedly, these omap_pmic_* functions should be renamed to be clear
that they are TWL specific.

Kevin
