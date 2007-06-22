From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 2/12] head.S changes to CPU ID
Date: Fri, 22 Jun 2007 17:31:16 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012F8BC7@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011E6091@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E6091@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

>-----Original Message-----
>From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com
>[mailto:linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com]=
 On
>Behalf Of Syed Mohammed, Khasim
>Sent: Thursday, June 14, 2007 12:00 AM
>To: Linux OMAP
>Subject: [PATCH 2/12] head.S changes to CPU ID
>
>Updated head.S CPU ID to consider OMAP3 ARCH Cortex processor.
>
>Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>
>Files:
> arch/arm/boot/compressed/head.S
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>diff -purN linux-omap/arch/arm/boot/compressed/head.S
>val_3430_GIT/arch/arm/boot/compressed/head.S
>--- linux-omap/arch/arm/boot/compressed/head.S	2007-06-12
>15:08:45.000000000 -0500
>+++ val_3430_GIT/arch/arm/boot/compressed/head.S	2007-06-12
>17:06:57.000000000 -0500
>@@ -646,8 +646,8 @@ proc_types:
> 		b	__armv4_mmu_cache_off
> 		b	__armv6_mmu_cache_flush
>
>-		.word	0x000f0000		@ new CPU Id
>-		.word	0x000f0000
>+		.word	0x000fc000		@ new CPU Id
>+		.word	0x000ff000
> 		b	__armv7_mmu_cache_on
> 		b	__armv7_mmu_cache_off
> 		b	__armv7_mmu_cache_flush

Please discard this patch. I found these changes were actually not =
required to get kernel booting on OMAP3430.

Please consider the one posted before this (today).
	Subject: [PATCH] Enable Kernel based uncompressing for OMAP3

Regards,
Khasim
