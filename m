From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings
 in OFF mode
Date: Fri, 4 May 2012 12:22:58 -0700
Message-ID: <20120504192258.GP5613@atomide.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com>
 <4F957EB2.9080200@ti.com>
 <1335339230.2149.110.camel@sokoban>
 <4F981478.3040201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36779 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab2EDTXD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:23:03 -0400
Content-Disposition: inline
In-Reply-To: <4F981478.3040201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120425 08:16]:
> Hi Tero,
> 
> On 04/25/2012 02:33 AM, Tero Kristo wrote:
> > On Mon, 2012-04-23 at 11:09 -0500, Jon Hunter wrote:
> >> Hi Tero,
> >>
> >> On 04/20/2012 04:33 AM, Tero Kristo wrote:
> >>
> >> [...]
> >>
> >>> +/**
> >>> + * omap4_dpll_print_reg - dump out a single DPLL register value
> >>> + * @dpll_reg: register to dump
> >>> + * @name: name of the register
> >>> + * @tuple: content of the register
> >>> + *
> >>> + * Helper dump function to print out a DPLL register value in case
> >>> + * of restore failures.
> >>> + */
> >>> +static void omap4_dpll_print_reg(struct omap4_dpll_regs *dpll_reg, char *name,
> >>> +				 struct dpll_reg *tuple)
> >>> +{
> >>> +	if (tuple->offset)
> >>> +		pr_warn("%s - Address offset = 0x%08x, value=0x%08x\n", name,
> >>> +			tuple->offset, tuple->val);
> >>
> >> Minor nit-pick here ...
> >>
> >> 1. Offset is 16-bits and so we can just have "offset = 0x%04x"
> >> 2. Consider dropping "Address" from "Address offset"
> >> 3. Can we be consistent in our spaces for "offset = " and "value="?
> >>
> >>> +}
> >>> +
> >>> +/*
> >>> + * omap4_dpll_dump_regs - dump out DPLL registers
> >>> + * @dpll_reg: DPLL to dump
> >>> + *
> >>> + * Dump out the contents of the registers for a DPLL. Called if a
> >>> + * restore for DPLL fails to lock.
> >>> + */
> >>> +static void omap4_dpll_dump_regs(struct omap4_dpll_regs *dpll_reg)
> >>> +{
> >>> +	pr_warn("%s: Unable to lock dpll %s[part=%x inst=%x]:\n",
> >>> +		__func__, dpll_reg->name, dpll_reg->mod_partition,
> >>> +		dpll_reg->mod_inst);
> >>> +	omap4_dpll_print_reg(dpll_reg, "clksel", &dpll_reg->clksel);
> >>> +	omap4_dpll_print_reg(dpll_reg, "div_m2", &dpll_reg->div_m2);
> >>> +	omap4_dpll_print_reg(dpll_reg, "div_m3", &dpll_reg->div_m3);
> >>> +	omap4_dpll_print_reg(dpll_reg, "div_m4", &dpll_reg->div_m4);
> >>> +	omap4_dpll_print_reg(dpll_reg, "div_m5", &dpll_reg->div_m5);
> >>> +	omap4_dpll_print_reg(dpll_reg, "div_m6", &dpll_reg->div_m6);
> >>> +	omap4_dpll_print_reg(dpll_reg, "div_m7", &dpll_reg->div_m7);
> >>> +	omap4_dpll_print_reg(dpll_reg, "clkdcoldo", &dpll_reg->clkdcoldo);
> >>> +	omap4_dpll_print_reg(dpll_reg, "clkmode", &dpll_reg->clkmode);
> >>> +	omap4_dpll_print_reg(dpll_reg, "autoidle", &dpll_reg->autoidle);
> >>> +	if (dpll_reg->idlest.offset)
> >>> +		pr_warn("idlest - Address offset = 0x%08x, before val=0x%08x"
> >>> +			" after = 0x%08x\n", dpll_reg->idlest.offset,
> >>> +			dpll_reg->idlest.val,
> >>> +			omap4_dpll_read_reg(dpll_reg, &dpll_reg->idlest));
> >>
> >> Nit-pick ...
> >>
> >> 1. Same comments as above
> >> 2. Consider dropping "Address offset" altogether here as we print
> >> "idlest" the offset should be implied.
> >> 3. Also can we be consistent in our naming of "before val and "after"?
> >> For example, "val before =" and "val now = ".
> > 
> > Okay, I'll modify both prints slightly. Question though, do we want
> > these prints in the kernel in the first place? At least Tony has been
> > frowning upon register dumps in the kernel and this falls into that
> > category. What we could do is just to print the warning but drop the
> > register dumps out.
> 
> Thanks. Good question. If we are not seeing failures often, and I would
> hope not, probably ok to remove. However, I will let Tony comment here  ...

Well if the register dumps really help trace the issue and don't happen
continuously I'm fine with them.

Tony
