From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Kconfig: replace ARCH_OMAP243X with
	ARCH_OMAP2430
Date: Fri, 30 Mar 2007 14:57:45 -0400
Message-ID: <20070330185743.GD18375@atomide.com>
References: <20070321000748.659921000@mvista.com>
	<20070321000826.983707000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070321000826.983707000@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070320 20:09]:
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> ---
>  arch/arm/configs/omap_2430sdp_defconfig |  322 ++++++++++++++++++++++++++++----
>  arch/arm/mach-omap2/prcm-regs.h         |    4 
>  drivers/usb/musb/musbdefs.h             |    2 
>  drivers/usb/musb/omap2430.h             |    2 
>  drivers/usb/musb/plat_uds.c             |    2 
>  5 files changed, 287 insertions(+), 45 deletions(-)

Pushing today.

Tony
