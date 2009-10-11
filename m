From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
Date: Sun, 11 Oct 2009 23:29:38 +0100
Message-ID: <20091011222938.GA13244@n2100.arm.linux.org.uk>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
	<63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Alexander Shishkin <virtuoso@slind.org>, Juha Leppanen <juha_motorsportcom@luukku.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 12, 2009 at 12:07:57AM +0200, Linus Walleij wrote:
> First, these are registered as platform devices, should they not be AMBA
> devices (i.e. PrimeCells?) I think that's what they are, and they probably
> have device ID:s to be matched in the last words of their 4K pages
> do they not?

It does look like it's Primecell-like, so it should be using the
primecell support so that others can make use of this.  As such, it
should not be OMAP specific.

> > + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_core_alwon_ck");
> > + =A0 =A0 =A0 clk_enable(clk);
> > +
> > + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_per_alwon_ck");
> > + =A0 =A0 =A0 clk_enable(clk);
> > +
> > + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_mpu_alwon_ck");
> > + =A0 =A0 =A0 clk_enable(clk);
> > +
> > + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "emu_src_ck");
> > + =A0 =A0 =A0 clk_enable(clk);
> =

> Are these clocks really generic? It looks a lot like OMAP-specific
> stuff. Is it possible to hide these behind a single clock inside the
> platform? like "etbclock" or so that increase refcount of the others
> by 1?

First obvious problem is that there's no error checking there.

Second problem is that this could very well be a generic driver, and
OMAP specifics should not be in here.  Looking at the Coresight ETM11
documentation, there's:

ATCLK - ATB interface clock
CLK - main clock
PCLKDBG - Debug APB clock or PCLK - APB clock

I'm not sure why OMAP seems to have four clocks when the ETM has only
three clocks itself.
