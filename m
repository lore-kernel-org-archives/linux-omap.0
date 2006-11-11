From: David Weinehall <tao@acc.umu.se>
Subject: Re: [PATCH] ARM: OMAP: Fix broken N770 build
Date: Sat, 11 Nov 2006 13:19:43 +0100
Message-ID: <20061111121943.GB37490@vasa.acc.umu.se>
References: <454F7F77.8000302@gmail.com> <20061111000316.GN26185@atomide.com>
	<45556895.8080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45556895.8080008@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 11, 2006 at 07:07:17AM +0100, Dirk Behme wrote:
> Tony Lindgren wrote:
> >Also left out the defconfig changes as they
> >don't seem to do anything. Let me know if something is needed
> >on the defconfig.
> 
> In -rc4 CONFIG_HWMON wasn't evaluated to y necessary to 
> build stuff cleanly. Seems that in -rc5 this is fixed. Now, 
> CONFIG_HWMON is default y and n770_defconfig builds fine 
> without the defconfig patch.
> 
> Thanks for updates,
> 
> Dirk
> 
> Btw: Last warning I see with n770_defconfig in our code is
> 
> arch/arm/plat-omap/sti/sti-console.c: In function 
> 'sti_channel_puts':
> arch/arm/plat-omap/sti/sti-console.c:48: warning: value 
> computed is not used
> arch/arm/plat-omap/sti/sti-console.c:57: warning: value 
> computed is not used
> 
> Anybody with an idea here?

Well, at least you don't need to worry about that warning...
I'm pretty certain you don't have an sti-console anyway.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
