From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 1/9] ARM: dts: dra7: add cam clkctrl node
Date: Tue, 22 Oct 2019 08:40:12 -0700
Message-ID: <20191022154012.GM5610@atomide.com>
References: <20191018154849.3127-1-bparrot@ti.com>
 <20191018154849.3127-2-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191018154849.3127-2-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191018 15:46]:
> Add clkctrl nodes for CAM domain.

You're missing the Linux clk folks and list from Cc, can
you please resend?

I need an ack for the clk-7xx.c changes if I'm to apply
this patch.

Probably the best way would be for tero to collect
all the drivers/clk/ti clock data changes and provide
an immutable branch with those that I can merge too.

That way the related dts changes can be applied on
top of it with things working.

Regards,

Tony
