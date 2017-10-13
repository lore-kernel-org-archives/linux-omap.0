From: Benoit Parrot <bparrot@ti.com>
Subject: Re: [Patch 2/6] ARM: DRA7: hwmod: Add CAL nodes
Date: Fri, 13 Oct 2017 12:58:17 -0500
Message-ID: <20171013175817.GG25400@ti.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-3-bparrot@ti.com>
 <20171013165654.GK4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171013165654.GK4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote on Fri [2017-Oct-13 09:56:54 -0700]:
> * Benoit Parrot <bparrot@ti.com> [171012 12:28]:
> > This patch adds the required hwmod nodes to support the Camera
> > Adaptation Layer (CAL) for the DRA72 family of devices.
> ...
> 
> > +static struct omap_hwmod_class_sysconfig dra7xx_cal_sysc = {
> > +	.sysc_offs	= 0x0010,
> 
> Also has .rev_offs at 0 so please add that too.

Ok, I'll add that.

Benoit

> 
> Regards,
> 
> Tony
