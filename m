From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] improve System Control Module defines
Date: Wed, 5 Dec 2007 15:11:59 -0800
Message-ID: <20071205231158.GF4105@atomide.com>
References: <Pine.LNX.4.64.0711280258450.6342@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711280258450.6342@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com, jmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [071128 02:01]:
> This patch:
> 
> - prefaces the SCM register offsets with the appropriate platform string
>   (e.g., OMAP2_ for 24xx/34xx-common registers) and updates code that uses
>   these registers to use the correct name;
> 
> - adds some more register bit defines (e.g., OMAP2_DEVICETYPE_MASK) and 
>   cleans up code to use these common macros;
> 
> - fixes the offset of the CONTROL_STATUS register on 24xx that partially
>   caused SRAM patcher problems (with thanks to Kyungmin Park 
>   <kmpark@infradead.org> for finding this problem)
> 
> - adds many more register offset defines for the 'GENERAL' section of the 
>   SCM.
> 
> Boot-tested on N800 and 2430SDP.  3430SDP is down at the moment, so
> can't test there.  Incidentally, on N800, there is no vmlinux size 
> difference between unpatched and patched kernels.  Comments welcome.

Pushing today.

Tony
