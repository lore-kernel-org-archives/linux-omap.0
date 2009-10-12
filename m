From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
Date: Sun, 11 Oct 2009 21:53:45 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B1C0F5F@dlee02.ent.ti.com>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
	<63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
	<20091011222938.GA13244@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091011222938.GA13244@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Alexander Shishkin <virtuoso@slind.org>, Juha Leppanen <juha_motorsportcom@luukku.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Sunday, October 11, 2009 5:30 PM

> > > +       clk = clk_get(&pdev->dev, "emu_core_alwon_ck");
> > > +       clk_enable(clk);
> > > +
> > > +       clk = clk_get(&pdev->dev, "emu_per_alwon_ck");
> > > +       clk_enable(clk);
> > > +
> > > +       clk = clk_get(&pdev->dev, "emu_mpu_alwon_ck");
> > > +       clk_enable(clk);
> > > +
> > > +       clk = clk_get(&pdev->dev, "emu_src_ck");
> > > +       clk_enable(clk);
> >
> > Are these clocks really generic? It looks a lot like OMAP-specific
> > stuff. Is it possible to hide these behind a single clock inside the
> > platform? like "etbclock" or so that increase refcount of the others
> > by 1?

More than ETM/ETB could be using those omap generated clocks.  Any one of the above can also source the trace clocks.

>From the above clocks, 3 are real clock sources (core, per, mpu) and 'emu_src' is a virtual clock which can be set to be feed from the above (or an always on sys_clk not listed). The emu_src_clk is close to what you were commenting on for etbclock.

> ATCLK - ATB interface clock
> CLK - main clock
> PCLKDBG - Debug APB clock or PCLK - APB clock
>
> I'm not sure why OMAP seems to have four clocks when the ETM has only
> three clocks itself.

The ALTCLK & PCLKDBG will be derived from one of the above clocks (emu_per, emu_mpu, emu_core, emu_sys) based on routing.  Which one is used is selected by CM_CLKSEL1_EMU.CLKSEL_ATCLK.  The main CLK comes from MPU DPLL tree.

A big chuck of ETM/ETB is generic coresight.  There is SOC specific emulation logic which surrounds it.

Regards,
Richard W.
