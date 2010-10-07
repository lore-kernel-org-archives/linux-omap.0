From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF
Date: Thu, 7 Oct 2010 15:23:07 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F471C8EC@dlee06.ent.ti.com>
References: <1286477021-23169-1-git-send-email-x0095840@ti.com>
 <20101007.221401.226802875.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101007.221401.226802875.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "david.cohen@nokia.com" <david.cohen@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi Hiroshi, 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Thursday, October 07, 2010 2:14 PM
> To: Guzman Lugo, Fernando
> Cc: felipe.contreras@nokia.com; ameya.palande@nokia.com; 
> david.cohen@nokia.com; linux-kernel@vger.kernel.org; 
> andy.shevchenko@gmail.com; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] iovmm: IVA2 MMU range is from 0x11000000 
> to 0xFFFFFFFF
> 
> From: ext Fernando Guzman Lugo <x0095840@ti.com>
> Subject: [PATCH] iovmm: IVA2 MMU range is from 0x11000000 to 
> 0xFFFFFFFF
> Date: Thu, 7 Oct 2010 20:43:41 +0200
> 
> > IV2 MMU capable addresses start from 0x11000000
> 
> Wouldn't it be better to add an general API to configure the 
> valid 'da' range in advance?

Yes I was thinking in passing start and end range in iommu_get
(because don't need to change rage, it is needed only one time)
And create new elements in iommu struct for start and end address
 or maybe defining the range statically when the structures are
Fillup for omapxxx. But I tought I was break other users of iommu
Like omap4 and isp and it would be easier to accept an small patch.

But I am agree with you it would be better to make it configurable.
As tidspbridge iommu migratio seems to be target to 37 I can 
Make a new patch and resend.

Please let me know if you have some suggestions.

Regards,
Fernando.

> 
> I don't think that it's a good idea to introduce the iommu
> instance("iva2:iommu") specific code here.
> 