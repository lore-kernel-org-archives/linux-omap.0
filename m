From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick
 clock
Date: Wed, 27 Mar 2013 06:17:00 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3B0AE@DBDE01.ent.ti.com>
References: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1303261812010.23957@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab3C0GRM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 02:17:12 -0400
In-Reply-To: <alpine.DEB.2.00.1303261812010.23957@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, March 26, 2013 11:43 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Tony Lindgren
> Subject: Re: [PATCH] ARM: AM33XX: Add missing .clkdm_name to
> clkdiv32k_ick clock
> 
> On Mon, 25 Mar 2013, Vaibhav Hiremath wrote:
> 
> > During common-clock migration, .clkdm_name field got missed
> > for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> > unused; so boot process will try to disable the clockdomain
> > even childs of this clock is enabled, which keeps child modules
> > in idle mode.
> 
> Looks fine to me.  You're planning to update the patch description,
> right?
> So should I wait until you repost it?
> 
Yeup, will submit today.

> Also you should probably trim the crash log after "[    2.626025] LR is
> at
> clk_enable+0x30/0x3c"
> 
Ok, 

Thanks,
Vaibhav

> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
