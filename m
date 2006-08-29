From: imre.deak@solidboot.com
Subject: Re: Building kenel error (uImage)
Date: Tue, 29 Aug 2006 14:13:16 +0300
Message-ID: <20060829111316.GC15752@mammoth.research.nokia.com>
References: <EA12F909C0431D458B9D18A176BEE4A5072DA5F6@dlee02.ent.ti.com>
	<20060829104307.77524.qmail@web17808.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060829104307.77524.qmail@web17808.mail.tpe.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kabbin <kabbin26@yahoo.com.tw>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 29, 2006 at 06:43:07PM +0800, kabbin wrote:
> Dear all
>    I use arm-linux-gcc 3.4.1 to build kernel 2.6.10 for omap2420h4
>  (http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-omap=
2430.tgz)
>   with =20
> # make clean
> # make omap_h4_2420_defconfig
> # make uImage
> And I got=20
>=20
>   Kernel: arch/arm/boot/Image is ready
>   Kernel: arch/arm/boot/zImage is ready
>   UIMAGE  arch/arm/boot/uImage
>   "mkimage" command not found - U-Boot images will not be built
    ^^^^

You need the U-Boot mkimage tool, and it's folder in your path.

--Imre
   =20
>   Image arch/arm/boot/uImage is ready
>=20
> I already got Image and zImage,=20
>=20
> but I cannot find uImage in the directory (or any others) !=20
>=20
> It seems that zImage and Image do not work on the target board.
> How can I get uImage ?
> Why "mkimage" command not found?
> Could you tell me any suggestion? Thank you.=20
> Best regards.           =20
>=20
> ___________________________________________________=20
>  =E6=9C=80=E6=96=B0=E7=89=88 Yahoo!=E5=A5=87=E6=91=A9=E5=8D=B3=E6=99=82=
=E9=80=9A=E8=A8=8A 7.0=EF=BC=8C=E5=85=8D=E8=B2=BB=E7=B6=B2=E8=B7=AF=E9=9B=
=BB=E8=A9=B1=E4=BB=BB=E4=BD=A0=E6=89=93=EF=BC=81=20
>  http://messenger.yahoo.com.tw/
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
