From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP34xx vs OMAP 35xx
Date: Sat, 27 Sep 2008 13:08:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301AFF40D64@dbde02.ent.ti.com>
References: <dbdb2ea60809260745m3652748bm2d2773213c57a6b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54852 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYI0Hic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 03:38:32 -0400
In-Reply-To: <dbdb2ea60809260745m3652748bm2d2773213c57a6b5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Twebb,

The "3" in OMAP3 stands for 3rd generation of OMAP devices - both OMAP34x and OMAP35x.

Besides the silicon technology differences (and minor pin-outs) there are varied number of changes between these processor families. One key difference is that OMAP35x family comprises of OMAP3503 (ARM only device), OMAP3515 (ARM + Graphics), OMAP3525 (ARM + C64x+ based IVA) and OMAP3530 (ARM + Graphics + IVA). OMAP3430 will be more closer to OMAP3530.
See http://focus.ti.com/general/docs/gencontent.tsp?contentId=46725 for more details.

As for OMAP3430SDP and OMAP3EVM, the differences are many. They use cases for both these boards were quite different. It translates to form-factor, on-board peripherals, ...

Best regards,
Sanjeev
________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of twebb [taliaferro62@gmail.com]
Sent: Friday, September 26, 2008 8:15 PM
To: linux-omap@vger.kernel.org Mailing List
Subject: OMAP34xx vs OMAP 35xx

I'm relatively new to the list and hoping someone can clarify a few
things.  Does "OMAP3" imply support of both 34xx and 35xx?  When the
term "OMAP3 EVM" is used, does this mean OMAP3430 SDP only or does it
include OMAP35x EVM?

Thanks.
twebb
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

