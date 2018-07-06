From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
Date: Fri, 6 Jul 2018 03:35:41 -0700
Message-ID: <20180706103541.GC112168@atomide.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
 <20180705154758.GA112168@atomide.com>
 <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180706 10:05]:
> Hi,
> 
> On Thursday 05 July 2018 09:17 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
> >> +static int sysc_reset(struct sysc *ddata)
> >> +{
> >> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> >> +	int val = sysc_read(ddata, offset);
> > 
> > Can you please just warn and return early for now if no
> > syss_mask is specified? Otherwise we'll have mysterious
> > errors if somebody leaves out "ti,hwmods" for module types
> > we do not yet support reset for.
> 
> RESET write to sysconfig can still happen even if there's no syss_mask
> right? Not all modules need to poll on reset status.

It can but we currently don't have anything similar to
srst_udelay like we have in _ocp_softreset(). And we don't
currently have suport for sysc reset done bit.

So we want to warn and return error except in the known
working case for now.

Regards,

Tony
