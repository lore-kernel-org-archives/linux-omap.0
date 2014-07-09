From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/7] ARM: dts: AM43x: Add devcice tree nodes
Date: Wed, 9 Jul 2014 04:51:07 -0700
Message-ID: <20140709115106.GV28884@atomide.com>
References: <1404884193-20580-1-git-send-email-j-keerthy@ti.com>
 <20140709083114.GH28884@atomide.com>
 <53BD208E.6000507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53BD208E.6000507-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <a0393675-l0cyMroinI0@public.gmane.org> [140709 04:03]:
> On Wednesday 09 July 2014 02:01 PM, Tony Lindgren wrote:
> >* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [140708 22:40]:
> >>The patch series adds the device tree nodes and the corresponding
> >>documentation. The series also enabled tps65218 config options
> >>in the omap2plus_defconfig.
> >>
> >>The series is boot tested on both AM43x-epos-evm and AM437x-gp-evm.
> >Are the .dts changes safe to apply separately without breaking
> >anything?
> Tony,
> 
> Patch 1/7 had to be re-based on Mark's latest branch for tps65218.
> Other patches can be taken as is. These patches are boot tested on
> both am437x-gp-evm and am43x-epos-evm.

OK thanks applying patches 4 - 7 into omap-for-v3.17/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
