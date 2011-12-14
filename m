From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/7] HACK: omap: convert 44xx data to common struct clk
Date: Tue, 13 Dec 2011 22:29:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112132209590.12046@utopia.booyaka.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com> <1323835918-2371-4-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com> <CAJOA=zM8hP=1BxcpDu-XMvt0KefRPwhP3m-+yC7Uta+Aozz8Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1273592925-1323840236=:12046"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50530 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab1LNF3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 00:29:45 -0500
In-Reply-To: <CAJOA=zM8hP=1BxcpDu-XMvt0KefRPwhP3m-+yC7Uta+Aozz8Xw@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1112132224230.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, andrew@lunn.ch

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1273592925-1323840236=:12046
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1112132224231.12046@utopia.booyaka.com>

On Tue, 13 Dec 2011, Turquette, Mike wrote:

> On Tue, Dec 13, 2011 at 8:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 13 Dec 2011, Mike Turquette wrote:
> >
> >> omap_clk_get_by_name must die.
> >
> > You do realize that it exists for a reason? =A0That hardware clock name=
s
> > don't have anything to do with the Linux device model?
>=20
> We have a tree structure of clks in the new common clk code, and a
> list of clks in clkdev (which admittedly is meant to be a subset, but
> in reality we register every OMAP clk with it), and then the omap clk
> list which is only really used by omap_get_clk_by_name for hwmod and
> some initialization stuff.  What I'd really like to do is get rid of
> the OMAP clk code keeping track of it's clks in a separate list, which
> seems quite wasteful.

Clock lookups that only involve a hardware clock name, with no device,=20
should be the province of the clock code itself, not clkdev.  The clkdev=20
code may handle this today in the OMAP code, but this is simply due to=20
legacy reasons.

In general, on OMAP, we've got much faster ways now to implement=20
clk_get().


- Paul
--155748971-1273592925-1323840236=:12046--
