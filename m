From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH omap-fixes] ARM: OMAP: cleanup: remove OMAP_MCBSP
	Kconfig warnings
Date: Fri, 10 Aug 2007 03:05:52 -0700
Message-ID: <20070810100551.GT8658@atomide.com>
References: <20070806151312.217287034@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070806151312.217287034@mvista.com>
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

* Kevin Hilman <khilman@mvista.com> [070807 01:43]:
> When the OMAP patches are applied and the kernel is built for a
> non-ARM target, there are a handful of Kconfig warnings due to the use
> of OMAP_MCBSP in arch-independent Kconfig files.  
> 
> This patch simply removes the 'select OMAP_MCBSP' in these
> arch-independent files since it is already 'default y' in
> arch/arm/plat-omap/Kconfig

Pushing today.

Tony
