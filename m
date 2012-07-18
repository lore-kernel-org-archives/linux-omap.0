From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
Date: Wed, 18 Jul 2012 12:15:00 -0500
Message-ID: <CALLhW=7PcocUyG=b+LszJj+hvNqKAY8Gf6hNPc0XW3XtF=hG9g@mail.gmail.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
	<20120717101100.GI4213@amd.com>
	<CAK=WgbbVvFoGRoitscvTRUWUWd=3HLiuvs6ZUNZnAbF67tXO5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:49452 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2GRRPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 13:15:01 -0400
Received: by vcbfk26 with SMTP id fk26so1291354vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 10:15:00 -0700 (PDT)
In-Reply-To: <CAK=WgbbVvFoGRoitscvTRUWUWd=3HLiuvs6ZUNZnAbF67tXO5A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org

On 17 July 2012 05:51, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> + Paul
>
> On Tue, Jul 17, 2012 at 1:11 PM, Joerg Roedel <joerg.roedel@amd.com> wrote:
>> On Fri, Jun 15, 2012 at 08:55:58PM -0500, Omar Ramirez Luna wrote:
>>> Omar Ramirez Luna (6):
>>>   ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
>>>   ARM: OMAP3: hwmod data: add mmu data for iva and isp
>>>   ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
>>>   ARM: OMAP3/4: iommu: migrate to hwmod framework
>>>   ARM: OMAP2+: iommu: add reset handling
>>>   ARM: OMAP3/4: iommu: adapt to runtime pm
>>
>> What happens with this patch-set. Comments anyone? Ohad?
>
> Looks like it depends on a few OMAP hwmod changes (reset handling)
> which require Paul's ACK.

That's correct, sorry if I failed to mention that in the cover-letter,
but it does depend on:

http://lkml.indiana.edu/hypermail/linux/kernel/1207.2/00361.html

For the hwmod reset handling. Mainly, I wanted to gather comments for
this patch set.

- omar
