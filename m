From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Date: Thu, 30 Jan 2020 17:34:15 +0200
Message-ID: <CAHp75VfaOfBZYjQa960keORW=VjOn2PdwoYpJMG7SsN83daSJg@mail.gmail.com>
References: <20200127231208.1443-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40343 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3PeY (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jan 2020 10:34:24 -0500
In-Reply-To: <20200127231208.1443-1-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Jan 28, 2020 at 1:14 AM Suman Anna <s-anna@ti.com> wrote:
>
> The DT node full name is currently being used in regmap_config
> which in turn is used to create the regmap debugfs directories.
> This name however is not guaranteed to be unique and the regmap
> debugfs registration can fail in the cases where the syscon nodes
> have the same unit-address but are present in different DT node
> hierarchies. Replace this logic using the syscon reg resource
> address instead (inspired from logic used while creating platform
> devices) to ensure a unique name is given for each syscon.

> -       syscon_config.name = of_node_full_name(np);
> +       syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
> +                                      (u64)res.start);

Explicit castings in printf() usually tell us that something is not okay.
Yes, for resource_size_t we have %pa.

On top of that, I would rather see %pfwn to avoid modification for
other fwnode types.

-- 
With Best Regards,
Andy Shevchenko
