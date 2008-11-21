From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH][OMAPZOOM] OMAP3: Fix handling of McBSP registers XCCR and RCCR for OMAP2430/34xx
Date: Fri, 21 Nov 2008 12:03:41 +0530
Message-ID: <002601c94ba3$193117d0$LocalHost@wipultra806>
References: <1227241883-26009-1-git-send-email-mesak82@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB02E22882D0@dbde02.ent.ti.com> <76fbac300811202225m53237b1cq7dde99d5ace9a62a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56804 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbYKUGdy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 01:33:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Misael Lopez <mesak82@gmail.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, "Pandita, Vikram" <vikram.pandita@ti.com>

----- Original Message ----- 
From: "Misael Lopez" <mesak82@gmail.com>
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: <linux-omap@vger.kernel.org>; "Pandita, Vikram" <vikram.pandita@ti.com>
Sent: Friday, November 21, 2008 11:55 AM
Subject: Re: [PATCH][OMAPZOOM] OMAP3: Fix handling of McBSP registers XCCR and 
RCCR for OMAP2430/34xx


>> > @@ -403,8 +408,10 @@ struct omap_mcbsp_reg_cfg {
>> >  u16 rcerh;
>> >  u16 xcerg;
>> >  u16 xcerh;
>> > +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
>> >  u16 xccr;
>> >  u16 rccr;
>> > +#endif
>> >  };
>>
>> Won't this cause a compilation break on non-2430/34xx platforms
>> because you refer to these variables below?
> True... I didn't consider that. Then for non-2430/34xx platforms,
> having those registers in the structure but avoiding to write to them
> is enough, correct? or any other alternative?

Since you  write those registers conditionally for 2430/34xx, i guess removing 
ifdef should do..

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

