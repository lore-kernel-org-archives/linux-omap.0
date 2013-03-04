From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Mon, 4 Mar 2013 08:57:51 -0300
Message-ID: <CALF0-+V3A-fL7q2nPRmcgnFKmzRt8KwSLuzrwzyyce6MqHjVpw@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
	<1361899842-30303-12-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55792 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3CDL5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 06:57:52 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so6034841ieb.3
        for <linux-omap@vger.kernel.org>; Mon, 04 Mar 2013 03:57:51 -0800 (PST)
In-Reply-To: <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

Hi Jon,

On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> +
> +Example:
> +
> +gpmc: gpmc@6e000000 {
> +       compatible = "ti,omap3430-gpmc", "simple-bus";

I'm concern about using simple-bus, and I'm not entirely sure this will work.

AFAIK, you can't correlate a parent-child relationship in the device tree
to the order in which drivers will be probed,
so it's only a matter of coincidence if this is working for you right now.
The GPMC code is in "arch/arm/mach-omap2", is located *before* the mtd code
in the Makefile, and thus the GPMC driver loads *before* the MTD code.

Morevore, I believe that when we move GPMC from arch/arm/mach-omap2
to drivers/memory where it should be, this 'simple-bus' will stop
working properly.

Of course, I can be wrong, but I think you will have to find some other way
to initialize the GPMC's childs.

-- 
    Ezequiel
