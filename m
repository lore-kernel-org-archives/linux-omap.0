From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Tue, 10 Sep 2019 16:44:52 +0200
Message-ID: <20190910144452.vmhmls3xhh6hd5xw@pali>
References: <20190828150037.2640-1-aford173@gmail.com>
 <20190905230443.GA52127@atomide.com>
 <CAHCN7xKxffJUV2V2CCuw0iPqUm4LJT28GMrcF2=8rDJQM2dOOw@mail.gmail.com>
 <20190910143732.3g3q4acvnx2pqvjx@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190910143732.3g3q4acvnx2pqvjx@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 September 2019 15:37:32 Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 10, 2019 at 08:56:49AM -0500, Adam Ford wrote:
> > On Thu, Sep 5, 2019 at 6:04 PM Tony Lindgren <tony@atomide.com> wrote:
> > > Oh and this needs to default to status = "disabled" for
> > > HS devices like n900 as it needs to use the omap3-rom-rng.
> > 
> > I don't know enough about the HS version of the OMAP3, but what's the
> > main difference between omap3-rom-rng and this one?
> 
> The OMAP HS chips have the bus firewall configured to block direct
> access to some cryptography related devices. The kernel will crash
> with a bus error, if you try to read/write the registers for
> protected devices.

And if you try to read it more times, SOC would be rebooted for security
reasons.

> The omap3-rom-rng avoids this by communicating
> with the security middleware component instead of directly accessing
> the RNG hardware.

And that component is loaded by signed bootloader into "secure" area not
accessible by "non-secure" work (like kernel) and communication is done
via arm smc instruction.

-- 
Pali Rohár
pali.rohar@gmail.com
