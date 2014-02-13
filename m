From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove MACH_NOKIA_N800
Date: Thu, 13 Feb 2014 15:28:43 -0800
Message-ID: <20140213232842.GS28216@atomide.com>
References: <1391958088.25424.17.camel@x220>
 <20140209195021.GE573@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140209195021.GE573@drone.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Paul Bolle <pebolle@tiscali.nl>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [140209 11:53]:
> Hi,
> 
> On Sun, Feb 09, 2014 at 04:01:28PM +0100, Paul Bolle wrote:
> > The last caller of machine_is_nokia_n800() was removed in commit
> > 5a87cde490e1 ("ARM: OMAP2+: Remove legacy booting support for n8x0").
> > That means that the Kconfig symbol MACH_NOKIA_N800 is now unused. It can
> > safely be removed.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks applying into omap-for-v3.14/fixes.

Tony
