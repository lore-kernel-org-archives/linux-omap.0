From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCHv3 5/9] dspbridge: add mmufault support
Date: Thu, 1 Jul 2010 13:04:08 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4CA5645D@dlee03.ent.ti.com>
References: <1277942401-3566-1-git-send-email-x0095840@ti.com>
 <1277942401-3566-2-git-send-email-x0095840@ti.com>
 <1277942401-3566-3-git-send-email-x0095840@ti.com>
 <1277942401-3566-4-git-send-email-x0095840@ti.com>
 <1277942401-3566-5-git-send-email-x0095840@ti.com>
 <1277942401-3566-6-git-send-email-x0095840@ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4CA563BC@dlee03.ent.ti.com>
 <496565EC904933469F292DDA3F1663E602CBDD373C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <496565EC904933469F292DDA3F1663E602CBDD373C@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "ohad@wizery.com" <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org

> > > +	da = iommu_read_reg(mmu, MMU_FAULT_AD);
> > > +	iommu_write_reg(mmu, 0, MMU_IRQENABLE);
> >
> > -- Isn't the MMU already enabled at this point when the function
> callback
> > is called by iommu ?
> 
> This line is actually disabling the interrupts. I am writing "0x0" in the
> MMU_IRQENABLE.

-- oops ! sorry about that. Didn't pay attention to 0x0. Yes, this should work.

Best regards,
Hari
