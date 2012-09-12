From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] ARM: mm: ADD descriptor string to CONFIG_DMA_ADDR_64BIT_T
Date: Wed, 12 Sep 2012 18:27:26 +0530
Message-ID: <CAMQu2gzpiZ8Qa8eGprCscmhFa1zW4Bb4ZEVR=e56tXBSE1pGWQ@mail.gmail.com>
References: <1347429006-10879-1-git-send-email-r.sricharan@ti.com> <5050841A.7030203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43360 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758472Ab2ILM5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 08:57:48 -0400
Received: by yenq11 with SMTP id q11so2206002yen.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 05:57:47 -0700 (PDT)
In-Reply-To: <5050841A.7030203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>

On Wed, Sep 12, 2012 at 6:16 PM, Cyril Chemparathy <cyril@ti.com> wrote:
>
> On 9/12/2012 1:50 AM, R Sricharan wrote:
>>
>> Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
>> the feature is not getting selected.
>> Adding a string description in the Kconfig resolves this.
>>
>> But not sure if this is the right way to fix this.
>>
>
> Shouldn't you be selecting this in your 64-bit dma address capable arch
> instead?
>
Yes. The selection to enable  CONFIG_DMA_ADDR_64BIT_T happens
in the arch which needs it. Since this option was made as simple bool,
looks like because of some KCONFIG magic, it was not getting selected.
Adding some help text does fix the issue and thats is the patch all about.

Regards
Santosh
