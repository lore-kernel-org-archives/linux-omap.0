From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 07:40:42 -0500
Message-ID: <4C92104A.5040901@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com> <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58688 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab0IPMkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 08:40:53 -0400
In-Reply-To: <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Linus Walleij had written, on 09/16/2010 07:19 AM, the following:
> 2010/9/15 Kevin Hilman <khilman@deeprootsystems.com>:
> 
>> OMAP SOCs have a standard set of tuples consisting of frequency and
>> voltage pairs that the device will support per voltage domain.  These
>> are called Operating Performance Points or OPPs.
>> (...)
>> This introduces a common handling OPP mechanism accross all OMAPs.
>> As a start this is used for OMAP3.
> 
> OPPs are a generic concept, it's in silicon construction textbooks and all.
> Should this code not be made generic instead? You wouldn't make
> regulators or even DMA platform-specific these days, so why should
> OPPs be?
As far as I see this patch :
hwmod[1] which is omap specific which inturn depends on omap_device. - 
this impacts opp_add function in the opp layer.

[1] http://marc.info/?l=linux-omap&m=128226580816341&w=2
-- 
Regards,
Nishanth Menon
