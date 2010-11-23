From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] ARM: io: Fix namespace conflicts.
Date: Tue, 23 Nov 2010 18:49:25 +0530
Message-ID: <AANLkTin2VPh5ghrKCnjnC3EjwuPZF4O5aqbAjigJaGFm@mail.gmail.com>
References: <1286967121-5888-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1286967121-5888-1-git-send-email-charu@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

> Having __v as the variable name for the definition of different macros
> leads to
> the namespace pollution. For example,
> readl(p)
> unrolls to:
> ({ u32 __v =3D ({ u32 __v =3D (( __u32)(__le32)(( __le32) ((void)0,
> *(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("mcr
> p15,
> , %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });
>
> ({ u32 __v =3D ({ u32 __v
> causes sparse warning: "warning: symbol '__v' shadows an earlier one"
>
> Using variable names which use the function name prefix across the
> various macros avoids the namespace pollution.
>
> With this change, ~200 sparse warnings in omap2plus_defconfig build are
> fixed.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed by: Nishanth Menon <nm@ti.com>
> ---
> =A0Links related to the previous discussions are as follows:
>
> =A0http://www.spinics.net/lists/linux-omap/msg38569.html
> =A0http://marc.info/?t=3D128506336700011&r=3D1&w=3D2
>
> =A0arch/arm/include/asm/io.h | =A0 32 +++++++++++++++++++++-----------
> =A01 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 1261b1f..01e4a7b 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -131,11 +131,11 @@ static inline void __iomem *__typesafe_io(unsigned
> long addr)
> =A0#define outl(v,p) =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_writel((__force __u=
32) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0cpu_to_le32(v),__io(p))
>
> -#define inb(p) ({ __u8 __v =3D __raw_readb(__io(p)); __v; })
> -#define inw(p) ({ __u16 __v =3D le16_to_cpu((__force __le16) \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readw(__io(p))); __v;=
 })
> -#define inl(p) ({ __u32 __v =3D le32_to_cpu((__force __le32) \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(__io(p))); __v;=
 })
> +#define inb(p) ({ __u8 __inbv =3D __raw_readb(__io(p)); __inbv; })
> +#define inw(p) ({ __u16 __inwv =3D le16_to_cpu((__force __le16) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readw(__io(p))); __in=
wv; })
> +#define inl(p) ({ __u32 __inlv =3D le32_to_cpu((__force __le32) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(__io(p))); __in=
lv; })
>
> =A0#define outsb(p,d,l) =A0 =A0 =A0 =A0 =A0 __raw_writesb(__io(p),d,l)
> =A0#define outsw(p,d,l) =A0 =A0 =A0 =A0 =A0 __raw_writesw(__io(p),d,l)
> @@ -200,9 +200,12 @@ extern void _memset_io(volatile void __iomem *, int,
> size_t);
> =A0#define __iowmb() =A0 =A0 =A0 =A0 =A0 =A0 =A0do { } while (0)
> =A0#endif
>
> -#define readb(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ u8 =A0__v =3D readb_rela=
xed(c); __iormb();
> __v; })
> -#define readw(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ u16 __v =3D readw_relaxe=
d(c); __iormb();
> __v; })
> -#define readl(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ u32 __v =3D readl_relaxe=
d(c); __iormb();
> __v; })
> +#define readb(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ u8 =A0__readbv =3D readb=
_relaxed(c); \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__iormb(); __readbv; })
> +#define readw(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ u16 __readwv =3D readw_r=
elaxed(c); \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__iormb(); __readwv; })
> +#define readl(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ({ u32 __readlv =3D readl_r=
elaxed(c);\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__iormb(); __readlv; })
>
> =A0#define writeb(v,c) =A0 =A0 =A0 =A0 =A0 =A0({ __iowmb(); writeb_relaxe=
d(v,c); })
> =A0#define writew(v,c) =A0 =A0 =A0 =A0 =A0 =A0({ __iowmb(); writew_relaxe=
d(v,c); })
> @@ -258,9 +261,16 @@ extern void _memset_io(volatile void __iomem *, int,
> size_t);
> =A0* io{read,write}{8,16,32} macros
> =A0*/
> =A0#ifndef ioread8
> -#define ioread8(p) =A0 =A0 ({ unsigned int __v =3D __raw_readb(p); __ior=
mb();
> __v; })
> -#define ioread16(p) =A0 =A0({ unsigned int __v =3D le16_to_cpu((__force
> __le16)__raw_readw(p)); __iormb(); __v; })
> -#define ioread32(p) =A0 =A0({ unsigned int __v =3D le32_to_cpu((__force
> __le32)__raw_readl(p)); __iormb(); __v; })
> +#define ioread8(p) =A0 =A0 ({ unsigned int __ioread8v =3D __raw_readb(p)=
; \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__iormb(); __ioread8v; })
> +#define ioread16(p) =A0 =A0({ unsigned int __ioread16v =3D \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0le16_to_cpu((__force __le16) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __raw_readw(p)); __iormb(); \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__ioread16v; })
> +#define ioread32(p) =A0 =A0({ unsigned int __ioread32v =3D \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0le32_to_cpu((__force __le32) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __raw_readl(p)); __iormb(); \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__ioread32v; })
>
> =A0#define iowrite8(v,p) =A0({ __iowmb(); (void)__raw_writeb(v, p); })
> =A0#define iowrite16(v,p) ({ __iowmb(); (void)__raw_writew((__force
> __u16)cpu_to_le16(v), p); })
> --
> 1.7.0.4

> Tony,
> Can you please ack this,if no comments.
