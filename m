From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
Date: Mon, 11 Oct 2010 10:54:23 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F47B2C14@dlee06.ent.ti.com>
References: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
	<1286790830-13505-2-git-send-email-felipe.contreras@gmail.com>
	<20101011.152822.226794892.Hiroshi.DOYU@nokia.com>
 <AANLkTikEC9yJuAZPr25+8F7Cggce3qO2b5aCz-7cQPd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47932 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424Ab0JKPyb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 11:54:31 -0400
In-Reply-To: <AANLkTikEC9yJuAZPr25+8F7Cggce3qO2b5aCz-7cQPd9@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Marathe, Yogesh" <yogesh_marathe@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
> Sent: Monday, October 11, 2010 8:00 AM
> To: Hiroshi DOYU
> Cc: linux-omap@vger.kernel.org; greg@kroah.com; 
> felipe.contreras@nokia.com; Guzman Lugo, Fernando; Marathe, 
> Yogesh; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
> 
> On Mon, Oct 11, 2010 at 3:28 PM, Hiroshi DOYU 
> <Hiroshi.DOYU@nokia.com> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
> > Subject: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
> > Date: Mon, 11 Oct 2010 11:53:49 +0200
> >
> >> From: Felipe Contreras <felipe.contreras@nokia.com>
> >>
> >> It seems dsp-link will do this, and tidspbridge too at some point, 
> >> but right now it's not possible to select CONFIG_MPU_BRIDGE_IOMMU.
> >
> > Why does it have to be selectable?
> 
> You mean why is it desirable to turn it off? Right now 
> there's a mess of tidspbridge branches, some work, some 
> don't, some have migrated to iommu, some don't. In mainline 
> all this, plus the status on dsp-link, should be irrelevant, 
> a configuration solves all the issues.
> 
> Once the iommu migration works (haven't managed to get it 
> working myself), and it has been merged into mainline, then 
> we can think about enabling it unconditionally. In the 
> meantime, enabling unconditionally would break the 
> tidspbridge that is in staging (mainline).

What is the problem enabling unconditionally?

The iva2 iommu does not start working until you call iommu_get.
So if for some reason you are using the dspbridge with custom
Iommu implementation it should not cause any collision with
Iommu module.

Regards,
Fernando.

> 
> > Please Cc: linux-arm-kernel@lists.infradead.org too.
> 
> Will do, after you reply the above.
> 
> --
> Felipe Contreras
> 