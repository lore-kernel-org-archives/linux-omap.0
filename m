From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Thu, 1 Mar 2018 10:14:47 -0800
Message-ID: <20180301181447.GG62820@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de>
 <20180116150314.GC4042@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180116150314.GC4042@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180116 07:03]:
> * Philipp Zabel <p.zabel@pengutronix.de> [180116 09:52]:
> > Looks good to me. Can I move the compatible property when applying?
> 
> Oops, here's a better version. I also left out the "prcm" part as
> at some point that should have just ranges instead of both reg and
> ranges that it currently has.

Philipp, do you need me to resend v2 of this patch against v4.16-rc?

The changes we discussed with Suman can then be done as
separate patches as needed :)

Regards,

Tony
