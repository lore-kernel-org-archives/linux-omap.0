From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: SPI troubles
Date: Mon, 15 Mar 2010 10:04:45 -0700
Message-ID: <20100315170444.GU2900@atomide.com>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4b9d9f11.9a15f10a.3902.6dc3-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [100314 19:41]:
> 
> P.P.S. Is it just me or does the omap_pinmux interface need some refinement.
> Using it has been an exercise in frustration, between extremely sparse
> documentation, quirky behavior (I still haven't figure out how to get gpio_130
> configured.  omap_mux_init_gpio fails with "multiple paths for gpio130" whereas
> omap_mux_init_signal fails to even recognize the signal name), and general
> complexity. The idea behind the interface seems excellent, but it seems it
> hasn't been used enough not to be a complete pain in the ass to figure out and
> use.

Hopefully incrementally less frustrating now than earlier though :)

So far the new mux code has been tested pretty much only with the
existing mux settings, so I'm sure quite a some quirks still remain.

The problem of omap_mux_init_gpio not recognizing full signal names
is known. At least it correctly gives you warnings and refuses to
do anything. The real fix probably in the long run is to change
everything to use omap_mux_init_signal instead.

But what's the issue of omap_mux_init_signal not recognizing the
signal name? It should be just "mode0_name.desired_mode". Is some
entry maybe missing from mux34xx.c?

Some of the complexity disappears once I get around to converting
the 24xx muxing to the new code so we can get rid of the old code.
Some complexity is caused by the need to support bootloader-only muxing
while still dynamically muxing the GPIO pins for PM idle.

Got some good ideas on how to cut down the complexity further?

Regards,

Tony

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
