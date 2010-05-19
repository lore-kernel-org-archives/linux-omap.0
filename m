From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
 interrupt
Date: Wed, 19 May 2010 07:25:15 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BCEAEF6@dlee03.ent.ti.com>
References: <1274137950-18759-3-git-send-email-h-kanigeri2@ti.com>
	<20100518.091130.260105572.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4BC6CD62@dlee03.ent.ti.com>
 <20100519.122751.71107025.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49471 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994Ab0ESMZU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 08:25:20 -0400
In-Reply-To: <20100519.122751.71107025.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi,


> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, May 19, 2010 4:28 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Gupta, Ramesh
> Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
> interrupt
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
> interrupt
> Date: Tue, 18 May 2010 19:03:55 +0200
> 
> >> > diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-
> >> omap/include/plat/iommu.h
> >> > index 0752af9..52a3852 100644
> >> > --- a/arch/arm/plat-omap/include/plat/iommu.h
> >> > +++ b/arch/arm/plat-omap/include/plat/iommu.h
> >> > @@ -80,6 +80,7 @@ struct iommu_functions {
> >> >
> >> >  	int (*enable)(struct iommu *obj);
> >> >  	void (*disable)(struct iommu *obj);
> >> > +	void (*disable_twl)(struct iommu *obj);
> >> >  	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
> >> >
> >> >  	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
> >> > @@ -143,6 +144,7 @@ extern void iotlb_cr_to_e(struct cr_regs *cr,
> struct
> 
> Just one thought, isn't the following a little bit flexible?
> 
> -	void (*disable_twl)(struct iommu *obj);
> +	void (*set_twl)(struct iommu *obj, int on);

-- Probabaly if one want to toggle between enabling and disabling twl during run time. I agree with you about the change so that this can be flexible in future. I will make this change.
Thank you for your inputs.

Thank you,
Best regards,
Hari

