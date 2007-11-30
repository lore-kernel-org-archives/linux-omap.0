From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: MUSB: MUSB fix to work as Module for 24xx/Davinci
Date: Thu, 29 Nov 2007 21:31:21 -0800
Message-ID: <20071130053121.C0FFA10BA22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <5DF83221BE20114E9C331F665ACBC08003E7FAE3@dbde01.ent.ti.com>
	<200711291022.23735.david-b@pacbell.net>
	<5DF83221BE20114E9C331F665ACBC08003F30BB4@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08003F30BB4@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: vikram.pandita@ti.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >I don't understand the point of this patch.  It certainly used to
> >work as a module on DaVinci ... as recently as a few months ago.
>
> For 24xx, MUSB as module was not working since one year I started looking into it.
> Since CONFIGDATA register needs the index register to be zero. This is not
> mentioned in the register description but in the Table in the beginning of
> the Mentor Spec PG.

Then the correct patch would be to set that register to zero,
instead of what your patch does...


> >And this particular register is at a fixed location, not subject
> >to the usual register banking stuff.  Kicking in that banking
> >logic would be incorrect.
>
> "Reference Mentor Spec 2 . 1 . MUSBMHDRC REGISTER MAP
> ConfigData Returns details of core configuration. (Index register set to
> select Endpoint 0.) 2.3.4"

... again arguing that the correct fix would be to set the index
register to zero, even when a non-indexed addressing mode is used.


> >> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >> ---
> >>
> >> Index: linux-omap/drivers/usb/musb/musb_core.c
> >> ===================================================================
> >> --- linux-omap.orig/drivers/usb/musb/musb_core.c	2007-11-20 14:24:03.000000000 +0530
> >> +++ linux-omap/drivers/usb/musb/musb_core.c	2007-11-20 14:26:22.000000000 +0530
> >> @@ -1336,7 +1336,7 @@
> >>
> >>  	/* log core options (read using indexed model) */
> >>  	musb_ep_select(mbase, 0);
> >> -	reg = musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
> >> +	reg = musb_readb(mbase, MUSB_EP_OFFSET(0, MUSB_CONFIGDATA));
> >>
> >>  	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
> >>  	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
>
