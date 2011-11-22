From: Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
Date: Tue, 22 Nov 2011 15:49:08 +0000
Message-ID: <201111221549.08451.arnd.bergmann@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<201111221311.00117.arnd.bergmann@linaro.org>
	<1321974200.2412.25.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321974200.2412.25.camel-PDpCo7skNiwAicBL8TP8PQ@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 November 2011, Mark Salter wrote:
> 
> On Tue, 2011-11-22 at 13:11 +0000, Arnd Bergmann wrote:
> > On Tuesday 22 November 2011, Mike Turquette wrote:
> > > +static void clk_hw_gate_set_bit(struct clk *clk)
> > > +{
> > > +       struct clk_hw_gate *gate = to_clk_hw_gate(clk);
> > > +       u32 reg;
> > > +
> > > +       reg = __raw_readl(gate->reg);
> > > +       reg |= BIT(gate->bit_idx);
> > > +       __raw_writel(reg, gate->reg);
> > > +}
> > 
> > You cannot rely on __raw_readl() to do the right thing, especially
> > in architecture independent code. The safe (but slightly inefficient)
> > solution would be readl/writel. For ARM-only code, it would be best
> > to use readl_relaxed()/writel_relaxed(), but most architectures do
> > not implement that. We can probably add a set of helpers in asm-generic/
> > to define them to the default functions, like "#define readl_relaxed(x)
> > readl(x)", which I think is a good idea anyway.
> > 
> 
> readl/writel won't work for big endian CPU when the registers are on a
> bus that does the endian swabbing in hardware.

That statement doesn't make any sense.

You obviously have to specify the bit index in a way that works with the
driver implementation and with the hardware.

__raw_readl has an unspecified endianess, which is normally the same
as the register endianess of the CPU (assuming a memory-mapped bus),
which means you have to do extra work if the register layout is
independent of the CPU endianess, which is about as common as
MMIO registers defined as being the same endianes as the CPU in
bi-endian implementations.

Considering that hardware makers cannot agree on how to count bits
(IBM calls the MSB bit 0 on big-endian systems), there is no way
to please everyone, though you could debate about what the clearest
semantics are that we should define.

IMHO it would be nicer to use a bit-mask in bus-endian notation, e.g.

      reg = readl(gate->reg);
      reg |= le32_to_cpu(gate->bit_mask);
      writel(reg, gate->reg);

but there are other ways to do this. The only thing that I would
definitely ask for is having the interface clearly documented as
being one of cpu-endian, bus-endian, fixed-endian or having the
endianess specified in the device definition (device tree or platform
data).

Note that I don't object to adding a new cpu-endian mmio accessor,
which has been discussed repeatedly in the past. It's just that
this accessor does not exist, and using __raw_readl as a substitute
causes additional problems.

	Arnd
