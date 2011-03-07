From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Mon, 7 Mar 2011 13:01:16 -0600
Message-ID: <AANLkTimfSfCc3Pvf_=2MKnHTiC9gVw-_xohHczTUHroH@mail.gmail.com>
References: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
	<1299484388-16205-3-git-send-email-omar.ramirez@ti.com>
	<4D74D5B9.2070907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44626 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753464Ab1CGTBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 14:01:23 -0500
Received: by pvg16 with SMTP id 16so850410pvg.29
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 11:01:16 -0800 (PST)
In-Reply-To: <4D74D5B9.2070907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Mon, Mar 7, 2011 at 6:55 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Omar,
>
> I have some concern about the introduction of a hwmod that does not match
> the actual HW capability. MMU does exist, but there is no SW control for it.

Maybe I'm missing something, but iommu (driver) is meant to control
isp, iva, ipu and dsp MMUs; even with a simple driver interfaced with
iommu, that had nothing to do with the modules mentioned, you could
still deassert the reset, enable the clocks, create your tables and
add entries, and so on... not that it would be useful for anybody
other than the real HW containing the MMU subsystem.

> In fact the only control available is for mmu + cache + logic, and that's
> why the MMU is handle today under the main DSP/IPU hwmod.

AFAIK, sysc configuration is missing from the old hwmods, I thought
separate hwmods gave:

- flexibility: so the system wouldn't dump_stack trying to read mmu
registers, because the user doesn't know ipu/dsp code should handle
the reset first.
- clarity: so iommu handles its own mmu hwmods instead of hard coding
the names of the pseudo hwmods containing the mmu.

> Here you are just duplicating dsp_hwmod and ipu_hwmod with dsp_mmu_hwmod /
> ipu_mmu_hwmod and adding some memory space for the mmu part.
>
> In that case, you can still use the previous name and add the missing
> entries in it.
>
> The only advantage I can see is the usage of a common class that will allow
> you to handle both DSP and IPU using the same "MMU" driver.
>
> So, what are you going to do with the remaining entries for dsp_hwmod and
> ipu_hwmod?

I think these can be removed, and iommu code can handle its own
hwmods; but if you want to update the old ones, that can be done too,
the tradeoff would be that iommu needs to know the name of the hwmods
with mmu data.

Regards,

Omar
