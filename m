From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
 interrupt
Date: Wed, 19 May 2010 12:27:51 +0300 (EEST)
Message-ID: <20100519.122751.71107025.Hiroshi.DOYU@nokia.com>
References: <1274137950-18759-3-git-send-email-h-kanigeri2@ti.com>
	<20100518.091130.260105572.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4BC6CD62@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38995 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab0ESJ3R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:29:17 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4BC6CD62@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, grgupta@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] omap: iommu-add functionality to get TLB miss interrupt
Date: Tue, 18 May 2010 19:03:55 +0200

>> > diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-
>> omap/include/plat/iommu.h
>> > index 0752af9..52a3852 100644
>> > --- a/arch/arm/plat-omap/include/plat/iommu.h
>> > +++ b/arch/arm/plat-omap/include/plat/iommu.h
>> > @@ -80,6 +80,7 @@ struct iommu_functions {
>> >
>> >  	int (*enable)(struct iommu *obj);
>> >  	void (*disable)(struct iommu *obj);
>> > +	void (*disable_twl)(struct iommu *obj);
>> >  	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
>> >
>> >  	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
>> > @@ -143,6 +144,7 @@ extern void iotlb_cr_to_e(struct cr_regs *cr, struct

Just one thought, isn't the following a little bit flexible?

-	void (*disable_twl)(struct iommu *obj);
+	void (*set_twl)(struct iommu *obj, int on);

