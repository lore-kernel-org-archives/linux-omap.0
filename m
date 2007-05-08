From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] fix sti-netlink.c compilation failure
Date: Wed, 9 May 2007 08:31:24 +0900
Message-ID: <20070508233124.GA16352@linux-sh.org>
References: <20070508200109.272063491@pwsan.com>
	<20070508200138.420874830@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070508200138.420874830@pwsan.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, May 08, 2007 at 02:01:10PM -0600, Paul Walmsley wrote:
> Fix this compilation error in current linux-omap-2.6 git head:
> 
>   CC      arch/arm/plat-omap/sti/sti-netlink.o
> arch/arm/plat-omap/sti/sti-netlink.c: In function 'sti_netlink_init':
> arch/arm/plat-omap/sti/sti-netlink.c:145: warning: passing argument 4 of 'netlink_kernel_create' from incompatible pointer type
> arch/arm/plat-omap/sti/sti-netlink.c:145: error: too few arguments to function 'netlink_kernel_create'
> make[2]: *** [arch/arm/plat-omap/sti/sti-netlink.o] Error 1
> make[1]: *** [arch/arm/plat-omap/sti] Error 2
> make: *** [arch/arm/plat-omap] Error 2
> 
> Compile-tested only. 
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
Looks reasonable.

Acked-by: Paul Mundt <lethal@linux-sh.org>
