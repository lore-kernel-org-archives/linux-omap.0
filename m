From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Thu, 7 Mar 2013 10:02:27 -0300
Message-ID: <CALF0-+VaX8i5E8ggh3=NaLfAJm2gMOv2Ssk9-RXb07h1+nPqEg@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
	<1361899842-30303-12-git-send-email-jon-hunter@ti.com>
	<51360271.1030302@mimc.co.uk>
	<51360562.20309@ti.com>
	<51361B46.507@mimc.co.uk>
	<51362BAB.10403@ti.com>
	<513664EC.2050508@ti.com>
	<CALF0-+VeU9tGy-dKgmVg1pT0z0ghJBSsughV7kzT5nX7u=9BhA@mail.gmail.com>
	<51377300.3040809@ti.com>
	<CALF0-+W_soY9-ZLO3eS7pTXUTKtcuygJeXkJ3As9U-gkdzabCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:63804 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab3CGNC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 08:02:27 -0500
Received: by mail-ia0-f178.google.com with SMTP id o25so381208iad.9
        for <linux-omap@vger.kernel.org>; Thu, 07 Mar 2013 05:02:27 -0800 (PST)
In-Reply-To: <CALF0-+W_soY9-ZLO3eS7pTXUTKtcuygJeXkJ3As9U-gkdzabCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

On Wed, Mar 6, 2013 at 1:54 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> On Wed, Mar 6, 2013 at 1:46 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>
>> On 03/06/2013 05:58 AM, Ezequiel Garcia wrote:
>>> I'll submit this driver by the end of this week, in case you want
>>> to take a look at it.
>>
>> Ok, but this is not for omap right?
>>
>
> No, this is a new driver for a memory controller that's available on
> some Marvell SoC. It will be located in drivers/memory/.
>

Slightly OT: if anyone wants to see the memory-controller driver
for mvebu platforms, I just posted in lakml.

It's this patchset:

"[PATCH 0/5] Device Bus support for Marvell EBU SoC"

-- 
    Ezequiel
