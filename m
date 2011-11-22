From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 21:02:08 +0100
Message-ID: <9315670.oOZAWsuHPb@wuerfel>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org> <CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg@mail.gmail.com> <CACxGe6vK-vHvSbd9N2k3FZY4gGVS_DETx0BbfPgNghTkOncjpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6vK-vHvSbd9N2k3FZY4gGVS_DETx0BbfPgNghTkOncjpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linaro-dev@lists.linaro.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Mike Turquette <mturquette@linaro.org>, linus.walleij@stericsson.com, sboyd@quicinc.com, broonie@opensource.wolfsonmicro.com, magnus.damm@gmail.com, linux-kernel@vger.kernel.org, eric.miao@linaro.org, aul@pwsan.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org, skannan@quicinc.com, linux@arm.linux.org.uk, arnd.bergmann@linaro.org, linux-omap@vger.kernel.org, jeremy.kerr@canonical.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 November 2011 12:19:51 Grant Likely wrote:
> On Tue, Nov 22, 2011 at 11:01 AM, Mike Turquette <mturquette@linaro.org> wrote:
>
> > Others have requested to have knobs made available for actually
> > performing clk_enable/clk_disable and even clk_set_rate from
> > userspace.  I hate this idea and won't implement it.  I encourage
> > anyone that needs this to do it in debugfs.
> >
> > Does that work-split make sense to you, or do you still not like the
> > idea of having topology and read-only info in sysfs?
> 
> Unless there is a solid real-world use case for exporting this data to
> userspace, I do not think sysfs is a good idea.  As long as the usage
> (beyond debug) is theoretical I think the whole thing should be in
> debugfs.  It can always be moved at a later date If a real use case
> does become important.

I would recomment not to spend any time on implementing a debugfs interface
for this right now. As far as I can tell, nothing relies on exporting
the structure to user space, so Mike's time is better spent on getting the
other four patches merged.

Note that the static topology information about clocks will already be
visible in /proc/devicetree when that is enabled and the clocks are
described in the .dts file.

	Arnd
