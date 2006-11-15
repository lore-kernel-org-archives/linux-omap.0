From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH]  H4 / 2430SDP ethernet IRQ flags fix
Date: Wed, 15 Nov 2006 17:35:51 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01E4220D@DLEE09.ent.ti.com>
References: <20061115232522.GG21064@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20061115232522.GG21064@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

+#ifdef CONFIG_ARCH_OMAP1
+#define	SMC_IRQ_FLAGS	(machine_is_omap_innovator() ?
IRQF_TRIGGER_RISING : \
+				IRQF_TRIGGER_FALLING)
+#else
+#define SMC_IRQ_FLAGS		IRQF_TRIGGER_LOW
+#endif

This looks fine to me, please push this one.

Regards,
Khasim

-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com]=20
Sent: Wednesday, November 15, 2006 5:25 PM
To: Syed Mohammed, Khasim
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] H4 / 2430SDP ethernet IRQ flags fix

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [061110 21:42]:
>=20
> Hi Tony,
>=20
> The attached patch configures the Ethernet IRQ flag on H4 / 2430SDP to
> IRQF_TRIGGER_LOW
>=20
> This has been tested and validated on 2430 SDP and H4 board.
>=20
> Thanks & Regards,
> Khasim

Content-Description: ethernet_fix_H4_2430.patch
> This patch configures the Ethernet IRQ flag on H4 / 2430SDP to
IRQF_TRIGGER_LOW.
>=20
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>=20
> Files changed:
>  smc91x.h |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>=20
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D
> diff -purN linux-omap/drivers/net/smc91x.h
dev-linux-omap-2.6.git/drivers/net/smc91x.h
> --- linux-omap/drivers/net/smc91x.h	2006-11-02 00:16:21.000000000
-0600
> +++ dev-linux-omap-2.6.git/drivers/net/smc91x.h	2006-11-10
13:22:53.000000000 -0600
> @@ -193,11 +193,12 @@ SMC_outw(u16 val, void __iomem *ioaddr,=20
>  #include <asm/arch/cpu.h>
> =20
>  #define	SMC_IRQ_FLAGS (( \
> -		   machine_is_omap_h2() \
> +		machine_is_omap_h2() \
>  		|| machine_is_omap_h3() \
> -		|| machine_is_omap_h4() \
>  		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
> -	) ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING)
> +		)? IRQF_TRIGGER_FALLING : \
> +		((machine_is_omap_h4() || machine_is_omap_2430sdp())? \
> +		IRQF_TRIGGER_LOW : IRQF_TRIGGER_RISING))
> =20
> =20
>  #elif	defined(CONFIG_SH_SH4202_MICRODEV)

Well it's getting messy, and now we need to patch it when new machines
are added.

How about something like the following patch? Does the following patch
work for you?

Regards,

Tony
