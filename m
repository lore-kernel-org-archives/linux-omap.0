From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Date: Thu, 30 Jan 2020 22:43:25 +0200
Message-ID: <CAHp75VfhLDpuJD+ftdEWt3bwooRD5U=KfOnKZeKm9d4N21HOtw@mail.gmail.com>
References: <20200127231208.1443-1-s-anna@ti.com> <CAHp75VfaOfBZYjQa960keORW=VjOn2PdwoYpJMG7SsN83daSJg@mail.gmail.com>
 <99a04c52-1ff6-1611-5cf6-2c71b810ba43@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3Ung (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jan 2020 15:43:36 -0500
In-Reply-To: <99a04c52-1ff6-1611-5cf6-2c71b810ba43@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Jan 30, 2020 at 7:09 PM Suman Anna <s-anna@ti.com> wrote:
> On 1/30/20 9:34 AM, Andy Shevchenko wrote:
> > On Tue, Jan 28, 2020 at 1:14 AM Suman Anna <s-anna@ti.com> wrote:

...

> >> -       syscon_config.name = of_node_full_name(np);
> >> +       syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
> >> +                                      (u64)res.start);
> >
> > Explicit castings in printf() usually tell us that something is not okay.
>
> Yes, I agree in general.
>
> > Yes, for resource_size_t we have %pa.
>
> And that was the first thing I tried when doing v2, before moving away
> from it. This is not for a console printf statement, but is rather for
> the regmap debugfs name. Using a %pa adds the 0x and leading zeros in
> the debugfs name, when compared to the name before this patch. The
> typecast retains the current format, and replaces the unit-address
> without the leading 0s either. Introducing a local-variable to avoid the
> typecast is overkill.

Thanks for the clarification.

-- 
With Best Regards,
Andy Shevchenko
