From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/8] ARM: dra7: Add support for dra76-evm
Date: Mon, 14 Aug 2017 10:41:01 -0700
Message-ID: <20170814174101.GZ8569@atomide.com>
References: <20170812040605.21259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170812040605.21259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170811 21:10]:
> dra76 family is a high-performance, infotainment application
> device, based on OMAP architecture on a 28-nm technology.
> This contains most of the subsystems, peripherals that are
> available on dra74, dra72 family. This SoC mainly features
> Subsystems:
> - 2 x Cortex-A15 with max speed of 1.8GHz
> - 2 X DSP
> - 2 X Cortex-M4 IPU
> - ISS
> - CAL
> - DSS
> - VPE
> - VIP
> Connectivity peripherals:
> - 1 USB3.0 and 3 USB2.0 subsystems
> - 2 x SATA
> - 2 x PCI Express Gen2
> - 3-port Gigabit ethernet switch
> - 2 x CAN
> - MCAN
> 
> This series adds support for dra76-evm.
> 
> Tested on dra76-evm: http://pastebin.ubuntu.com/25294546/
> 
> Changes since v1:
> - Changed the compatible to ti,dra762 instead of ti,dra76 as suggested by Rob
> - Updated crossbar skip irqs
> 
> NOTE: As said earlier, this is a version based on dra76-evm pre production
> boards. There might be minimal changes once production boards comes out.

That's fine. Applying all for v4.14 split into soc, dt-v2 and
defconfig branches.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
