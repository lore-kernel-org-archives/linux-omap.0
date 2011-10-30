From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] pending DT patches and cleanup for map_io for v3.2
	merge window
Date: Mon, 31 Oct 2011 01:39:34 +0200
Message-ID: <201110310039.34717.arnd@arndb.de>
References: <20111024091704.GF31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111024091704.GF31337@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Jon Medhurst <tixy@yxit.co.uk>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Monday 24 October 2011, Tony Lindgren wrote:
> As discussed in the ARM kernel meeting yesterday, here's are
> the pending omap things to pull for v3.2 merge window.

Hi Tony,

I finally got to pull these.

> These would be nice to get still in as other people's work
> such as Nico's map_io changes need #2 below.
> 
> 1. Initial DT support posted few weeks ago
> 
>    Please see the earlier pull request at:
> 
>    http://lkml.org/lkml/2011/10/4/441

Looks good. I've missed this initially because I had not yet managed
to go through that mail thread (randconfig patches) again and pick
up the patches that got an Ack. The pull request was right in the
middle of 100 other unread emails...

> 2. Cleanup for map_io posted few weeks ago
> 
>    This depends on the #1 above, and also requires
>    the ioremap_exec patch. Russell said he has applied
>    into devel-stable (But not pushed out yet?).
> 
>    When you have the ioremap_exec patch from Russell,
>    please pull this from:
> 
>    git://github.com/tmlind/linux.git sram-map-io
> 
>    Pull request against #1 attached below.

This had systematic but trivial conflicts against the memory.h
series, which I fixed up. There was also a conflict with 009426a0e
"ARM: omap: Setup consistent dma size at boot time" from Tixy.
That patch added a call to omap_init_consistent_dma_size in a function
that you removed. I have resolved the conflict by adding that call to
omap1_init_early and omap_common_init_early, but I have no idea if that
is a correct resolution. Please check.

	Arnd

	Arnd
