From: Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] OMAP: McSPI: Fix RX DMA transfer
	path
Date: Sat, 13 Jun 2009 19:37:14 +0300
Message-ID: <877hzgnl8l.fsf@litku.valot.fi>
References: <1244809910-4014-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1244809910-4014-1-git-send-email-aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> (Aaro
	Koskinen's message of "Fri\, 12 Jun 2009 15\:31\:50 +0300")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> writes:

> From: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>
> When data is read through DMA, the last element must be read separately
> through the RX register. It cannot be transferred by the DMA. For further
> details see e.g. OMAP3430 TRM.
>
> Without the fix the driver causes extra clocks to be clocked to the
> bus after DMA RX operations. This can cause interesting behaviour with
> some devices.

I was hit by this with stlc45xx and earlier versions of Juuso's patch at
least fixed the problem.

I will test this patch as soon as I get N800 boot with latest
linux-omap, now I only get this:

<6>JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
<6>JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red H
<6>msgmni has been set to 247
<6>io scheduler noop registered (default)
<6>omapfb: ls041y3 rev 87 LCD detected, 0 data lines      d
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
<6>serial8250.0: ttyS1 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
<=F3"F:=AD5 #!*$=D5<=F3=AC#0=AD5 #!*$=D5<=F3=ADr%
=B5=B2=B2 =E62=D5<=F3$=B6=A0#=AE*#5##=B9'%=D5<=F3#62=B0$=B6=A0=B9)K!=A5=BA=
=B9'=D5<=F3=AC=B95 K#z=A00=AB=B2)=D1%f=A1T:6=E60=AA=FF<=F3=AF
=F3
%=B0=F62=AD=D5=B3#=B2=A9T=A0=F4=AD#.#=C9=A0,=AD#2=AC#=A3=B50V=B3/=AD5 V=A7=
=CD#%R=ED<=F300=A2F=A0=F4-=A0=B9##=A3$=B6=A0+3S=ED<=F3
0
=B7#
  # V60=B1:)=A5#
,#=B5=A5=D546=A0V#=D5#
=AC=E9)=B6.=B9=AA=FF<=F3=B5&=A3=C9%=B2:=A9F%V$=AE=BA=A0=B9##=A3$=B6
=A0=CD#=C9=A1*=AA=FF<=F3=B5&=A0                           =A9#=AD0=C1:=A3=
=B5=AD.#=B5=A5=D54#=D4#K=AA=FF#=F3#=CD!=C4)
 %
=B33{%=B0=F62=AD=B19=B1S=ED<=F3"=D5=A0{/+#=ED#=F3#=CD!=C4)4?+#=ED#=F3#=CD!=
=C4)4=F3=A0=F6=A3U4=AC=B9=A0=B9)K!)=BA"=AA=FF<=F3"=D5%{/C:=B3=F4
=D9=AF    s
=AE=D1=A0=AE=AE=D2 335<#U2,=B0=AE!=C4)=A0=A0=F42V#"=F6/=EB"=A2#4/##=AE#%!V =
C%!


-- =

Kalle Valo

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
