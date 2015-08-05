From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Wed, 5 Aug 2015 02:47:18 -0700
Message-ID: <20150805094717.GX16878@atomide.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437996250-2913-2-git-send-email-kishon@ti.com>
Sender: stable-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150727 04:27]:
> vsel_reg and enable_reg of the pbias regulator descriptor should actually
> have the offset from syscon. However after the pbias device tree node
> is moved as a child node of syscon, vsel_reg and enable_reg has the
> absolute address because of the address translation that happens while
> creating device from device tree node.
> So avoid using platform_get_resource and use of_get_address in order to
> get only the offset (untranslated address) and populate these in
> vsel_reg and enable_reg.

I think this gets fixed automatically with your other series
adding the "simple-bus" to the nodes. For the children of_ioremap
and friends should do the right thing, but without help from the bus
things won't work right without "simple-bus".

Regards,

Tony
