From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: RE: [PATCH 3/11] Add OMAP3 support
Date: Wed, 30 May 2007 11:24:51 +0300
Message-ID: <1180513491.19479.24.camel@amit-laptop>
References: <9C23CDD79DA20A479D4615857B2E2C47FF102B@dlee13.ent.ti.com>
Reply-To: amit.kucheria@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF102B@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2007-05-29 at 10:30 -0500, ext Syed Mohammed, Khasim wrote:
> Hi Amit,
> 
> >> + machine-$(CONFIG_ARCH_OMAP3)		:= omap2
> >                                             ^^^^^
> >Surely you mean omap3 here?
> >
> 
> We are using mach-omap2 directory for omap3, so omap2 is correct.

Right.

I got clarification about the intention to use mach-omap2 directory
since a lot of the code is shared.

/Amit

> If we give omap3, then we need to create or have a mach-omap3 directory.
> 
> Here is what happens when I change this to omap3.
