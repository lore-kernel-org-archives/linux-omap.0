From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer
 when device is present
Date: Fri, 18 Nov 2011 17:58:14 +0000
Message-ID: <E28AAFD00EFAA646AE3DF9B89CD24A89052B4A@DBDE01.ent.ti.com>
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
	<8762irg73n.fsf@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A8903E1A5@DBDE01.ent.ti.com>
	<874ny37hdv.fsf@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A8904BF32@DBDE01.ent.ti.com>
 <878vne5zeg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44326 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab1KRR6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 12:58:25 -0500
In-Reply-To: <878vne5zeg.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Koyamangalath, Abhilash" <abhilash.kv@ti.com>

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Friday, November 18, 2011 12:51 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Koyamangalath, Abhilash
> Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with 
> voltage layer when device is present
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> [...]
> 
> >> 
> >> If PMIC is not TWL family, then I don't expect any functions in
> >> twl_common.c to be called.
> >
> > This is the reason I wanted to know if the check on ".irq" in the
> > patch is sufficient. If any PMIC requires & sets 
> "pmic_i2c_board_info.irq"
> > then both omap3_twl_init() and omap4_twl_init() will be called.
> 
> Only TWL PMICs should be calling these functions, as they are in code
> for TWL PMICs *only*.
> 
> If you have a non-TWL PMIC, then you should not be using the 
> omap_pmic_*
> functions.
> 
> Admittedly, these omap_pmic_* functions should be renamed to be clear
> that they are TWL specific.

Thanks. We also need mechanism - may be name - to identify the PMIC family
at this stage; and that should be used to select the corresponding init function.

~sanjeev

> 
> Kevin
> 