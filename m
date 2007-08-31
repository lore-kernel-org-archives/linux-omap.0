From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Updated ARM mach-types.
Date: Fri, 31 Aug 2007 10:19:30 -0700
Message-ID: <20070831171930.GH12350@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701A9127B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701A9127B@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070830 17:03]:
> This patch is to fix OMAP 3430SDP machine ID by upgrading to latest 
> mach-types from:
> 
> http://www.arm.linux.org.uk/developer/machines/download.php.
> 
> Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
> 
> File:
>  arch/arm/tools/mach-types
> 
> =======================================================================
> 
> --- linux-omap/arch/arm/tools/mach-types	2007-05-16 14:32:40.000000000 -0500
> +++ my_linux-omap/arch/arm/tools/mach-types	2007-08-30 18:42:48.000000000 -0500
> @@ -1148,7 +1148,7 @@ aidx270			MACH_AIDX270		AIDX270			1134
>  rema			MACH_REMA		REMA			1135
>  bps1000			MACH_BPS1000		BPS1000			1136
>  hw90350			MACH_HW90350		HW90350			1137
> -omap_sdp3430		MACH_OMAP_SDP3430	OMAP_SDP3430		1138
> +omap_3430sdp		MACH_OMAP_3430SDP	OMAP_3430SDP		1138
>  bluetouch		MACH_BLUETOUCH		BLUETOUCH		1139
>  vstms			MACH_VSTMS		VSTMS			1140
>  xsbase270		MACH_XSBASE270		XSBASE270		1141

I've only pushed the chunk above to try to stay in sync with mainline.
Let's add the 24xx boards once we have the board-*.c files for them.

Regards,

Tony
