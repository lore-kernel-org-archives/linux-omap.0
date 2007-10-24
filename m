From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] include/asm-arm/arch-omap/omap24xx.h
Date: Wed, 24 Oct 2007 19:53:14 +0200
Message-ID: <471F868A.3060106@googlemail.com>
References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com, Tony Lindgren <tony@atomide.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Cargnini wrote:
> I are resubmitting this patch again, because even now this patch was
> not applied on main tree, I upgraded yesterday for the
> linux-2.6.23-omap1 (latest tag)
> and it still not pushed into main tree, please someone add this patch.
>=20
> Signed-off-by: Lu=EDs Vit=F3rio Cargnini <lvcargnini at gmail.com>
>=20
> Signed-off-by: Dirk Behme <dirk.behme at gmail.com
> <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>>
> -------------- next part --------------
> Index: linux-osk/include/asm-arm/arch-omap/omap24xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-osk.orig/include/asm-arm/arch-omap/omap24xx.h
> +++ linux-osk/include/asm-arm/arch-omap/omap24xx.h
> @@ -103,6 +103,11 @@
>=20
>  #endif
>=20
> +#if !defined(OMAP2_CTRL_BASE)
> +/* If no one of the above configs is selected, use default */
> +#define OMAP2_CTRL_BASE		L4_24XX_BASE
> +#endif
> +
>  /* Control module */
>  #define OMAP2_CONTROL_DEVCONF0	(OMAP2_CTRL_BASE + 0x274)
>  #define OMAP2_CONTROL_DEVCONF1	(OMAP2_CTRL_BASE + 0x2e8)

Seems that this wasn't applied because Tony mentioned that this should=20
not be needed any longer:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/01152=
5.html

I didn't check this that time. But checking today, it is still broken.=20
Reproducable by using omap_osk_5912_defconfig with additional MMC=20
enabled. So right, anything like this should be applied.

Cheers

Dirk
