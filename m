From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Patch v4 00/10] ARM: dts: dra7: add cal nodes
Date: Thu, 23 Jan 2020 09:17:37 -0800
Message-ID: <20200123171737.GB5885@atomide.com>
References: <20191211140558.10407-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191211140558.10407-1-bparrot-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [191211 06:03]:
> This patch series adds the needed clkctrl and ty-sysc nodes for CAL module.
> It also adds support for the module in related dtsi and dts for DRA72,
> DRA76 and AM654 SoC.

Applying these into omap-for-v5.6/ti-sysc-dt-cam on top of Tero's
for-5.6-ti-clk branch. It might be too later for v5.6, but we'll
see.

Regards,

Tony
