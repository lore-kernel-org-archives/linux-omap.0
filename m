From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 3/7] HACK: omap: convert 44xx data to common struct clk
Date: Tue, 13 Dec 2011 20:44:53 -0800
Message-ID: <CAJOA=zM8hP=1BxcpDu-XMvt0KefRPwhP3m-+yC7Uta+Aozz8Xw@mail.gmail.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
 <1323835918-2371-4-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45508 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754134Ab1LNEpO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:45:14 -0500
Received: by mail-iy0-f173.google.com with SMTP id j37so732981iag.18
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:45:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, andrew@lunn.ch

On Tue, Dec 13, 2011 at 8:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 13 Dec 2011, Mike Turquette wrote:
>
>> omap_clk_get_by_name must die.
>
> You do realize that it exists for a reason? =A0That hardware clock na=
mes
> don't have anything to do with the Linux device model?

We have a tree structure of clks in the new common clk code, and a
list of clks in clkdev (which admittedly is meant to be a subset, but
in reality we register every OMAP clk with it), and then the omap clk
list which is only really used by omap_get_clk_by_name for hwmod and
some initialization stuff.  What I'd really like to do is get rid of
the OMAP clk code keeping track of it's clks in a separate list, which
seems quite wasteful.

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
