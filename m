From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Move pcie RC node to common file
Date: Wed, 11 Oct 2017 08:46:02 -0700
Message-ID: <20171011154601.GZ4394@atomide.com>
References: <20171011080430.13160-1-kishon@ti.com>
 <20171011154447.GY4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011154447.GY4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Ravikumar Kattekola <rk@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [171011 08:44]:
> * Kishon Vijay Abraham I <kishon@ti.com> [171011 01:06]:
> > From: Ravikumar Kattekola <rk@ti.com>
> > 
> > Move the pcie_rc node to common file so that it can be
> > used by dra76-evm as well.
> > 
> > Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Can you please resend this with your Signed-off-by also
> since you're the one sending it out?

Oops, sorry I misread, never mind. Applying into
omap-for-v4.15/dt thanks.

Regards,

Tony
