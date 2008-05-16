From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] CF: Change omap_cf.c to use  omap_readw/writew
	instead of __REG for multi-omap
Date: Fri, 16 May 2008 14:49:09 -0700
Message-ID: <20080516214909.GC23002@atomide.com>
References: <1210972076-23911-1-git-send-email-tony@atomide.com> <1210972076-23911-2-git-send-email-tony@atomide.com> <200805161426.18409.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50115 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbYEPVtI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 17:49:08 -0400
Content-Disposition: inline
In-Reply-To: <200805161426.18409.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

* David Brownell <david-b@pacbell.net> [080516 14:26]:
> On Friday 16 May 2008, Tony Lindgren wrote:
> > @@ -38,19 +38,19 @@
> > =A0#define=A0=A0=A0=A0=A0=A0=A0=A0CF_BASE=A00xfffe2800
> > =A0
> > =A0/* status; read after IRQ */
> > -#define CF_STATUS_REG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__REG16(CF_BASE=
 + 0x00)
> > +#define CF_STATUS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0(CF_BASE + 0x00)
> > =A0#=A0=A0=A0=A0=A0=A0define=A0=A0CF_STATUS_BAD_READ=A0=A0=A0=A0=A0=
=A0(1 << 2)
> > =A0#=A0=A0=A0=A0=A0=A0define=A0=A0CF_STATUS_BAD_WRITE=A0=A0=A0=A0=A0=
(1 << 1)
> > =A0#=A0=A0=A0=A0=A0=A0define=A0=A0CF_STATUS_CARD_DETECT=A0=A0=A0(1 =
<< 0)
> > =A0
> > =A0/* which chipselect (CS0..CS3) is used for CF (active low) */
> > -#define CF_CFG_REG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__REG16(C=
=46_BASE + 0x02)
> > +#define CF_CFG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(CF_BASE + 0x02)
> > =A0
> >	...
>=20
> Trying to understand the plan here.  This first patches
> are to remove __REG*() access, we hillater patches will=20
> be needed to convert things to omap_readl(BASE + OFFSET)
> style accessors?  (BASE being SOC-specific, and passed
> down from system init code.)
>=20
> Not that CF is a good example of that.  I don't think
> it exists on current chips.  ;)

Well ideally we would set the base offset during driver init, then
just use  __raw_read/write().

But that's lot of work, so it's easier first to convert __REG access
to use omap_read/write(). I'll post multi-omap series as soon as I have
it booting.. But to give you and idea, we can have something like follo=
wing
work for multi-omap.

In arch/arm/Makefile:

arch-$(CONFIG_MULTI_OMAP)       :=3D-D__LINUX_ARM_ARCH__=3D5 $(call cc-=
option,-march=3Darmv5te -Wa$(comma)-march=3Darmv7a,-march=3Darmv6,-marc=
h=3Darmv5t)

This works for 926, arm11 and cortex.


Then in io.h:

#if defined(MULTI_OMAP)
extern unsigned long io_p2v(u32 pa);
extern unsigned long io_v2p(u32 va);
extern unsigned char omap_readb(void __iomem *a);
extern unsigned short omap_readw(void __iomem *a);
extern unsigned long omap_readl(void __iomem *a);
=2E..
#else

#ifdef CONFIG_ARCH_OMAP1

#define io_p2v(pa)	OMAP1_IO_ADDRESS(pa)
#define io_v2p(va)	((va) + OMAP1_IO_OFFSET)

#define omap_readb(a)	(*(volatile unsigned char  *)OMAP1_IO_ADDRESS(a))
#define omap_readw(a)	(*(volatile unsigned short *)OMAP1_IO_ADDRESS(a))
#define omap_readl(a)	(*(volatile unsigned int   *)OMAP1_IO_ADDRESS(a))
=2E..

#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)

#define io_p2v(pa)		 OMAP2_IO_ADDRESS(pa)
#define io_v2p(va)		 ((va) + OMAP2_IO_OFFSET)

#define omap_readb(a)		 (*(volatile unsigned char*)OMAP2_IO_ADDRESS(a))
#define omap_readw(a) (*(volatile unsigned short *)OMAP2_IO_ADDRESS(a))
#define omap_readl(a) (*(volatile unsigned int   *)OMAP2_IO_ADDRESS(a))
=2E..

#endif
#endif


Then in io.c:

unsigned long io_p2v(u32 pa)
{
	if (cpu_class_is_omap1())
		return OMAP1_IO_ADDRESS(pa);
	else
		return OMAP2_IO_ADDRESS(pa);
}

unsigned long io_v2p(u32 va)
{
	if (cpu_class_is_omap1())
		return va + OMAP1_IO_OFFSET;
       else
		return va + OMAP2_IO_OFFSET;
}

unsigned char omap_readb(void __iomem *a)
{
	if (cpu_class_is_omap1())
		return __raw_readb(OMAP1_IO_ADDRESS(a));
	else if (cpu_is_omap24xx())
		return __raw_readb(OMAP24XX_IO_ADDRESS(a));
	else if (cpu_is_omap34xx())

return __raw_readb(OMAP34XX_IO_ADDRESS(a));
=2E..


Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
