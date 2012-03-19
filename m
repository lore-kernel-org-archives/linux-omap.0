From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 23:36:31 +0530
Message-ID: <CABb+yY3cJZO_A+Z5vtOkyt5XEX7exhPk5ZG8Mm35n3DFryBk5w@mail.gmail.com>
References: <4F22DEF2.5000807@ti.com>
	<201203191406.35064.arnd@arndb.de>
	<20120319153334.GF16389@n2100.arm.linux.org.uk>
	<201203191611.59064.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab2CSSGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 14:06:32 -0400
Received: by bkcik5 with SMTP id ik5so4511161bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 11:06:31 -0700 (PDT)
In-Reply-To: <201203191611.59064.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, Thomas Abraham <thomas.abraham@linaro.org>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Mar 19, 2012 at 9:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Secondly, there are platforms (Samsung) where peripherals are connected
>> to more than one DMA controller, and either DMA controller can be used -
>> I'm told by Jassi that there's reasons why you'd want to select one or
>> other as the target at runtime.
>
> How common is that? If there are only a few drivers that have this
> requirement, we could have this represented in the driver binding, by
> listing multiple channels and giving the device the choice.
>
All Samsung SoCs (last ~4yrs) with PL330 have some peripherals
that could be served by more than one PL330 instance.
The requirement is not from any driver and it is nothing Samsung specific.
Any platform with 1:n client:dmac might want to do stuff like serving
a new channel request from an already active DMAC, rather than
invoking otherwise fully idle one.
Similarly for Mem->Mem, the PL330 distributes its cycles between
active channels, so a platform might want channel allocation uniformly
across PL330 instances.

-jassi
