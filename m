From: Michael Turquette <mturquette@linaro.org>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Fri, 17 Apr 2015 12:56:37 -0700
Message-ID: <20150417195637.19585.24668@quantum>
References: <20150415194707.GA11007@deathray> <20150415205136.GA3399@deathray>
 <552F3B60.8050703@ti.com> <20150416161756.GA27590@deathray>
 <55301D7F.30708@gmail.com> <20150416220918.GA6057@deathray>
 <55304486.5020404@gmail.com> <20150417020048.GA27174@deathray>
 <5530CE63.9070508@gmail.com> <20150417101833.GU4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33528 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbDQT4r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2015 15:56:47 -0400
Received: by igbpi8 with SMTP id pi8so31830247igb.0
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2015 12:56:47 -0700 (PDT)
In-Reply-To: <20150417101833.GU4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Mack <daniel@zonque.org>

Quoting Russell King - ARM Linux (2015-04-17 03:18:33)
> On Fri, Apr 17, 2015 at 11:12:03AM +0200, Sebastian Hesselbarth wrote:
> > On 17.04.2015 04:00, Michael Welling wrote:
> > >On Fri, Apr 17, 2015 at 01:23:50AM +0200, Sebastian Hesselbarth wrote:
> > >>On 17.04.2015 00:09, Michael Welling wrote:
> > >>>On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
> > >>>>On 16.04.2015 18:17, Michael Welling wrote:
> > [...]
> > >>>What would be the proper error path?
> > >>>What cleanup is required?
> > >>
> > >>A proper error path would be to release any claimed resource
> > >>on any error. If you look at the code, the only resources that
> > >>need to be released are the two clocks in question.
> > >
> > >So for every error return in the probe function and in the of si5351_dt_parse
> > >it needs to clk_put first right?
> > 
> > Not quite. The driver should clk_put() every clock that it called a
> > [of_]clk_get() for. The thing is that clocks can be passed by
> > platform_data and we never claim them.
> 
> I've always said clocks (as in struct clk) should never be passed through
> platform data.

+1

And for ccf clock drivers Stephen and I plan to change the behavior of
clk_register() at some point so that it returns an error code and not a
struct clk. This will make clk_dev the only way to get at a struct clk
for users of the ccf implementation.

Of course it is still possible to clk_get from some place and pass as
platform_data, but every little bit helps.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
