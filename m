From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] OMAP: mailbox and iommu changes: for-next for
	v2.6.38
Date: Thu, 2 Dec 2010 15:20:53 +0000
Message-ID: <20101202152053.GC10461@n2100.arm.linux.org.uk>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com> <20101202123304.GB10461@n2100.arm.linux.org.uk> <AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49408 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713Ab0LBPVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 10:21:13 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Tony Lindgren <tony@atomide.com>, linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernando wrote:
> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
> >> Hi Tony,
> >>
> >> The following changes since commit e8a7e48bb248a1196484d3f8afa53bd=
ed2b24e71:
> >> =A0 Linus Torvalds (1):
> >> =A0 =A0 =A0 =A0 Linux 2.6.37-rc4
> >>
> >> are available in the git repository at:
> >>
> >> =A0 git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.38
> >>
> >> Fernando Guzman Lugo (5):
> >> =A0 =A0 =A0 OMAP: mailbox: change full flag per mailbox queue inst=
ead of global
> >> =A0 =A0 =A0 omap: iovmm - no gap checking for fixed address
> >> =A0 =A0 =A0 omap: iovmm - add superpages support to fixed da addre=
ss
> >> =A0 =A0 =A0 omap: iovmm - replace __iounmap with omap_iounmap
> >
> > This change is wrong. =A0Nothing should be directly referencing oma=
p_iounmap
> > nor for that matter omap_ioremap. =A0Both are implementation detail=
s of the
> > standard ioremap/iounmap APIs.
> >
> > Use the official APIs rather than the implementation details behind=
 them.
>=20
> if you see where the function is used, you will see that it is not
> calling the function, it is use as a parameter in unmap_vm_area(), if
> I used iounmap which is a macro there I will get a compilation error.

Hmm, yes, because iounmap() is defined as a macro rather than iounmap.

The solution to this is to fix iounmap and __arch_iounmap macros so
they aren't macros which take arguments.  That will then allow them
to be used in the way you desire.

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815efa2..91be1f8 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -245,13 +245,13 @@ extern void _memset_io(volatile void __iomem *, i=
nt, size_t);
 #define ioremap_nocache(cookie,size)	__arm_ioremap(cookie, size, MT_DE=
VICE)
 #define ioremap_cached(cookie,size)	__arm_ioremap(cookie, size, MT_DEV=
ICE_CACHED)
 #define ioremap_wc(cookie,size)		__arm_ioremap(cookie, size, MT_DEVICE=
_WC)
-#define iounmap(cookie)			__iounmap(cookie)
+#define iounmap				__iounmap
 #else
 #define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVI=
CE)
 #define ioremap_nocache(cookie,size)	__arch_ioremap((cookie), (size), =
MT_DEVICE)
 #define ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size), M=
T_DEVICE_CACHED)
 #define ioremap_wc(cookie,size)		__arch_ioremap((cookie), (size), MT_D=
EVICE_WC)
-#define iounmap(cookie)			__arch_iounmap(cookie)
+#define iounmap				__arch_iounmap
 #endif
=20
 /*
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/=
include/plat/io.h
index 128b549..204865f 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -294,8 +294,8 @@ static inline void omap44xx_map_common_io(void)
 extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1);
=20
-#define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
-#define __arch_iounmap(v)	omap_iounmap(v)
+#define __arch_ioremap	omap_ioremap
+#define __arch_iounmap	omap_iounmap
=20
 void __iomem *omap_ioremap(unsigned long phys, size_t size, unsigned i=
nt type);
 void omap_iounmap(volatile void __iomem *addr);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
