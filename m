From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v4 0/6] common clk framework
Date: Tue, 13 Dec 2011 20:02:42 -0800
Message-ID: <CAJOA=zOnbUZAyNab5z-upeOHJPiLBYwTpiHogY+teSLcKMoKxw@mail.gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:53485 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753515Ab1LNEDE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:03:04 -0500
In-Reply-To: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

On Tue, Dec 13, 2011 at 7:53 PM, Mike Turquette <mturquette@linaro.org>=
 wrote:
> From: Mike Turquette <mturquette@ti.com>
>
> The common clk framework is an attempt to define a generic struct clk
> which most platforms can use to build a clk tree and perform a set of
> well-defined operations.

=46orgot to mention: these patches are based on v3.2-rc5 and can be pul=
led from:
http://git.linaro.org/gitweb?p=3Dpeople/mturquette/linux.git;a=3Dshortl=
og;h=3Drefs/heads/v3.2-rc5-clkv4
git://git.linaro.org/people/mturquette/linux.git v3.2-rc5-clk-v4

Regards,
Mike

> The previous patchset, v3, can be found at,
> http://article.gmane.org/gmane.linux.kernel/1218622
>
> New stuff in v4:
> =A0* clk rate change notifiers
> =A0* clk debug info via debugfs (instead of sysfs)
> =A0* lots of bug fixes
>
> Stuff that is known to be missing in v4:
> =A0* basic mux and divider clk types
> =A0* fix for migrating clk_prepare_count/clk_enable_count in
> =A0 clk_set_parent
> =A0* minor rework comments from v3
> =A0* Documentation/clk.txt needs love
>
> All of the mising items above will be rolled into v5 ASAP. =A0I wante=
d to
> go ahead and push out the new notifier changes for review and gather
> comments on those since those were a big gap in the v3 patchset.
>
> Paul W. also had some good comments about the greater clk API, and th=
e
> opportunity to fix some of that stuff while this patchset is still un=
der
> discussion. =A0I didn't address those here because they require more
> thought, and more comments from reviewers.
>
> Finally, OMAP4 support for the common struct clk will be posted
> immediately after this patch series to LAKML and LOML, along with som=
e
> hack patches that show how to use the recursive clk_set_rate for
> propagating rate changes up the tree for CPUfreq and how to use the n=
ew
> clk rate change notifiers in a driver.
>
> Mike Turquette (6):
> =A0clk: Kconfig: add entry for HAVE_CLK_PREPARE
> =A0Documentation: common clk API
> =A0clk: introduce the common clock framework
> =A0clk: introduce rate change notifiers
> =A0clk: basic gateable and fixed-rate clks
> =A0clk: export the clk tree topology to debugfs
>
> =A0Documentation/clk.txt =A0 | =A0312 +++++++++++++++
> =A0drivers/clk/Kconfig =A0 =A0 | =A0 23 ++
> =A0drivers/clk/Makefile =A0 =A0| =A0 =A04 +-
> =A0drivers/clk/clk-basic.c | =A0208 ++++++++++
> =A0drivers/clk/clk.c =A0 =A0 =A0 | =A0992 +++++++++++++++++++++++++++=
++++++++++++++++++++
> =A0include/linux/clk.h =A0 =A0 | =A0230 +++++++++++-
> =A06 files changed, 1765 insertions(+), 4 deletions(-)
> =A0create mode 100644 Documentation/clk.txt
> =A0create mode 100644 drivers/clk/clk-basic.c
> =A0create mode 100644 drivers/clk/clk.c
>
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
