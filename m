From: Brian Swetland <swetland@google.com>
Subject: perseus2 build broken (tip of tree)
Date: Wed, 1 Mar 2006 14:58:54 -0800
Message-ID: <20060301225854.GA6223@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Does anyone know if there's a simple fix for this...  
I can comment out mcbsp.o in the makefile and everything builds happily:

arch/arm/plat-omap/mcbsp.c:67: error: `OMAP_MAX_MCBSP_COUNT' undeclared
here (not in a function)
arch/arm/plat-omap/mcbsp.c: In function `omap_mcbsp_config':
arch/arm/plat-omap/mcbsp.c:162: error: `OMAP_MCBSP_REG_SPCR2' undeclared
(first use in this function)
arch/arm/plat-omap/mcbsp.c:162: error: (Each undeclared identifier is
reported only once
arch/arm/plat-omap/mcbsp.c:162: error: for each function it appears in.)
arch/arm/plat-omap/mcbsp.c:163: error: `OMAP_MCBSP_REG_SPCR1' undeclared
(first use in this function)
...

It looks like at some point either mcbsp stopped being optional
or it was changed so it doesn't build on ARCH_OMAP730.

Brian
