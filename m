From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Clean up cpu.h for 24xx, 34xx
Date: Mon, 3 Dec 2007 10:25:11 -0800
Message-ID: <20071203182511.GC4105@atomide.com>
References: <Pine.LNX.4.64.0711301945080.18772@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711301945080.18772@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [071130 18:47]:
> 
> [ This patch replaces the previous patch from me on this topic, 
>   "Fix cpu_is_omap343x()" ]
> 
> include/asm-arm/arch-omap/cpu.h was always returning 0 for
> cpu_is_omap343x().  This caused 3430SDP to fail to boot after the
> recent system control module patch.
> 
> Also, clean up the existing OMAP2/3 CPU type reporting macros to
> evaluate to constants on non-multiboot kernels, and fix some
> whitespace and numeric format problems with the recent DEVICE_TYPE
> macro changes.
> 
> Boot-tested on N800, 2430SDP, and 3430SDP-ES1.
> 
> size:
> 
> 2885444  147008   96280 3128732  2fbd9c vmlinux.3430sdp
> 2885416  147008   96280 3128704  2fbd80 vmlinux.3430sdp.patched

Pushing today.

Tony
