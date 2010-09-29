From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
Date: Wed, 29 Sep 2010 14:34:36 +0300
Message-ID: <AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41806 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab0I2Leh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 07:34:37 -0400
Received: by bwz11 with SMTP id 11so426685bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 04:34:36 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Marathe, Yogesh" <yogesh_marathe@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

On Mon, Sep 27, 2010 at 7:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Yogesh is coming from dsplink requirement to use iommu. I see his comment as why Bridge requirement should be imposed on other IPCs that need iommu.

Ahh, that explains a lot. However, dsp-link can just enable
CONFIG_MPU_BRIDGE_IOMMU, and that's it, right? Perhaps it would make
sense to rename to CONFIG_OMAP_IOMMU_IVA2, or something like that. But
not remove it and break tidspbridge, which is already in staging.

Once both are working happily with CONFIG_OMAP_IOMMU_IVA2 on, _then_
it can be removed.

-- 
Felipe Contreras
