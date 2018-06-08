From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Date: Thu, 7 Jun 2018 23:21:58 -0700
Message-ID: <20180608062158.GI5738@atomide.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180607 10:24]:
> Hi,
> 
> On Thursday 07 June 2018 01:05 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180606 06:14]:
> >> +static int sysc_reset(struct sysc *ddata)
> >> +{
> >> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> >> +	int val = sysc_read(ddata, offset);
> >> +
> >> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
> >> +	sysc_write(ddata, offset, val);
> >> +
> >> +	/* Poll on reset status */
> >> +	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
> >> +		offset = ddata->offsets[SYSC_SYSSTATUS];
> >> +
> >> +		return readl_poll_timeout(ddata->module_va + offset, val,
> >> +				(val & ddata->cfg.syss_mask) == 0x0,
> >> +				100, MAX_MODULE_SOFTRESET_WAIT);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> > 
> > I wonder if we should also add SYSS_QUIRK_RESET_STATUS in
> > addition to SYSC_QUIRK_RESET status to make it easy to
> > read the right register?
> 
> I assumed SYSC_QUIRK is the prefix to indicate the ti-sysc driver not
> the register. Are there layouts in which the reset status bit is in the
> sysconfig register rather than the sysstatus register?

Yes we can have reset status bit in either syss or syssconfig register.
We detect that in sysc_init_syss_mask() but we should also set something
at that point to make it clear which reset to use. But as we don't need
the quirk flag, it's probably set a function pointer after the detection.
So how about let's have two functions sysc_reset() and sysc_syss_reset()
and then we can implement sysc_syss_reset() in a separate patch after
testing it when we have a non-platform data using example for
sysc_syss_reset().

Regards,

Tony
